/* ============================================
   dashboard.js — Statystyki i postępy użytkownika
   ============================================ */

const Dashboard = {
  async load() {
    const container = document.getElementById('dashboard-content');
    container.innerHTML = '<div class="loading-text"><span class="spinner"></span> Ładowanie statystyk...</div>';

    try {
      const userId = Auth.currentUser.id;

      // Pobierz dane równolegle
      const [progressRes, verbsRes, sessionsRes, streakRes] = await Promise.all([
        supabase.from('user_progress').select('*').eq('user_id', userId),
        supabase.from('phrasal_verbs').select('id, verb, category, tags, difficulty'),
        supabase.from('session_log').select('*').eq('user_id', userId).order('date', { ascending: false }).limit(30),
        supabase.from('streaks').select('*').eq('user_id', userId).single()
      ]);

      const progress = progressRes.data || [];
      const verbs = verbsRes.data || [];
      const sessions = sessionsRes.data || [];
      const streak = streakRes.data;

      container.innerHTML = this.render(progress, verbs, sessions, streak);
    } catch (err) {
      container.innerHTML = `<div class="alert alert-error">Błąd: ${err.message}</div>`;
    }
  },

  render(progress, verbs, sessions, streak) {
    const totalVerbs = verbs.length;
    const seenCount = progress.length;
    const unseenCount = totalVerbs - seenCount;
    const knownCount = progress.filter(p => p.repetitions >= 3).length;
    const learningCount = seenCount - knownCount;

    // Mapa verb_id → progress
    const progressMap = {};
    progress.forEach(p => { progressMap[p.verb_id] = p; });

    let html = '';

    // --- Ogólne statystyki ---
    html += `
      <div class="stats-grid mb-24">
        <div class="stat-card">
          <div class="stat-value green">${knownCount}</div>
          <div class="stat-label">Opanowane</div>
        </div>
        <div class="stat-card">
          <div class="stat-value yellow">${learningCount}</div>
          <div class="stat-label">W trakcie nauki</div>
        </div>
        <div class="stat-card">
          <div class="stat-value accent">${unseenCount}</div>
          <div class="stat-label">Nowe (niewidziane)</div>
        </div>
        <div class="stat-card">
          <div class="stat-value">${totalVerbs}</div>
          <div class="stat-label">Wszystkie</div>
        </div>
      </div>`;

    // --- Pasek postępu ---
    const knownPct = totalVerbs > 0 ? (knownCount / totalVerbs * 100).toFixed(1) : 0;
    const learningPct = totalVerbs > 0 ? (learningCount / totalVerbs * 100).toFixed(1) : 0;
    const unseenPct = totalVerbs > 0 ? (unseenCount / totalVerbs * 100).toFixed(1) : 0;

    html += `
      <div class="settings-group mb-24">
        <h3>Postęp ogólny</h3>
        <div class="progress-bar-container">
          <div class="progress-bar">
            <div class="progress-segment green-bg" style="width: ${knownPct}%" title="Opanowane: ${knownPct}%"></div>
            <div class="progress-segment yellow-bg" style="width: ${learningPct}%" title="W trakcie: ${learningPct}%"></div>
          </div>
          <div class="progress-legend">
            <span><span class="legend-dot green-bg"></span> Opanowane ${knownPct}%</span>
            <span><span class="legend-dot yellow-bg"></span> W trakcie ${learningPct}%</span>
            <span><span class="legend-dot muted-bg"></span> Nowe ${unseenPct}%</span>
          </div>
        </div>
      </div>`;

    // --- Streak ---
    html += `
      <div class="streak-card mb-24">
        <div class="streak-icon">&#128293;</div>
        <div class="streak-info">
          <div class="streak-current">${streak ? streak.current_streak : 0} dni z rzędu</div>
          <div class="streak-best">Rekord: ${streak ? streak.longest_streak : 0} dni</div>
        </div>
      </div>`;

    // --- Rozkład kategorii ---
    const categories = { business: 0, general: 0, both: 0 };
    const catKnown = { business: 0, general: 0, both: 0 };
    verbs.forEach(v => {
      categories[v.category] = (categories[v.category] || 0) + 1;
      const p = progressMap[v.id];
      if (p && p.repetitions >= 3) {
        catKnown[v.category] = (catKnown[v.category] || 0) + 1;
      }
    });

    html += `
      <div class="settings-group mb-24">
        <h3>Rozkład kategorii</h3>
        ${this.renderCategoryBar('Business', catKnown.business, categories.business, 'accent')}
        ${this.renderCategoryBar('General', catKnown.general, categories.general, 'green')}
        ${this.renderCategoryBar('Both', catKnown.both, categories.both, 'purple')}
      </div>`;

    // --- Rozkład poziomów ---
    const levels = { B2: 0, C1: 0 };
    const lvlKnown = { B2: 0, C1: 0 };
    verbs.forEach(v => {
      levels[v.difficulty] = (levels[v.difficulty] || 0) + 1;
      const p = progressMap[v.id];
      if (p && p.repetitions >= 3) {
        lvlKnown[v.difficulty] = (lvlKnown[v.difficulty] || 0) + 1;
      }
    });

    html += `
      <div class="settings-group mb-24">
        <h3>Rozkład poziomów</h3>
        ${this.renderCategoryBar('B2', lvlKnown.B2, levels.B2, 'green')}
        ${this.renderCategoryBar('C1', lvlKnown.C1, levels.C1, 'yellow')}
      </div>`;

    // --- Najtrudniejsze phrasal verbs ---
    const hardest = progress
      .filter(p => p.times_seen >= 2)
      .sort((a, b) => a.ease_factor - b.ease_factor)
      .slice(0, 10);

    if (hardest.length > 0) {
      const verbMap = {};
      verbs.forEach(v => { verbMap[v.id] = v; });

      html += `
        <div class="settings-group mb-24">
          <h3>Najtrudniejsze phrasal verbs</h3>
          ${hardest.map((p, i) => {
            const v = verbMap[p.verb_id];
            if (!v) return '';
            const pct = p.times_seen > 0 ? Math.round(p.times_known / p.times_seen * 100) : 0;
            return `
              <div class="user-item">
                <div class="user-info">
                  <div class="user-email">${i + 1}. ${this.escapeHtml(v.verb)}</div>
                  <div class="user-date">EF: ${p.ease_factor} | ${p.times_known}/${p.times_seen} poprawnych (${pct}%)</div>
                </div>
              </div>`;
          }).join('')}
        </div>`;
    }

    // --- Historia sesji (agregacja dzienna, ostatnie 7 dni) ---
    const sessionsByDate = new Map();
    sessions.forEach(s => {
      const key = s.date;
      if (!sessionsByDate.has(key)) {
        sessionsByDate.set(key, {
          date: s.date,
          total_reviewed: s.total_reviewed,
          total_known: s.total_known,
          total_unknown: s.total_unknown,
          duration_seconds: s.duration_seconds
        });
      } else {
        const agg = sessionsByDate.get(key);
        agg.total_reviewed += s.total_reviewed;
        agg.total_known += s.total_known;
        agg.total_unknown += s.total_unknown;
        agg.duration_seconds += s.duration_seconds;
      }
    });

    const aggregatedSessions = Array.from(sessionsByDate.values())
      .sort((a, b) => new Date(b.date) - new Date(a.date));

    const recentSessions = aggregatedSessions.slice(0, 7);
    if (recentSessions.length > 0) {
      html += `
        <div class="settings-group mb-24">
          <h3>Ostatnie sesje</h3>
          ${recentSessions.map(s => {
            const pct = s.total_reviewed > 0 ? Math.round(s.total_known / s.total_reviewed * 100) : 0;
            const date = new Date(s.date).toLocaleDateString('pl-PL', { day: 'numeric', month: 'short' });
            const mins = Math.floor(s.duration_seconds / 60);
            const secs = s.duration_seconds % 60;
            const time = mins > 0 ? `${mins}m ${secs}s` : `${secs}s`;
            return `
              <div class="user-item">
                <div class="user-info">
                  <div class="user-email">${date} — ${s.total_reviewed} fiszek (${pct}% poprawnych)</div>
                  <div class="user-date">Czas: ${time} | Wiem: ${s.total_known} | Nie wiem: ${s.total_unknown}</div>
                </div>
              </div>`;
          }).join('')}
        </div>`;
    }

    return html;
  },

  renderCategoryBar(label, known, total, color) {
    const pct = total > 0 ? Math.round(known / total * 100) : 0;
    return `
      <div class="setting-row">
        <span class="setting-label">${label}</span>
        <div style="flex:1; margin: 0 12px;">
          <div class="progress-bar" style="height:8px;">
            <div class="progress-segment ${color}-bg" style="width:${pct}%"></div>
          </div>
        </div>
        <span class="setting-value" style="font-size:0.8rem;">${known}/${total}</span>
      </div>`;
  },

  escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str || '';
    return div.innerHTML;
  }
};
