/* ============================================
   quiz.js — Tryb Quiz (phrasal verb → wybierz definicję)
   Pokazuje phrasal verb i 4 definicje do wyboru.
   Poprawna odpowiedź = "wiem" w SM-2, błędna = "nie wiem".
   ============================================ */

const Quiz = {
  queue: [],           // fiszki do quizu
  allVerbs: [],        // WSZYSTKIE phrasal verbs (do generowania fałszywych opcji)
  currentIndex: 0,
  sessionResults: [],
  sessionStart: null,
  _saveQueue: [],
  _saving: false,
  dailyGoal: 10,
  goalReached: false,
  _answered: false,    // blokada podwójnego kliknięcia

  /**
   * Rozpocznij sesję quizu
   */
  async start() {
    this.queue = [];
    this.allVerbs = [];
    this.currentIndex = 0;
    this.sessionResults = [];
    this.sessionStart = new Date();
    this._answered = false;

    const content = document.getElementById('quiz-content');
    content.innerHTML = '<div class="loading-text"><span class="spinner"></span> Ładowanie quizu...</div>';

    try {
      await this.loadQueue();

      if (this.queue.length === 0) {
        content.innerHTML = `
          <div class="text-center" style="padding: 48px 24px;">
            <p style="font-size: 1.2rem; margin-bottom: 16px;">Brak fiszek na dziś!</p>
            <p class="text-muted">Wróć jutro na kolejne powtórki.</p>
            <button class="btn btn-outline mt-24" onclick="App.showScreen('home')">Wróć do ekranu głównego</button>
          </div>`;
        return;
      }

      this.showQuestion();
    } catch (err) {
      console.error('Błąd ładowania quizu:', err);
      content.innerHTML = `<div class="alert alert-error">Błąd ładowania: ${err.message}</div>`;
    }

    // Przycisk zamknięcia sesji
    document.getElementById('quiz-close').onclick = () => {
      if (this.sessionResults.length > 0) {
        this.endSession();
      } else {
        App.showScreen('home');
      }
    };
  },

  /**
   * Załaduj kolejkę: zaległe powtórki + nowe phrasal verbs
   * Dodatkowo załaduj WSZYSTKIE phrasal verbs do generowania opcji
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

    // 3. Pobierz WSZYSTKIE phrasal verbs (potrzebne do opcji quizu)
    const { data: allVerbsData, error: allVerbsErr } = await supabase
      .from('phrasal_verbs')
      .select('*')
      .order('id', { ascending: true });

    if (allVerbsErr) throw allVerbsErr;

    this.allVerbs = allVerbsData || [];

    const newVerbIds = this.allVerbs
      .map(v => v.id)
      .filter(id => !seenIds.includes(id));

    // 4. Połącz kolejkę: zaległe najpierw, potem nowe
    const allIds = [...overdueVerbIds, ...newVerbIds];

    if (allIds.length === 0) {
      this.queue = [];
      return;
    }

    // Limit do 50 (jak w flashcards)
    const BATCH_SIZE = 50;
    const batchIds = allIds.slice(0, BATCH_SIZE);

    // Buduj kolejkę z pełnych danych (mamy już allVerbs)
    const verbMap = {};
    this.allVerbs.forEach(v => { verbMap[v.id] = v; });

    this.queue = batchIds
      .map(id => verbMap[id])
      .filter(v => v !== undefined);
  },

  /**
   * Pokaż pytanie quizowe: phrasal verb + 4 opcje definicji
   */
  showQuestion() {
    const verb = this.queue[this.currentIndex];
    if (!verb) return;

    this._answered = false;

    const counter = document.getElementById('quiz-counter');
    counter.textContent = `${this.currentIndex + 1} / ${this.queue.length}`;

    const { options, correctIndex } = this.generateOptions(verb);
    this._correctIndex = correctIndex;
    this._currentOptions = options;

    const labels = ['A', 'B', 'C', 'D'];

    const optionsHtml = options.map((opt, i) => `
      <button class="quiz-option" onclick="Quiz.selectAnswer(${i})" data-index="${i}">
        <span class="quiz-option-label">${labels[i]})</span>${this.escapeHtml(opt)}
      </button>
    `).join('');

    const content = document.getElementById('quiz-content');
    content.innerHTML = `
      <div class="flashcard-verb">${this.escapeHtml(verb.verb)}</div>
      <div class="flashcard-tags">
        <span class="tag tag-${verb.category}">${verb.category}</span>
        <span class="tag tag-${verb.register}">${verb.register}</span>
        <span class="tag tag-tense">${verb.difficulty}</span>
      </div>
      <button class="speak-btn" onclick="Quiz.speak('${this.escapeAttr(verb.verb)}')" title="Wymowa">
        &#128264;
      </button>
      <div class="quiz-options">
        ${optionsHtml}
      </div>
    `;
  },

  /**
   * Generuj 4 opcje: 1 poprawna + 3 losowe definicje
   */
  generateOptions(verb) {
    const correctDef = verb.definition_en;

    // Filtruj kandydatów: inne phrasal verbs (nie ten sam)
    // Preferuj tę samą kategorię lub poziom trudności
    let candidates = this.allVerbs.filter(v => v.id !== verb.id);

    // Spróbuj najpierw z tej samej kategorii
    let sameCat = candidates.filter(v => v.category === verb.category);

    let distractors = [];

    // Losuj 3 distraktory — preferuj tę samą kategorię
    if (sameCat.length >= 3) {
      distractors = this._pickRandom(sameCat, 3);
    } else {
      // Za mało w tej samej kategorii — dobierz z reszty
      distractors = [...sameCat];
      const rest = candidates.filter(v => v.category !== verb.category);
      const needed = 3 - distractors.length;
      distractors = distractors.concat(this._pickRandom(rest, needed));
    }

    // Zbierz definicje
    const options = [
      correctDef,
      ...distractors.map(d => d.definition_en)
    ];

    // Pomieszaj losowo, zapamiętaj indeks poprawnej
    const shuffled = options.map((opt, i) => ({ opt, isCorrect: i === 0 }));
    shuffled.sort(() => Math.random() - 0.5);

    const correctIndex = shuffled.findIndex(s => s.isCorrect);

    return {
      options: shuffled.map(s => s.opt),
      correctIndex
    };
  },

  /**
   * Losuj N elementów z tablicy (bez powtórzeń)
   */
  _pickRandom(arr, n) {
    const copy = [...arr];
    const result = [];
    for (let i = 0; i < n && copy.length > 0; i++) {
      const idx = Math.floor(Math.random() * copy.length);
      result.push(copy.splice(idx, 1)[0]);
    }
    return result;
  },

  /**
   * Obsłuż kliknięcie opcji
   */
  selectAnswer(index) {
    if (this._answered) return;
    this._answered = true;

    const verb = this.queue[this.currentIndex];
    if (!verb) return;

    const isCorrect = index === this._correctIndex;

    // Zapisz wynik sesji
    this.sessionResults.push({
      verb: verb.verb,
      verbId: verb.id,
      known: isCorrect
    });

    // Dodaj do kolejki zapisów SM2
    this.enqueueSave(Auth.currentUser.id, verb.id, isCorrect);

    // Podświetl odpowiedzi
    this.showResult(index, isCorrect);
  },

  /**
   * Podświetl poprawną/błędną opcję, po 1.5s → next()
   */
  showResult(selectedIndex, isCorrect) {
    const buttons = document.querySelectorAll('.quiz-option');

    buttons.forEach((btn, i) => {
      btn.classList.add('disabled');

      if (i === this._correctIndex) {
        btn.classList.add('correct');
      }
      if (i === selectedIndex && !isCorrect) {
        btn.classList.add('incorrect');
      }
    });

    // Po 1.5s przejdź dalej
    setTimeout(() => this.next(), 1500);
  },

  /**
   * Przejdź do następnego pytania lub zakończ sesję
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
    const content = document.getElementById('quiz-content');
    content.innerHTML = `
      <div class="text-center" style="padding: 32px 24px;">
        <div style="font-size: 2.5rem; margin-bottom: 12px;">&#127942;</div>
        <h2 style="margin-bottom: 8px; color: var(--green);">Cel dzienny osiągnięty!</h2>
        <p class="text-muted mb-24">Przerobiłeś już ${this.dailyGoal} pytań w quizie. Świetna robota!</p>
        ${remaining > 0 ? `
          <p class="mb-24">Zostało jeszcze <strong>${remaining}</strong> pytań do przerobienia.</p>
          <button class="btn btn-primary btn-lg mb-16" style="width:100%;" onclick="Quiz.continueAfterGoal()">Kontynuuj quiz</button>
        ` : ''}
        <button class="btn btn-outline btn-lg" style="width:100%;" onclick="Quiz.endSession()">Zakończ sesję</button>
      </div>
    `;
  },

  /**
   * Kontynuuj quiz po osiągnięciu celu
   */
  continueAfterGoal() {
    if (this.currentIndex >= this.queue.length) {
      this.endSession();
    } else {
      this.showQuestion();
    }
  },

  /**
   * Kolejkuj zapis SM2 — wykonuje zapisy jeden po drugim
   */
  enqueueSave(userId, verbId, known) {
    this._saveQueue.push({ userId, verbId, known });
    this._processSaveQueue();
  },

  async _processSaveQueue() {
    if (this._saving || this._saveQueue.length === 0) return;
    this._saving = true;

    while (this._saveQueue.length > 0) {
      const { userId, verbId, known } = this._saveQueue.shift();
      try {
        await SM2.saveAnswer(userId, verbId, known);
      } catch (err) {
        console.error('Błąd zapisu SM2 (quiz):', err);
      }
    }

    this._saving = false;
  },

  /**
   * Poczekaj aż wszystkie zapisy SM2 się zakończą
   */
  async _waitForSaves() {
    if (this._saveQueue.length === 0 && !this._saving) return;

    const deadline = Date.now() + 10000;
    while ((this._saveQueue.length > 0 || this._saving) && Date.now() < deadline) {
      await new Promise(r => setTimeout(r, 100));
    }
  },

  /**
   * Zakończ sesję — zapisz log i pokaż podsumowanie
   */
  async endSession() {
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

      await this.updateStreak();
    } catch (err) {
      console.error('Błąd zapisu sesji (quiz):', err);
    }

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
      await supabase.from('streaks').insert({
        user_id: userId,
        current_streak: 1,
        longest_streak: 1,
        last_active_date: today
      });
      return;
    }

    const lastDate = new Date(streak.last_active_date);
    const todayDate = new Date(today);
    const diffDays = Math.floor((todayDate - lastDate) / (1000 * 60 * 60 * 24));

    let newStreak = streak.current_streak;

    if (diffDays === 0) {
      return;
    } else if (diffDays === 1) {
      newStreak += 1;
    } else {
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
   * Pokaż ekran podsumowania sesji (wspólny z fiszkami)
   */
  showSummary(total, known, unknown, duration) {
    const percent = total > 0 ? Math.round((known / total) * 100) : 0;
    const minutes = Math.floor(duration / 60);
    const seconds = duration % 60;
    const timeStr = minutes > 0 ? `${minutes} min ${seconds} s` : `${seconds} s`;

    const mistakes = this.sessionResults.filter(r => !r.known);
    let mistakesHtml = '';
    if (mistakes.length > 0) {
      mistakesHtml = `
        <div class="summary-mistakes">
          <h4>Do powtórki (błędne odpowiedzi)</h4>
          ${mistakes.map(m => `<div class="mistake-item">${this.escapeHtml(m.verb)}</div>`).join('')}
        </div>`;
    }

    App.showScreen('summary');
    const container = document.getElementById('summary-content');
    container.innerHTML = `
      <div class="summary-title">Quiz zakończony!</div>
      <div class="summary-stats">
        <div class="summary-stat">
          <div class="stat-value">${total}</div>
          <div class="stat-label">Pytań</div>
        </div>
        <div class="summary-stat">
          <div class="stat-value green">${known}</div>
          <div class="stat-label">Poprawnych</div>
        </div>
        <div class="summary-stat">
          <div class="stat-value red">${unknown}</div>
          <div class="stat-label">Błędnych</div>
        </div>
        <div class="summary-stat">
          <div class="stat-value accent">${percent}%</div>
          <div class="stat-label">Skuteczność</div>
        </div>
      </div>
      <p class="text-muted mb-16">Czas: ${timeStr}</p>
      ${mistakesHtml}
      <button class="btn btn-primary btn-lg" onclick="App.showScreen('home')">Wróć do ekranu głównego</button>
    `;
  },

  /**
   * Wymowa tekstu
   */
  speak(text) {
    Speech.speak(text);
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
