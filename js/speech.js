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
   * Przeglądarki ładują głosy asynchronicznie (szczególnie Safari/iOS),
   * dlatego nasłuchujemy zdarzenia voiceschanged i ponawiamy próby.
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
        voices[0]; // Fallback: cokolwiek, byle mówiło
    };

    findVoice();

    // Standardowy nasłuchiwacz
    if (speechSynthesis.onvoiceschanged !== undefined) {
      speechSynthesis.onvoiceschanged = findVoice;
    }

    // Fallback dla Safari/iOS: ponów próbę kilka razy
    // (czasami onvoiceschanged nie odpala się automatycznie)
    setTimeout(findVoice, 500);
    setTimeout(findVoice, 1000);
    setTimeout(findVoice, 3000);
  },

  /**
   * Odczytaj tekst po angielsku
   * @param {string} text - tekst do odczytania
   */
  speak(text) {
    if (!this.available || !text) return;

    // Upewnij się, że mamy głos (może załadował się z opóźnieniem)
    if (!this.preferredVoice) {
      const voices = speechSynthesis.getVoices();
      if (voices.length > 0) {
        this.preferredVoice = voices.find(v => v.lang.startsWith('en')) || voices[0];
      }
    }

    if (!this.preferredVoice) {
      console.warn('Speech API: Brak dostępnych głosów. Próba użycia domyślnego syntezatora.');
      // Nie wracamy (return) - próbujemy puścić utterance bez ustawionego voice
      // Przeglądarka powinna użyć domyślnego systemowego.
    }

    // Zatrzymaj poprzednie odczytywanie
    speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    // Jeśli nie mamy preferredVoice, nie ustawiamy lang "na sztywno" na en-US, 
    // chyba że jesteśmy pewni. Ale bezpieczniej ustawić.
    utterance.lang = 'en-US';
    utterance.rate = this.rate;

    if (this.preferredVoice) {
      utterance.voice = this.preferredVoice;
    }

    // Obsługa błędów odtwarzania
    utterance.onerror = (event) => {
      console.error('Speech API error:', event);
    };

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
