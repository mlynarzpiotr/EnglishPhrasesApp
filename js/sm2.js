/* ============================================
   sm2.js — Algorytm SM-2 (SuperMemo 2)

   Oparty na badaniach Piotra Woźniaka.
   Oblicza kiedy użytkownik powinien powtórzyć
   dany phrasal verb na podstawie jego odpowiedzi.
   ============================================ */

const SM2 = {
  // Domyślne wartości dla nowego phrasal verb
  defaults: {
    ease_factor: 2.5,
    interval_days: 0,
    repetitions: 0
  },

  /**
   * Oblicz nowe parametry po odpowiedzi użytkownika
   *
   * @param {Object} progress - aktualny stan postępu użytkownika
   *   - ease_factor (float): współczynnik łatwości (min 1.3)
   *   - interval_days (int): aktualny interwał w dniach
   *   - repetitions (int): ile razy z rzędu odpowiedział "wiem"
   * @param {boolean} known - true = "wiem", false = "nie wiem"
   * @returns {Object} - nowe wartości: ease_factor, interval_days, repetitions, next_review
   */
  calculate(progress, known) {
    let { ease_factor, interval_days, repetitions } = progress;
    const quality = known ? 4 : 1;

    if (known) {
      // === Odpowiedź: WIEM (quality = 4) ===
      repetitions += 1;

      // Nowy interwał
      if (repetitions === 1) {
        interval_days = 1;          // powtórka jutro
      } else if (repetitions === 2) {
        interval_days = 6;          // powtórka za 6 dni
      } else {
        interval_days = Math.round(interval_days * ease_factor);
      }

      // Ease factor rośnie: +0.10
      // Wzór: EF += 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02)
      ease_factor += 0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02);

    } else {
      // === Odpowiedź: NIE WIEM (quality = 1) ===
      repetitions = 0;              // reset serii
      interval_days = 1;            // powtórka jutro

      // Ease factor maleje: -0.30
      ease_factor += 0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02);
    }

    // Ease factor nie może spaść poniżej 1.3
    ease_factor = Math.max(1.3, ease_factor);

    // Oblicz datę następnej powtórki
    const next_review = new Date();
    next_review.setDate(next_review.getDate() + interval_days);

    return {
      ease_factor: Math.round(ease_factor * 100) / 100,  // zaokrąglij do 2 miejsc
      interval_days,
      repetitions,
      next_review: next_review.toISOString()
    };
  },

  /**
   * Zapisz odpowiedź użytkownika do Supabase
   *
   * @param {string} userId - UUID użytkownika
   * @param {number} verbId - ID phrasal verb
   * @param {boolean} known - true = "wiem", false = "nie wiem"
   * @returns {Object} - zaktualizowany rekord user_progress
   */
  async saveAnswer(userId, verbId, known) {
    // Pobierz aktualny postęp (lub utwórz nowy)
    let { data: progress, error } = await supabase
      .from('user_progress')
      .select('*')
      .eq('user_id', userId)
      .eq('verb_id', verbId)
      .single();

    const isNew = !progress || error;

    // Jeśli nowy — użyj domyślnych wartości
    if (isNew) {
      progress = {
        ease_factor: this.defaults.ease_factor,
        interval_days: this.defaults.interval_days,
        repetitions: this.defaults.repetitions,
        times_seen: 0,
        times_known: 0,
        times_unknown: 0
      };
    }

    // Oblicz nowe parametry SM-2
    const updated = this.calculate(progress, known);

    // Aktualizuj liczniki
    const times_seen = (progress.times_seen || 0) + 1;
    const times_known = (progress.times_known || 0) + (known ? 1 : 0);
    const times_unknown = (progress.times_unknown || 0) + (known ? 0 : 1);

    const record = {
      user_id: userId,
      verb_id: verbId,
      ease_factor: updated.ease_factor,
      interval_days: updated.interval_days,
      repetitions: updated.repetitions,
      next_review: updated.next_review,
      last_reviewed: new Date().toISOString(),
      times_seen,
      times_known,
      times_unknown
    };

    let result;

    if (isNew) {
      // Wstaw nowy rekord
      result = await supabase
        .from('user_progress')
        .insert(record)
        .select()
        .single();
    } else {
      // Aktualizuj istniejący
      result = await supabase
        .from('user_progress')
        .update(record)
        .eq('user_id', userId)
        .eq('verb_id', verbId)
        .select()
        .single();
    }

    if (result.error) {
      console.error('Błąd zapisu postępu:', result.error);
      throw result.error;
    }

    return result.data;
  }
};
