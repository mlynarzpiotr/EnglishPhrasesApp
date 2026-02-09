/* ============================================
   app.js — Inicjalizacja, routing, nawigacja
   ============================================ */

const App = {
  screens: {},
  currentScreen: null,
  _loading: {},  // guard: zapobiega wielokrotnym równoległym ładowaniom ekranów

  async init() {
    // Referencje do ekranów
    this.screens = {
      auth: document.getElementById('screen-auth'),
      pending: document.getElementById('screen-pending'),
      home: document.getElementById('screen-home'),
      learn: document.getElementById('screen-learn'),
      summary: document.getElementById('screen-summary'),
      dashboard: document.getElementById('screen-dashboard'),
      settings: document.getElementById('screen-settings'),
      admin: document.getElementById('screen-admin')
    };

    // Referencje do nawigacji
    this.nav = document.getElementById('main-nav');
    this.navLinks = document.querySelectorAll('.nav-link[data-screen]');

    // Nawigacja kliknięcia
    this.navLinks.forEach(link => {
      link.addEventListener('click', () => {
        this.showScreen(link.dataset.screen);
      });
    });

    // Inicjalizacja formularza auth
    this.initAuthForm();

    // Sprawdź sesję
    const isLoggedIn = await Auth.init();

    if (isLoggedIn) {
      this.handleLoggedIn();
    } else {
      this.showScreen('auth');
    }

    // Nasłuchuj zmian sesji
    Auth.onAuthChange((event) => {
      if (event === 'SIGNED_OUT') {
        this.showScreen('auth');
        this.nav.classList.add('hidden');
      }
    });
  },

  // Po zalogowaniu — sprawdź czy approved
  handleLoggedIn() {
    if (!Auth.isApproved()) {
      this.showScreen('pending');
      this.nav.classList.add('hidden');
      return;
    }

    this.nav.classList.remove('hidden');
    this.updateNav();
    this.showScreen('home');
    this.loadHomeScreen();
  },

  // Aktualizuj nawigację (pokaż/ukryj admin)
  updateNav() {
    const adminLink = document.querySelector('.nav-link[data-screen="admin"]');
    if (adminLink) {
      adminLink.classList.toggle('hidden', !Auth.isAdmin());
    }
  },

  // Pokaż ekran
  showScreen(name) {
    // Ukryj wszystkie
    Object.values(this.screens).forEach(screen => {
      if (screen) screen.classList.remove('active');
    });

    // Pokaż wybrany
    const target = this.screens[name];
    if (target) {
      target.classList.add('active');
      this.currentScreen = name;
    }

    // Aktualizuj aktywny link w nawigacji
    this.navLinks.forEach(link => {
      link.classList.toggle('active', link.dataset.screen === name);
    });

    // Załaduj dane ekranu jeśli potrzeba
    // Każdy loader ma guard (_loading) zapobiegający równoległym wywołaniom
    if (name === 'home') this.loadHomeScreen();
    if (name === 'admin' && Auth.isAdmin()) this.loadAdminScreen();
    if (name === 'dashboard') this.loadDashboardScreen();
    if (name === 'settings') this.loadSettingsScreen();

    // Zatrzymaj wymowę przy zmianie ekranu
    Speech.stop();
  },

  // --- Formularz Auth ---
  initAuthForm() {
    const tabs = document.querySelectorAll('.auth-tab');
    const loginForm = document.getElementById('login-form');
    const registerForm = document.getElementById('register-form');
    const authMessage = document.getElementById('auth-message');

    // Przełączanie zakładek login/register
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        tabs.forEach(t => t.classList.remove('active'));
        tab.classList.add('active');
        authMessage.classList.add('hidden');

        if (tab.dataset.tab === 'login') {
          loginForm.classList.remove('hidden');
          registerForm.classList.add('hidden');
        } else {
          loginForm.classList.add('hidden');
          registerForm.classList.remove('hidden');
        }
      });
    });

    // Logowanie
    loginForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const email = document.getElementById('login-email').value.trim();
      const password = document.getElementById('login-password').value;
      const btn = loginForm.querySelector('button[type="submit"]');

      btn.disabled = true;
      authMessage.classList.add('hidden');

      try {
        await Auth.login(email, password);
        this.handleLoggedIn();
      } catch (err) {
        authMessage.textContent = err.message;
        authMessage.className = 'alert alert-error';
        authMessage.classList.remove('hidden');
      } finally {
        btn.disabled = false;
      }
    });

    // Rejestracja
    registerForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const email = document.getElementById('register-email').value.trim();
      const password = document.getElementById('register-password').value;
      const passwordConfirm = document.getElementById('register-password-confirm').value;
      const btn = registerForm.querySelector('button[type="submit"]');

      if (password !== passwordConfirm) {
        authMessage.textContent = 'Hasła nie są identyczne';
        authMessage.className = 'alert alert-error';
        authMessage.classList.remove('hidden');
        return;
      }

      if (password.length < 6) {
        authMessage.textContent = 'Hasło musi mieć minimum 6 znaków';
        authMessage.className = 'alert alert-error';
        authMessage.classList.remove('hidden');
        return;
      }

      btn.disabled = true;
      authMessage.classList.add('hidden');

      try {
        await Auth.register(email, password);
        this.handleLoggedIn();
      } catch (err) {
        authMessage.textContent = err.message;
        authMessage.className = 'alert alert-error';
        authMessage.classList.remove('hidden');
      } finally {
        btn.disabled = false;
      }
    });

    // Przycisk wylogowania z ekranu pending
    const pendingLogout = document.getElementById('pending-logout');
    if (pendingLogout) {
      pendingLogout.addEventListener('click', async () => {
        await Auth.logout();
        this.showScreen('auth');
      });
    }
  },

  // --- Home Screen ---
  async loadHomeScreen() {
    if (!Auth.isApproved()) return;

    // Guard: jeśli już ładujemy home — nie odpalaj ponownie
    if (this._loading.home) return;
    this._loading.home = true;

    const greeting = document.getElementById('home-greeting');
    const dateEl = document.getElementById('home-date');
    const statAll = document.getElementById('stat-total-all');
    const statToLearn = document.getElementById('stat-to-learn');
    const statLearning = document.getElementById('stat-learning');
    const statKnown = document.getElementById('stat-known');
    const streakCurrent = document.getElementById('streak-current');
    const streakBest = document.getElementById('streak-best');

    // Powitanie (synchroniczne — nie wymaga bazy)
    const email = Auth.currentProfile.email;
    const name = email.split('@')[0];
    greeting.textContent = `Cześć, ${name}!`;

    const today = new Date();
    const options = { weekday: 'long', day: 'numeric', month: 'long' };
    dateEl.textContent = today.toLocaleDateString('pl-PL', options);

    try {
      const now = new Date().toISOString();
      const userId = Auth.currentUser.id;

      // Wszystkie zapytania RÓWNOLEGLE (zamiast 5 sekwencyjnych)
      const [reviewRes, seenRes, allRes, knownRes, streakRes] = await Promise.all([
        supabase.from('user_progress').select('*', { count: 'exact', head: true })
          .eq('user_id', userId).lte('next_review', now),
        supabase.from('user_progress').select('*', { count: 'exact', head: true })
          .eq('user_id', userId),
        supabase.from('phrasal_verbs').select('*', { count: 'exact', head: true }),
        supabase.from('user_progress').select('*', { count: 'exact', head: true })
          .eq('user_id', userId).gte('repetitions', 3),
        supabase.from('streaks').select('*').eq('user_id', userId).single()
      ]);

      // Jeśli użytkownik zmienił ekran w międzyczasie — nie aktualizuj DOM
      if (this.currentScreen !== 'home') return;

      const reviewCount = reviewRes.count || 0;
      const seenCount = seenRes.count || 0;
      const allCount = allRes.count || 0;
      const knownCount = knownRes.count || 0;
      const toLearnCount = allCount - seenCount;
      const learningCount = seenCount - knownCount;
      const streakData = streakRes.data;

      statAll.textContent = allCount;
      statToLearn.textContent = toLearnCount;
      statLearning.textContent = learningCount;
      statKnown.textContent = knownCount;

      if (streakData) {
        streakCurrent.textContent = `${streakData.current_streak} dni z rzędu`;
        streakBest.textContent = `Rekord: ${streakData.longest_streak} dni`;
      } else {
        streakCurrent.textContent = '0 dni z rzędu';
        streakBest.textContent = 'Rekord: 0 dni';
      }

      // Aktualizuj przycisk start
      const totalAvailable = reviewCount + toLearnCount;
      const dailyGoal = Auth.currentProfile.daily_goal || 10;
      const startBtn = document.getElementById('start-learn-btn');
      if (totalAvailable === 0) {
        startBtn.textContent = 'Wszystkie fiszki przerobione — wróć jutro!';
        startBtn.disabled = true;
      } else {
        startBtn.textContent = `Rozpocznij naukę (${totalAvailable} dostępnych, cel: ${dailyGoal})`;
        startBtn.disabled = false;
        startBtn.onclick = () => this.startLearning();
      }
    } catch (err) {
      console.error('Błąd ładowania ekranu głównego:', err);
      // Nadal pozwól na start — przycisk z domyślnym tekstem
      const startBtn = document.getElementById('start-learn-btn');
      startBtn.textContent = 'Rozpocznij naukę';
      startBtn.disabled = false;
      startBtn.onclick = () => this.startLearning();
    } finally {
      this._loading.home = false;
    }
  },

  // --- Start nauki ---
  async startLearning() {
    this.showScreen('learn');
    // Flashcards.start() będzie w flashcards.js
    if (typeof Flashcards !== 'undefined') {
      await Flashcards.start();
    }
  },

  // --- Admin Screen ---
  async loadAdminScreen() {
    if (!Auth.isAdmin()) return;
    if (this._loading.admin) return;
    this._loading.admin = true;
    try {
      if (typeof Admin !== 'undefined') await Admin.load();
    } catch (err) {
      console.error('Błąd ładowania panelu admina:', err);
    } finally {
      this._loading.admin = false;
    }
  },

  // --- Dashboard Screen ---
  async loadDashboardScreen() {
    if (this._loading.dashboard) return;
    this._loading.dashboard = true;
    try {
      if (typeof Dashboard !== 'undefined') await Dashboard.load();
    } catch (err) {
      console.error('Błąd ładowania dashboardu:', err);
      const c = document.getElementById('dashboard-content');
      if (c) c.innerHTML = '<div class="alert alert-error">Błąd ładowania. Spróbuj ponownie.</div>';
    } finally {
      this._loading.dashboard = false;
    }
  },

  // --- Settings Screen ---
  async loadSettingsScreen() {
    if (this._loading.settings) return;
    this._loading.settings = true;
    try {
      if (typeof Settings !== 'undefined') await Settings.load();
    } catch (err) {
      console.error('Błąd ładowania ustawień:', err);
    } finally {
      this._loading.settings = false;
    }
  }
};

// Start aplikacji po załadowaniu strony
document.addEventListener('DOMContentLoaded', () => {
  App.init();
});
