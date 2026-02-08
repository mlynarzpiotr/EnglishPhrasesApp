/* ============================================
   auth.js — Logowanie, rejestracja, sesja
   ============================================ */

const Auth = {
  currentUser: null,
  currentProfile: null,

  // Inicjalizacja — sprawdź czy jest aktywna sesja
  async init() {
    const { data: { session } } = await supabase.auth.getSession();
    if (session) {
      this.currentUser = session.user;
      await this.loadProfile();
      return true;
    }
    return false;
  },

  // Załaduj profil użytkownika z tabeli profiles
  async loadProfile() {
    if (!this.currentUser) return null;

    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', this.currentUser.id)
      .single();

    if (error) {
      console.error('Błąd ładowania profilu:', error);
      return null;
    }

    this.currentProfile = data;
    return data;
  },

  // Rejestracja nowego użytkownika
  async register(email, password) {
    const { data, error } = await supabase.auth.signUp({
      email: email,
      password: password
    });

    if (error) {
      throw new Error(this.translateError(error.message));
    }

    this.currentUser = data.user;
    await this.loadProfile();
    return data;
  },

  // Logowanie
  async login(email, password) {
    const { data, error } = await supabase.auth.signInWithPassword({
      email: email,
      password: password
    });

    if (error) {
      throw new Error(this.translateError(error.message));
    }

    this.currentUser = data.user;
    await this.loadProfile();
    return data;
  },

  // Wylogowanie
  async logout() {
    const { error } = await supabase.auth.signOut();
    if (error) {
      throw new Error(this.translateError(error.message));
    }
    this.currentUser = null;
    this.currentProfile = null;
  },

  // Czy użytkownik jest zalogowany
  isLoggedIn() {
    return this.currentUser !== null;
  },

  // Czy użytkownik jest zatwierdzony
  isApproved() {
    return this.currentProfile && this.currentProfile.approved === true;
  },

  // Czy użytkownik jest adminem
  isAdmin() {
    return this.currentProfile && this.currentProfile.role === 'admin';
  },

  // Nasłuchiwanie zmian sesji (np. wylogowanie z innej zakładki)
  onAuthChange(callback) {
    supabase.auth.onAuthStateChange(async (event, session) => {
      if (event === 'SIGNED_IN' && session) {
        this.currentUser = session.user;
        await this.loadProfile();
      } else if (event === 'SIGNED_OUT') {
        this.currentUser = null;
        this.currentProfile = null;
      }
      callback(event, session);
    });
  },

  // Tłumaczenie błędów Supabase na polski
  translateError(message) {
    const errors = {
      'Invalid login credentials': 'Nieprawidłowy email lub hasło',
      'Email not confirmed': 'Email nie został potwierdzony',
      'User already registered': 'Konto z tym adresem email już istnieje',
      'Password should be at least 6 characters': 'Hasło musi mieć minimum 6 znaków',
      'Unable to validate email address: invalid format': 'Nieprawidłowy format adresu email',
      'Email rate limit exceeded': 'Zbyt wiele prób. Spróbuj ponownie za chwilę',
      'For security purposes, you can only request this after 60 seconds': 'Poczekaj 60 sekund przed kolejną próbą'
    };
    return errors[message] || message;
  }
};
