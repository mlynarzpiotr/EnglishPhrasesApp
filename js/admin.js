/* ============================================
   admin.js — Panel administratora
   ============================================ */

const Admin = {
  async load() {
    const container = document.getElementById('admin-content');
    if (!Auth.isAdmin()) {
      container.innerHTML = '<div class="alert alert-error">Brak uprawnień</div>';
      return;
    }

    container.innerHTML = '<div class="loading-text"><span class="spinner"></span> Ładowanie...</div>';

    try {
      // Pobierz oczekujących użytkowników
      const { data: pending, error: pendingErr } = await supabase
        .from('profiles')
        .select('*')
        .eq('approved', false)
        .eq('role', 'user')
        .order('created_at', { ascending: true });

      if (pendingErr) throw pendingErr;

      // Pobierz aktywnych użytkowników
      const { data: active, error: activeErr } = await supabase
        .from('profiles')
        .select('*')
        .eq('approved', true)
        .order('created_at', { ascending: true });

      if (activeErr) throw activeErr;

      container.innerHTML = this.render(pending || [], active || []);
      this.attachEvents(container);
    } catch (err) {
      container.innerHTML = `<div class="alert alert-error">Błąd: ${err.message}</div>`;
    }
  },

  render(pending, active) {
    let html = '';

    // Sekcja oczekujących
    html += '<div class="admin-section">';
    html += `<h3>Oczekujący na zatwierdzenie (${pending.length})</h3>`;

    if (pending.length === 0) {
      html += '<p class="text-muted">Brak oczekujących użytkowników</p>';
    } else {
      pending.forEach(user => {
        const date = new Date(user.created_at).toLocaleDateString('pl-PL');
        html += `
          <div class="user-item" data-user-id="${user.id}">
            <div class="user-info">
              <div class="user-email">${this.escapeHtml(user.email)}</div>
              <div class="user-date">Zarejestrowano: ${date}</div>
            </div>
            <div class="user-actions">
              <button class="btn btn-green btn-sm approve-btn" data-id="${user.id}">Zatwierdź</button>
              <button class="btn btn-red btn-sm reject-btn" data-id="${user.id}">Odrzuć</button>
            </div>
          </div>`;
      });
    }
    html += '</div>';

    // Sekcja aktywnych
    html += '<div class="admin-section">';
    html += `<h3>Aktywni użytkownicy (${active.length})</h3>`;

    active.forEach(user => {
      const date = new Date(user.created_at).toLocaleDateString('pl-PL');
      const role = user.role === 'admin' ? ' <span class="tag tag-business">ADMIN</span>' : '';
      html += `
        <div class="user-item">
          <div class="user-info">
            <div class="user-email">${this.escapeHtml(user.email)}${role}</div>
            <div class="user-date">Od: ${date}</div>
          </div>
        </div>`;
    });

    html += '</div>';

    return html;
  },

  attachEvents(container) {
    // Zatwierdzanie
    container.querySelectorAll('.approve-btn').forEach(btn => {
      btn.addEventListener('click', async () => {
        const userId = btn.dataset.id;
        btn.disabled = true;
        btn.textContent = '...';

        const { error } = await supabase
          .from('profiles')
          .update({ approved: true })
          .eq('id', userId);

        if (error) {
          alert('Błąd: ' + error.message);
          btn.disabled = false;
          btn.textContent = 'Zatwierdź';
          return;
        }

        // Odśwież listę
        await this.load();
      });
    });

    // Odrzucanie (usunięcie profilu — użytkownik może się zarejestrować ponownie)
    container.querySelectorAll('.reject-btn').forEach(btn => {
      btn.addEventListener('click', async () => {
        const userId = btn.dataset.id;
        if (!confirm('Czy na pewno chcesz odrzucić tego użytkownika?')) return;

        btn.disabled = true;
        btn.textContent = '...';

        // Usunięcie profilu (kaskadowo nie usunie auth.users — to wymaga service_role)
        // Zamiast tego zostawiamy approved=false — admin może zmienić zdanie
        const { error } = await supabase
          .from('profiles')
          .delete()
          .eq('id', userId);

        if (error) {
          alert('Błąd: ' + error.message);
          btn.disabled = false;
          btn.textContent = 'Odrzuć';
          return;
        }

        await this.load();
      });
    });
  },

  escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }
};
