/* ============================================
   settings.js — Ustawienia użytkownika
   ============================================ */

const Settings = {
  async load() {
    const container = document.getElementById('settings-content');
    const profile = Auth.currentProfile;

    container.innerHTML = this.render(profile);
    this.attachEvents(container);
  },

  render(profile) {
    const dailyGoal = profile.daily_goal || 10;

    return `
      <!-- Cel dzienny -->
      <div class="settings-group">
        <h3>Cel dzienny (motywacja)</h3>
        <p class="text-muted mb-16" style="font-size:0.8rem;">
          Po przerobeniu tylu fiszek pojawi się komunikat zachęty. To nie jest limit — możesz uczyć się dalej.
        </p>
        <div class="setting-row">
          <span class="setting-label">Liczba fiszek</span>
          <input type="range" id="setting-daily-goal" min="3" max="30" value="${dailyGoal}">
          <span class="setting-value" id="setting-daily-goal-value">${dailyGoal}</span>
        </div>
      </div>

      <!-- Konto -->
      <div class="settings-group">
        <h3>Konto</h3>
        <div class="setting-row">
          <span class="setting-label">Email</span>
          <span class="setting-value" style="font-size:0.8rem; color: var(--text-secondary);">${this.escapeHtml(profile.email)}</span>
        </div>
        <div class="setting-row">
          <span class="setting-label">Rola</span>
          <span class="tag ${profile.role === 'admin' ? 'tag-business' : 'tag-neutral'}">${profile.role}</span>
        </div>
        <div class="setting-row">
          <span class="setting-label">Konto od</span>
          <span class="setting-value" style="font-size:0.8rem; color: var(--text-secondary);">${new Date(profile.created_at).toLocaleDateString('pl-PL')}</span>
        </div>
      </div>

      <!-- Wymowa -->
      <div class="settings-group">
        <h3>Wymowa</h3>
        <div class="setting-row">
          <span class="setting-label">Tempo mówienia</span>
          <input type="range" id="setting-speech-rate" min="5" max="15" value="${Math.round(Speech.rate * 10)}">
          <span class="setting-value" id="setting-speech-rate-value">${Speech.rate.toFixed(1)}</span>
        </div>
        <div class="setting-row">
          <button class="btn btn-outline btn-sm" id="setting-speech-test">Testuj wymowę</button>
        </div>
      </div>

      <!-- Wylogowanie -->
      <div class="settings-group">
        <button class="btn btn-red" id="setting-logout" style="width:100%;">Wyloguj się</button>
      </div>
    `;
  },

  attachEvents(container) {
    // Slider celu dziennego
    const goalSlider = container.querySelector('#setting-daily-goal');
    const goalValue = container.querySelector('#setting-daily-goal-value');

    goalSlider.addEventListener('input', () => {
      goalValue.textContent = goalSlider.value;
    });

    goalSlider.addEventListener('change', async () => {
      const newGoal = parseInt(goalSlider.value);
      const { error } = await supabase
        .from('profiles')
        .update({ daily_goal: newGoal })
        .eq('id', Auth.currentUser.id);

      if (error) {
        alert('Błąd zapisu: ' + error.message);
        return;
      }

      Auth.currentProfile.daily_goal = newGoal;
    });

    // Slider tempa wymowy
    const rateSlider = container.querySelector('#setting-speech-rate');
    const rateValue = container.querySelector('#setting-speech-rate-value');

    rateSlider.addEventListener('input', () => {
      const rate = parseInt(rateSlider.value) / 10;
      rateValue.textContent = rate.toFixed(1);
    });

    rateSlider.addEventListener('change', () => {
      const rate = parseInt(rateSlider.value) / 10;
      Speech.setRate(rate);
    });

    // Test wymowy
    container.querySelector('#setting-speech-test').addEventListener('click', () => {
      Speech.speak('Let me bring up an important issue during our meeting.');
    });

    // Wylogowanie
    container.querySelector('#setting-logout').addEventListener('click', async () => {
      await Auth.logout();
      App.showScreen('auth');
      App.nav.classList.add('hidden');
    });
  },

  escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str || '';
    return div.innerHTML;
  }
};
