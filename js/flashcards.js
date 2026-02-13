/* ============================================
   flashcards.js — Wyświetlanie fiszek
   Ładuje phrasal verbs, prezentuje pytanie/odpowiedź,
   zapisuje wyniki przez SM2.saveAnswer()
   ============================================ */

const Flashcards = {
  queue: [],          // kolejka fiszek do przerobienia w sesji
  currentIndex: 0,    // aktualny indeks w kolejce
  sessionResults: [], // wyniki sesji: { verb, known }
  sessionStart: null, // czas rozpoczęcia sesji
  _saveQueue: [],     // kolejka zapisów SM2 (sekwencyjna, nie równoległa)
  _saving: false,     // czy aktualnie trwa zapis do bazy
  dailyKey: null,
  dailyNewTarget: 0,
  dailyNewDone: 0,
  remainingPhaseCIds: [],
  phaseAEnd: 0,
  phaseBEnd: 0,
  goalReached: false,
  inPhaseC: false,
  _loadingMore: false,

  /**
   * Rozpocznij sesję nauki
   */
  async start() {
    this.queue = [];
    this.currentIndex = 0;
    this.sessionResults = [];
    this.sessionStart = new Date();
    this.goalReached = false;
    this.inPhaseC = false;
    this._loadingMore = false;

    const flashcard = document.getElementById('flashcard');
    flashcard.innerHTML = '<div class="loading-text"><span class="spinner"></span> Ładowanie fiszek...</div>';

    try {
      await this.loadQueue();

      if (this.queue.length === 0 && this.remainingPhaseCIds.length === 0) {
        flashcard.innerHTML = `
          <div class="text-center" style="padding: 48px 24px;">
            <p style="font-size: 1.2rem; margin-bottom: 16px;">Brak fiszek na dziś!</p>
            <p class="text-muted">Wróć jutro na kolejne powtórki.</p>
            <button class="btn btn-outline mt-24" onclick="App.showScreen('home')">Wróć do ekranu głównego</button>
          </div>`;
        return;
      }

      if (this.phaseBEnd === 0 && this.remainingPhaseCIds.length > 0) {
        // Brak nowych dziennych i powtórek — pokaż komunikat celu od razu
        this.goalReached = true;
        this.showGoalReached();
        return;
      }

      this.showQuestion();
    } catch (err) {
      console.error('Błąd ładowania fiszek:', err);
      flashcard.innerHTML = `<div class="alert alert-error">Błąd ładowania: ${err.message}</div>`;
    }

    // Przycisk zamknięcia sesji
    document.getElementById('flashcard-close').onclick = () => {
      if (this.sessionResults.length > 0) {
        this.endSession();
      } else {
        App.showScreen('home');
      }
    };
  },

  /**
   * Załaduj kolejkę: zaległe powtórki + WSZYSTKIE nowe phrasal verbs
   * Brak twardego limitu — użytkownik ma dostęp do całego repozytorium.
   * daily_goal służy tylko jako próg motywacyjny (komunikat zachęty).
   */
  async loadQueue() {
    const userId = Auth.currentUser.id;
    const now = new Date().toISOString();
    this.dailyKey = this.getLocalDateKey();
    this.dailyNewTarget = Auth.currentProfile.daily_goal || 10;
    const difficultyFilter = (Auth.currentProfile && Auth.currentProfile.difficulty_filter) || 'all';
    this.goalReached = false;
    this.inPhaseC = false;
    this.remainingPhaseCIds = [];

    // 1. Zaległe — phrasal verbs z next_review <= teraz
    const { data: overdue, error: overdueErr } = await supabase
      .from('user_progress')
      .select('verb_id, next_review')
      .eq('user_id', userId)
      .lte('next_review', now)
      .order('next_review', { ascending: true });

    if (overdueErr) throw overdueErr;

    const overdueVerbIds = (overdue || []).map(p => p.verb_id);

    // 2. Nowe — WSZYSTKIE phrasal verbs których użytkownik jeszcze nie widział
    const { data: seen } = await supabase
      .from('user_progress')
      .select('verb_id')
      .eq('user_id', userId);

    const seenIds = (seen || []).map(p => p.verb_id);

    let verbsQuery = supabase
      .from('phrasal_verbs')
      .select('id')
      .order('id', { ascending: true });

    if (difficultyFilter !== 'all') {
      verbsQuery = verbsQuery.eq('difficulty', difficultyFilter);
    }

    const { data: allVerbs } = await verbsQuery;

    const unseenIds = (allVerbs || [])
      .map(v => v.id)
      .filter(id => !seenIds.includes(id));

    // 3. Liczba nowych zrobionych dziś
    let dailyNewQuery = supabase
      .from('user_progress')
      .select('id', { count: 'exact', head: true })
      .eq('user_id', userId)
      .eq('first_seen_on', this.dailyKey);

    if (difficultyFilter !== 'all') {
      dailyNewQuery = supabase
        .from('user_progress')
        .select('id, phrasal_verbs!inner(difficulty)', { count: 'exact', head: true })
        .eq('user_id', userId)
        .eq('first_seen_on', this.dailyKey)
        .eq('phrasal_verbs.difficulty', difficultyFilter);
    }

    const { count: dailyNewDone, error: dailyNewErr } = await dailyNewQuery;

    if (dailyNewErr) throw dailyNewErr;

    this.dailyNewDone = dailyNewDone || 0;
    const dailyNewRemaining = Math.max(0, this.dailyNewTarget - this.dailyNewDone);

    // 4. Dzienna losowość (stabilna w ciągu dnia)
    const sortedNewIds = this.sortDailyNewIds(unseenIds, userId, this.dailyKey);

    // Etap A: dzienny pakiet nowych
    const phaseAIds = sortedNewIds.slice(0, dailyNewRemaining);

    // Etap C: pozostałe nowe (opcjonalne po "Kontynuuj")
    this.remainingPhaseCIds = sortedNewIds.slice(dailyNewRemaining);

    // Etap B: zaległe powtórki
    const initialIds = [...phaseAIds, ...overdueVerbIds];

    this.phaseAEnd = phaseAIds.length;
    this.phaseBEnd = phaseAIds.length + overdueVerbIds.length;

    this.queue = await this.fetchVerbsByIds(initialIds);
  },

  /**
   * Pokaż stan pytania (phrasal verb + wiem/nie wiem)
   */
  showQuestion() {
    const verb = this.queue[this.currentIndex];
    if (!verb) return;

    this.updateCounter();

    const flashcard = document.getElementById('flashcard');
    flashcard.innerHTML = `
      <div class="flashcard-verb">${this.escapeHtml(verb.verb)}</div>
      <div class="flashcard-tags">
        <span class="tag tag-${verb.category}">${verb.category}</span>
        <span class="tag tag-${verb.register}">${verb.register}</span>
        <span class="tag tag-tense">${verb.difficulty}</span>
      </div>
      <button class="speak-btn" onclick="Flashcards.speak('${this.escapeAttr(verb.verb)}')" title="Wymowa">
        &#128264;
      </button>
      <div class="flashcard-actions">
        <button class="btn btn-green btn-lg" onclick="Flashcards.answer(true)">Wiem &#10003;</button>
        <button class="btn btn-red btn-lg" onclick="Flashcards.answer(false)">Nie wiem &#10007;</button>
      </div>
    `;
  },

  /**
   * Obsłuż odpowiedź użytkownika
   */
  async answer(known) {
    const verb = this.queue[this.currentIndex];
    if (!verb) return;

    // Zapisz wynik sesji
    this.sessionResults.push({
      verb: verb.verb,
      verbId: verb.id,
      known: known
    });

    // Dodaj do kolejki zapisów (sekwencyjnie, nie równolegle)
    this.enqueueSave(Auth.currentUser.id, verb.id, known, this.dailyKey);

    // Pokaż odpowiedź
    this.showAnswer(verb, known);
  },

  /**
   * Pokaż stan odpowiedzi (definicja + przykłady)
   */
  showAnswer(verb, known) {
    const flashcard = document.getElementById('flashcard');
    const resultClass = known ? 'green' : 'red';
    const resultText = known ? 'Wiem &#10003;' : 'Nie wiem &#10007;';

    // Podświetl phrasal verb w zdaniach przykładowych
    const examples = (verb.examples || []).map(ex => {
      const sentence = this.highlightVerb(ex.sentence, verb.verb);
      return `
        <div class="example-item">
          <div class="example-sentence">
            ${sentence}
            <button class="example-speak" onclick="Flashcards.speak('${this.escapeAttr(ex.sentence)}')" title="Wymowa">&#128264;</button>
          </div>
          <div class="example-meta">
            <span class="tag tag-tense">${this.escapeHtml(ex.tense)}</span>
            <span class="tag tag-context">${this.escapeHtml(ex.context)}</span>
          </div>
        </div>`;
    }).join('');

    flashcard.innerHTML = `
      <div class="flashcard-verb">${this.escapeHtml(verb.verb)}</div>
      <div class="flashcard-tags">
        <span class="tag tag-${verb.category}">${verb.category}</span>
        <span class="tag tag-${verb.register}">${verb.register}</span>
        <span class="tag tag-tense">${verb.difficulty}</span>
        <span class="tag tag-${resultClass}" style="background: var(--${resultClass}-bg); color: var(--${resultClass});">${resultText}</span>
      </div>

      <div class="answer-section">
        <div class="answer-definition">
          ${this.escapeHtml(verb.definition_en)}
        </div>

        <div class="answer-translation">
          <button class="translation-toggle" onclick="this.nextElementSibling.classList.toggle('visible')">
            &#128065; Pokaż tłumaczenie PL
          </button>
          <div class="translation-text">${this.escapeHtml(verb.translation_pl)}</div>
        </div>

        <div class="answer-examples">
          <h4>Przykłady</h4>
          ${examples}
        </div>

        <button class="btn btn-primary next-btn" onclick="Flashcards.next()">
          ${this.currentIndex < this.queue.length - 1 ? 'Dalej &rarr;' : 'Zakończ sesję'}
        </button>
      </div>
    `;
  },

  /**
   * Przejdź do następnej fiszki lub zakończ sesję
   */
  async next() {
    this.currentIndex++;

    // Po ukończeniu etapów A + B pokaż komunikat o celu dziennym
    if (!this.goalReached && this.currentIndex === this.phaseBEnd) {
      this.goalReached = true;
      this.showGoalReached();
      return;
    }

    if (this.currentIndex >= this.queue.length) {
      if (this.inPhaseC && this.remainingPhaseCIds.length > 0) {
        await this.appendPhaseCChunk();
        this.showQuestion();
        return;
      }

      this.endSession();
      return;
    }

    this.showQuestion();
  },

  /**
   * Pokaż komunikat o osiągnięciu celu dziennego
   */
  showGoalReached() {
    const remainingNew = this.remainingPhaseCIds.length;
    const flashcard = document.getElementById('flashcard');
    flashcard.innerHTML = `
      <div class="text-center" style="padding: 32px 24px;">
        <div style="font-size: 2.5rem; margin-bottom: 12px;">&#127942;</div>
        <h2 style="margin-bottom: 8px; color: var(--green);">Cel dzienny osiągnięty!</h2>
        <p class="text-muted mb-24">Nowe fiszki i powtórki na dziś są zrobione.</p>
        ${remainingNew > 0 ? `
          <p class="mb-24">Zostało jeszcze <strong>${remainingNew}</strong> nowych fiszek do przerobienia.</p>
        ` : `
          <p class="mb-24 text-muted">Brak kolejnych nowych fiszek na dziś.</p>
        `}
        <button class="btn btn-primary btn-lg mb-16" style="width:100%;" onclick="Flashcards.continueAfterGoal()">Kontynuuj naukę</button>
        <button class="btn btn-outline btn-lg" style="width:100%;" onclick="Flashcards.endSession()">Zakończ sesję</button>
      </div>
    `;
  },

  /**
   * Kontynuuj naukę po osiągnięciu celu
   */
  async continueAfterGoal() {
    this.inPhaseC = true;

    if (this.remainingPhaseCIds.length === 0) {
      this.endSession();
      return;
    }

    if (this.currentIndex >= this.queue.length) {
      await this.appendPhaseCChunk();
      this.showQuestion();
      return;
    }

    this.showQuestion();
  },

  /**
   * Aktualizuj licznik w nagłówku (Nowe / Powtórki / brak)
   */
  updateCounter() {
    const counter = document.getElementById('flashcard-counter');
    if (!counter) return;

    let text = '';
    if (this.currentIndex < this.phaseAEnd) {
      text = `Nowe: pozostało ${this.phaseAEnd - this.currentIndex}`;
    } else if (this.currentIndex < this.phaseBEnd) {
      text = `Powtórki: pozostało ${this.phaseBEnd - this.currentIndex}`;
    }

    counter.textContent = text;
    counter.classList.toggle('hidden', text === '');
  },

  /**
   * Lokalny klucz dnia w formacie YYYY-MM-DD
   */
  getLocalDateKey(date = new Date()) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  },

  /**
   * Deterministyczny hash dla losowania dziennego
   */
  hashString(str) {
    let hash = 5381;
    for (let i = 0; i < str.length; i++) {
      hash = ((hash << 5) + hash) + str.charCodeAt(i);
    }
    return hash >>> 0;
  },

  dailyShuffleKey(userId, dailyKey, verbId) {
    return this.hashString(`${userId}|${dailyKey}|${verbId}`);
  },

  sortDailyNewIds(ids, userId, dailyKey) {
    return [...ids].sort((a, b) => {
      const keyA = this.dailyShuffleKey(userId, dailyKey, a);
      const keyB = this.dailyShuffleKey(userId, dailyKey, b);
      if (keyA !== keyB) return keyA - keyB;
      return a - b;
    });
  },

  async fetchVerbsByIds(ids) {
    if (!ids || ids.length === 0) return [];
    const BATCH_SIZE = 50;
    const verbMap = {};

    for (let i = 0; i < ids.length; i += BATCH_SIZE) {
      const batchIds = ids.slice(i, i + BATCH_SIZE);
      const { data: verbs, error: verbsErr } = await supabase
        .from('phrasal_verbs')
        .select('*')
        .in('id', batchIds);

      if (verbsErr) throw verbsErr;
      (verbs || []).forEach(v => { verbMap[v.id] = v; });
    }

    return ids.map(id => verbMap[id]).filter(v => v !== undefined);
  },

  async appendPhaseCChunk() {
    if (this._loadingMore) return;
    this._loadingMore = true;
    const BATCH_SIZE = 50;
    const nextIds = this.remainingPhaseCIds.slice(0, BATCH_SIZE);
    this.remainingPhaseCIds = this.remainingPhaseCIds.slice(BATCH_SIZE);

    if (nextIds.length === 0) {
      this._loadingMore = false;
      return;
    }

    try {
      const nextVerbs = await this.fetchVerbsByIds(nextIds);
      this.queue = this.queue.concat(nextVerbs);
    } finally {
      this._loadingMore = false;
    }
  },

  /**
   * Kolejkuj zapis SM2 — wykonuje zapisy jeden po drugim,
   * zamiast bombardować bazę wieloma równoległymi requestami.
   */
  enqueueSave(userId, verbId, known, dailyKey) {
    this._saveQueue.push({ userId, verbId, known, dailyKey });
    this._processSaveQueue();
  },

  async _processSaveQueue() {
    if (this._saving || this._saveQueue.length === 0) return;
    this._saving = true;

    while (this._saveQueue.length > 0) {
      const { userId, verbId, known, dailyKey } = this._saveQueue.shift();
      try {
        await SM2.saveAnswer(userId, verbId, known, dailyKey);
      } catch (err) {
        console.error('Błąd zapisu SM2:', err);
      }
    }

    this._saving = false;
  },

  /**
   * Poczekaj aż wszystkie zapisy SM2 się zakończą
   * (wywoływane przed endSession, żeby dane były kompletne)
   */
  async _waitForSaves() {
    // Jeśli kolejka jest pusta i nic nie zapisuje — wróć od razu
    if (this._saveQueue.length === 0 && !this._saving) return;

    // Czekaj max 10 sekund
    const deadline = Date.now() + 10000;
    while ((this._saveQueue.length > 0 || this._saving) && Date.now() < deadline) {
      await new Promise(r => setTimeout(r, 100));
    }
  },

  /**
   * Zakończ sesję — zapisz log i pokaż podsumowanie
   */
  async endSession() {
    // Poczekaj na zakończenie zapisów SM2 w tle
    await this._waitForSaves();
    const duration = Math.round((new Date() - this.sessionStart) / 1000);
    const totalReviewed = this.sessionResults.length;
    const totalKnown = this.sessionResults.filter(r => r.known).length;
    const totalUnknown = totalReviewed - totalKnown;

    // Zapisz session_log do bazy
    try {
      await supabase.from('session_log').insert({
        user_id: Auth.currentUser.id,
        date: new Date().toISOString().split('T')[0],
        total_reviewed: totalReviewed,
        total_known: totalKnown,
        total_unknown: totalUnknown,
        duration_seconds: duration
      });

      // Aktualizuj streak
      await this.updateStreak();
    } catch (err) {
      console.error('Błąd zapisu sesji:', err);
    }

    // Pokaż podsumowanie
    this.showSummary(totalReviewed, totalKnown, totalUnknown, duration);
  },

  /**
   * Aktualizuj streak (serię dni nauki)
   */
  async updateStreak() {
    const userId = Auth.currentUser.id;
    const today = new Date().toISOString().split('T')[0];

    const { data: streak } = await supabase
      .from('streaks')
      .select('*')
      .eq('user_id', userId)
      .single();

    if (!streak) {
      // Pierwszy raz — utwórz rekord
      await supabase.from('streaks').insert({
        user_id: userId,
        current_streak: 1,
        longest_streak: 1,
        last_active_date: today
      });
      return;
    }

    // Oblicz różnicę dni
    const lastDate = new Date(streak.last_active_date);
    const todayDate = new Date(today);
    const diffDays = Math.floor((todayDate - lastDate) / (1000 * 60 * 60 * 24));

    let newStreak = streak.current_streak;

    if (diffDays === 0) {
      // Już dziś był aktywny — nic nie zmieniaj
      return;
    } else if (diffDays === 1) {
      // Kontynuacja serii
      newStreak += 1;
    } else {
      // Przerwa — reset serii
      newStreak = 1;
    }

    const longestStreak = Math.max(newStreak, streak.longest_streak);

    await supabase
      .from('streaks')
      .update({
        current_streak: newStreak,
        longest_streak: longestStreak,
        last_active_date: today
      })
      .eq('user_id', userId);
  },

  /**
   * Pokaż ekran podsumowania sesji
   */
  showSummary(total, known, unknown, duration) {
    const percent = total > 0 ? Math.round((known / total) * 100) : 0;
    const minutes = Math.floor(duration / 60);
    const seconds = duration % 60;
    const timeStr = minutes > 0 ? `${minutes} min ${seconds} s` : `${seconds} s`;

    // Lista phrasal verbs z "nie wiem"
    const mistakes = this.sessionResults.filter(r => !r.known);
    let mistakesHtml = '';
    if (mistakes.length > 0) {
      mistakesHtml = `
        <div class="summary-mistakes">
          <h4>Do powtórki (odpowiedź "nie wiem")</h4>
          ${mistakes.map(m => `<div class="mistake-item">${this.escapeHtml(m.verb)}</div>`).join('')}
        </div>`;
    }

    App.showScreen('summary');
    const container = document.getElementById('summary-content');
    container.innerHTML = `
      <div class="summary-title">Sesja zakończona!</div>
      <div class="summary-stats">
        <div class="summary-stat">
          <div class="stat-value">${total}</div>
          <div class="stat-label">Przerobione</div>
        </div>
        <div class="summary-stat">
          <div class="stat-value green">${known}</div>
          <div class="stat-label">Wiem</div>
        </div>
        <div class="summary-stat">
          <div class="stat-value red">${unknown}</div>
          <div class="stat-label">Nie wiem</div>
        </div>
        <div class="summary-stat">
          <div class="stat-value accent">${percent}%</div>
          <div class="stat-label">Poprawnych</div>
        </div>
      </div>
      <p class="text-muted mb-16">Czas: ${timeStr}</p>
      ${mistakesHtml}
      <button class="btn btn-primary btn-lg" onclick="App.showScreen('home')">Wróć do ekranu głównego</button>
    `;
  },

  /**
   * Wymowa tekstu — deleguje do modułu Speech
   */
  speak(text) {
    Speech.speak(text);
  },

  /**
   * Podświetl phrasal verb w zdaniu (pogrubienie)
   */
  // Słownik czasowników nieregularnych (formy przeszłe)
  IRREGULAR_VERBS: {
    'bring': 'brought', 'buy': 'bought', 'catch': 'caught', 'come': 'came',
    'do': 'did|done', 'drink': 'drank|drunk', 'drive': 'drove|driven',
    'eat': 'ate|eaten', 'fall': 'fell|fallen', 'feel': 'felt', 'find': 'found',
    'fly': 'flew|flown', 'get': 'got|gotten', 'give': 'gave|given', 'go': 'went|gone',
    'have': 'had', 'hear': 'heard', 'hold': 'held', 'keep': 'kept', 'know': 'knew|known',
    'leave': 'left', 'lose': 'lost', 'make': 'made', 'meet': 'met', 'pay': 'paid',
    'put': 'put', 'run': 'ran|run', 'say': 'said', 'see': 'saw|seen', 'sell': 'sold',
    'send': 'sent', 'set': 'set', 'sit': 'sat', 'speak': 'spoke|spoken',
    'stand': 'stood', 'take': 'took|taken', 'tell': 'told', 'think': 'thought',
    'write': 'wrote|written', 'break': 'broke|broken', 'wear': 'wore|worn',
    'throw': 'threw|thrown', 'win': 'won', 'fight': 'fought', 'teach': 'taught',
    'grow': 'grew|grown', 'cut': 'cut', 'hit': 'hit', 'build': 'built'
  },

  /**
   * Podświetl phrasal verb w zdaniu (pogrubienie)
   * Obsługuje:
   * 1. Formy regularne (s, ing, ed)
   * 2. Formy nieregularne (zdefiniowane w IRREGULAR_VERBS)
   * 3. Rozdzielenie (np. "bring it up") - do 3 słów pomiędzy
   */
  highlightVerb(sentence, verb) {
    if (!verb || !sentence) return sentence;

    const escaped = this.escapeHtml(sentence);
    const verbParts = verb.toLowerCase().split(' ');

    // Zakładamy typowy phrasal verb: "bring up" (czasownik + partykuła)
    if (verbParts.length < 2) return escaped;

    const base = verbParts[0];
    // Obsługa phrasal verbs z więcej niż 1 partykułą np. "catch up with"
    // Partykuła to wszystko po czasowniku
    const particle = verbParts.slice(1).join('\\s+');

    // Budowanie wzorca dla części czasownikowej
    // 1. Base + końcówki: bring, brings, bringing
    // 2. Nieregularne: brought

    // Zaczynamy od bazy
    let verbPattern = base;

    // Dodajemy formy nieregularne jeśli istnieją
    if (this.IRREGULAR_VERBS[base]) {
      verbPattern += `|${this.IRREGULAR_VERBS[base]}`;
    }

    // Konstrukcja Regexa:
    // \b                             -> granica słowa
    // (                              -> grupa 1: czasownik w różnych formach
    //   (?:VERB_PATTERN)             -> baza lub nieregularne
    //   |                            -> LUB
    //   \w*BASE\w*                   -> słowo zawierające bazę (np. brings, bringing - fallback)
    // )
    // \b                             -> granica słowa dla czasownika
    // (?:                            -> grupa nieschwytująca dla odstępu
    //   \s+                          -> spacja
    //   (?:[\w']+\s+){0,3}           -> opcjonalnie 0-3 słów (np. zaimki "it", "him")
    // )?                             -> cała grupa odstępu jest opcjonalna
    // PARTICLE                       -> partykuła (np. up)

    // Prostsza wersja regexa, która powinna wystarczyć:
    // Szukamy słowa, które jest bazą/nieregularnym LUB zawiera bazę (dla suffixów)
    const verbRegexPart = `(?:${verbPattern}|\\w*${base}\\w*)`;

    // Szukamy partykuły po odstępie (max 3 słowa)
    const regexStr = `\\b(${verbRegexPart})\\b(?:\\s+(?:[\\w']+\\s+){0,3})?${particle}`;

    try {
      const regex = new RegExp(`(${regexStr})`, 'gi');
      // $1 to całe dopasowanie (czasownik + odstęp + partykuła)
      // Ale uwaga: regex powyżej ma grupę w środku.
      // Uproszczamy replace: po prostu łapiemy całość

      return escaped.replace(regex, '<strong>$&</strong>');
    } catch (e) {
      console.warn('Regex error for verb:', verb, e);
      return escaped;
    }
  },

  // --- Helpers ---
  escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str || '';
    return div.innerHTML;
  },

  escapeAttr(str) {
    return (str || '').replace(/'/g, "\\'").replace(/"/g, '&quot;');
  }
};
