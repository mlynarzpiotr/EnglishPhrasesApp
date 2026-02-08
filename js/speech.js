/* ============================================
   speech.js — Wymowa (Web Speech API)
   Moduł do odczytywania phrasal verbs i zdań
   po angielsku, bez zewnętrznych zależności.
   ============================================ */

const Speech = {
  preferredVoice: null,
  rate: 0.9,
  available: 'speechSynthesis' in window,

  /**
   * Inicjalizacja — znajdź najlepszy angielski głos
   * Przeglądarki ładują głosy asynchronicznie,
   * dlatego nasłuchujemy zdarzenia voiceschanged.
   */
  init() {
    if (!this.available) return;

    const findVoice = () => {
      const voices = speechSynthesis.getVoices();
      if (voices.length === 0) return;

      // Preferuj głosy w tej kolejności:
      // 1. en-US natywny (nie sieciowy — szybszy)
      // 2. en-GB natywny
      // 3. dowolny en-US
      // 4. dowolny angielski
      this.preferredVoice =
        voices.find(v => v.lang === 'en-US' && !v.name.includes('Google') && v.localService) ||
        voices.find(v => v.lang === 'en-GB' && v.localService) ||
        voices.find(v => v.lang === 'en-US') ||
        voices.find(v => v.lang.startsWith('en')) ||
        null;
    };

    findVoice();
    speechSynthesis.addEventListener('voiceschanged', findVoice);
  },

  /**
   * Odczytaj tekst po angielsku
   * @param {string} text - tekst do odczytania
   */
  speak(text) {
    if (!this.available || !text) return;

    // Zatrzymaj poprzednie odczytywanie
    speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = 'en-US';
    utterance.rate = this.rate;

    if (this.preferredVoice) {
      utterance.voice = this.preferredVoice;
    }

    speechSynthesis.speak(utterance);
  },

  /**
   * Zatrzymaj odczytywanie
   */
  stop() {
    if (!this.available) return;
    speechSynthesis.cancel();
  },

  /**
   * Zmień tempo mówienia
   * @param {number} rate - tempo (0.5 = wolno, 1.0 = normalnie, 1.5 = szybko)
   */
  setRate(rate) {
    this.rate = Math.max(0.5, Math.min(1.5, rate));
  }
};

// Inicjalizuj od razu
Speech.init();
