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

  /**
   * Rozpocznij sesję nauki
   */
  async start() {
    this.queue = [];
    this.currentIndex = 0;
    this.sessionResults = [];
    this.sessionStart = new Date();

    const flashcard = document.getElementById('flashcard');
    flashcard.innerHTML = '<div class="loading-text"><span class="spinner"></span> Ładowanie fiszek...</div>';

    try {
      await this.loadQueue();

      if (this.queue.length === 0) {
        flashcard.innerHTML = `
          <div class="text-center" style="padding: 48px 24px;">
            <p style="font-size: 1.2rem; margin-bottom: 16px;">Brak fiszek na dziś!</p>
            <p class="text-muted">Wróć jutro na kolejne powtórki.</p>
            <button class="btn btn-outline mt-24" onclick="App.showScreen('home')">Wróć do ekranu głównego</button>
          </div>`;
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
    this.dailyGoal = Auth.currentProfile.daily_goal || 10;
    this.goalReached = false;

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

    const { data: allVerbs } = await supabase
      .from('phrasal_verbs')
      .select('id')
      .order('id', { ascending: true });

    const newVerbIds = (allVerbs || [])
      .map(v => v.id)
      .filter(id => !seenIds.includes(id));

    // 3. Połącz kolejkę: zaległe najpierw, potem nowe
    const allIds = [...overdueVerbIds, ...newVerbIds];

    if (allIds.length === 0) {
      this.queue = [];
      return;
    }

    // Pobierz pełne dane phrasal verbs (Supabase .in() limit: 300 — mieścimy się)
    const { data: verbs, error: verbsErr } = await supabase
      .from('phrasal_verbs')
      .select('*')
      .in('id', allIds);

    if (verbsErr) throw verbsErr;

    // Zachowaj kolejność: zaległe (od najstarszych) → nowe (po ID)
    const verbMap = {};
    (verbs || []).forEach(v => { verbMap[v.id] = v; });

    this.queue = allIds
      .map(id => verbMap[id])
      .filter(v => v !== undefined);
  },

  /**
   * Pokaż stan pytania (phrasal verb + wiem/nie wiem)
   */
  showQuestion() {
    const verb = this.queue[this.currentIndex];
    if (!verb) return;

    const counter = document.getElementById('flashcard-counter');
    counter.textContent = `${this.currentIndex + 1} / ${this.queue.length}`;

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

    // Zapisz do bazy przez SM-2 (w tle)
    SM2.saveAnswer(Auth.currentUser.id, verb.id, known).catch(err => {
      console.error('Błąd zapisu SM2:', err);
    });

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
  next() {
    this.currentIndex++;

    // Komunikat zachęty po osiągnięciu celu dziennego
    if (!this.goalReached && this.sessionResults.length >= this.dailyGoal) {
      this.goalReached = true;
      this.showGoalReached();
      return;
    }

    if (this.currentIndex >= this.queue.length) {
      this.endSession();
    } else {
      this.showQuestion();
    }
  },

  /**
   * Pokaż komunikat o osiągnięciu celu dziennego
   */
  showGoalReached() {
    const remaining = this.queue.length - this.currentIndex;
    const flashcard = document.getElementById('flashcard');
    flashcard.innerHTML = `
      <div class="text-center" style="padding: 32px 24px;">
        <div style="font-size: 2.5rem; margin-bottom: 12px;">&#127942;</div>
        <h2 style="margin-bottom: 8px; color: var(--green);">Cel dzienny osiągnięty!</h2>
        <p class="text-muted mb-24">Przerobiłeś już ${this.dailyGoal} fiszek. Świetna robota!</p>
        ${remaining > 0 ? `
          <p class="mb-24">Zostało jeszcze <strong>${remaining}</strong> fiszek do przerobienia.</p>
          <button class="btn btn-primary btn-lg mb-16" style="width:100%;" onclick="Flashcards.continueAfterGoal()">Kontynuuj naukę</button>
        ` : ''}
        <button class="btn btn-outline btn-lg" style="width:100%;" onclick="Flashcards.endSession()">Zakończ sesję</button>
      </div>
    `;
  },

  /**
   * Kontynuuj naukę po osiągnięciu celu
   */
  continueAfterGoal() {
    if (this.currentIndex >= this.queue.length) {
      this.endSession();
    } else {
      this.showQuestion();
    }
  },

  /**
   * Zakończ sesję — zapisz log i pokaż podsumowanie
   */
  async endSession() {
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
  highlightVerb(sentence, verb) {
    const escaped = this.escapeHtml(sentence);
    const verbParts = verb.toLowerCase().split(' ');

    // Spróbuj znaleźć phrasal verb w różnych formach
    // np. "bring up" → "brought up", "bringing up", "brings up"
    // Prosty sposób: podświetl ostatnie słowo (partykułę) i ewentualne formy base verb
    const particle = verbParts[verbParts.length - 1];
    const baseVerb = verbParts[0];

    // Podświetl dokładne dopasowanie phrasal verb
    const regex = new RegExp(`\\b(\\w*${baseVerb}\\w*\\s+${particle})\\b`, 'gi');
    return escaped.replace(regex, '<strong>$1</strong>');
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
