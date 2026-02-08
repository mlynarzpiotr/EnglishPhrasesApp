/* ============================================
   app.js — Inicjalizacja, routing, nawigacja
   ============================================ */

const App = {
  screens: {},
  currentScreen: null,

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
    if (name === 'home') this.loadHomeScreen();
    if (name === 'admin' && Auth.isAdmin()) this.loadAdminScreen();
    if (name === 'dashboard') this.loadDashboardScreen();
    if (name === 'settings') this.loadSettingsScreen();
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

    const greeting = document.getElementById('home-greeting');
    const dateEl = document.getElementById('home-date');
    const todayReview = document.getElementById('stat-today-review');
    const todayNew = document.getElementById('stat-today-new');
    const totalKnown = document.getElementById('stat-total-known');
    const totalAll = document.getElementById('stat-total-all');
    const streakCurrent = document.getElementById('streak-current');
    const streakBest = document.getElementById('streak-best');

    // Powitanie
    const email = Auth.currentProfile.email;
    const name = email.split('@')[0];
    greeting.textContent = `Cześć, ${name}!`;

    // Data
    const today = new Date();
    const options = { weekday: 'long', day: 'numeric', month: 'long' };
    dateEl.textContent = today.toLocaleDateString('pl-PL', options);

    // Statystyki — ile do powtórki dziś
    const now = new Date().toISOString();
    const { count: reviewCount } = await supabase
      .from('user_progress')
      .select('*', { count: 'exact', head: true })
      .eq('user_id', Auth.currentUser.id)
      .lte('next_review', now);

    // Ile phrasal verbs ma użytkownik w progress
    const { count: seenCount } = await supabase
      .from('user_progress')
      .select('*', { count: 'exact', head: true })
      .eq('user_id', Auth.currentUser.id);

    // Ile phrasal verbs w bazie
    const { count: allCount } = await supabase
      .from('phrasal_verbs')
      .select('*', { count: 'exact', head: true });

    // Ile "znanych" (repetitions >= 3)
    const { count: knownCount } = await supabase
      .from('user_progress')
      .select('*', { count: 'exact', head: true })
      .eq('user_id', Auth.currentUser.id)
      .gte('repetitions', 3);

    // Nowe dostępne (bez limitu — użytkownik decyduje ile przerobić)
    const unseenCount = (allCount || 0) - (seenCount || 0);

    todayReview.textContent = reviewCount || 0;
    todayNew.textContent = unseenCount;
    totalKnown.textContent = knownCount || 0;
    totalAll.textContent = allCount || 0;

    // Streak
    const { data: streakData } = await supabase
      .from('streaks')
      .select('*')
      .eq('user_id', Auth.currentUser.id)
      .single();

    if (streakData) {
      streakCurrent.textContent = `${streakData.current_streak} dni z rzędu`;
      streakBest.textContent = `Rekord: ${streakData.longest_streak} dni`;
    } else {
      streakCurrent.textContent = '0 dni z rzędu';
      streakBest.textContent = 'Rekord: 0 dni';
    }

    // Aktualizuj przycisk start
    const totalAvailable = (reviewCount || 0) + unseenCount;
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
    // Admin.load() będzie w admin.js
    if (typeof Admin !== 'undefined') {
      await Admin.load();
    }
  },

  // --- Dashboard Screen ---
  async loadDashboardScreen() {
    // Dashboard.load() będzie w dashboard.js
    if (typeof Dashboard !== 'undefined') {
      await Dashboard.load();
    }
  },

  // --- Settings Screen ---
  async loadSettingsScreen() {
    // Settings.load() będzie w settings.js
    if (typeof Settings !== 'undefined') {
      await Settings.load();
    }
  }
};

// Start aplikacji po załadowaniu strony
document.addEventListener('DOMContentLoaded', () => {
  App.init();
});
