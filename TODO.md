# TODO — EnglishPhrasesApp

## 🎯 Krytyczne (przed deployem)

- [ ] **Deploy na GitHub Pages**
  - Utworzyć repozytorium GitHub
  - Push kodu do `main`
  - Skonfigurować GitHub Pages (Settings → Pages → Source: main branch, root)
  - Przetestować działanie na URL `https://[username].github.io/[repo-name]/`

## ⚠️ Ważne (po deployem)

- [ ] **Testy na innych przeglądarkach**
  - Chrome/Edge (Chromium)
  - Safari (macOS/iOS)
  - Firefox
  - Sprawdzić wymowę (Web Speech API) na każdej

- [ ] **Testy mobilne**
  - iPhone Safari
  - Android Chrome
  - Sprawdzić responsive design (fiszki, nawigacja, podsumowanie)

- [ ] **Filtrowanie w ustawieniach**
  - Checkboxy: kategorie (business, general, both)
  - Checkboxy: tagi (meetings, emails, negotiations, presentations, finance, hr, daily, travel)
  - Checkboxy: poziomy (B2, C1)
  - Zapis preferencji do `profiles` (nowa kolumna JSONB `filter_preferences`)
  - Flashcards.js: uwzględnić filtry w `loadQueue()`

## 📝 Nice to have (przyszłość)

- [ ] **Export postępów do CSV**
  - Przycisk w Dashboardzie
  - Eksport user_progress + phrasal_verbs (join)
  - Format: verb, kategoria, repetitions, ease_factor, times_seen, times_known, next_review

- [ ] **Tryb jasny/ciemny (toggle)**
  - Przełącznik w Ustawieniach
  - CSS custom properties (już są) + dodać jasne wersje
  - Zapis preferencji do localStorage

- [ ] **Heatmapa streak (kalendarz)**
  - Wizualizacja aktywności w stylu GitHub
  - Ostatnie 30/90 dni
  - Kolor intensywności = liczba przerobiona fiszek

- [ ] **Tryb quiz (wielokrotny wybór)**
  - Alternatywny tryb nauki
  - Pokaż definicję → wybierz phrasal verb (4 opcje)
  - Lub odwrotnie: pokaż phrasal verb → wybierz definicję

- [ ] **Zdania z lukami (fill in the blank)**
  - Pokaż zdanie z luką zamiast pełnego phrasal verb
  - Użytkownik wpisuje brakujący phrasal verb
  - Walidacja (tolerancja na drobne błędy)

- [ ] **Moduł idiomów**
  - Nowa tabela `idioms` (analogiczna do phrasal_verbs)
  - Nowa tabela `idiom_progress`
  - Osobna zakładka w nawigacji
  - Ten sam algorytm SM-2, osobne postępy

- [ ] **Powiadomienia push (PWA)**
  - Manifest.json + service worker
  - Daily reminder: "Czas na dzisiejszą naukę!"
  - Streak reminder: "Nie przerwij serii 7 dni!"

- [ ] **Statystyki per kategoria w Dashboard**
  - Osobny wykres/pasek dla każdej kategorii
  - Business vs General vs Both — szczegółowe rozbicie

## 🐛 Bugfixy / Ulepszenia

- [ ] **Limitacja Supabase .in() — max 300**
  - Obecnie: flashcards.js ładuje wszystkie ID przez `.in(allIds)`
  - Jeśli użytkownik ma 300+ zaległych → błąd
  - Fix: podzielić na batche po 200 lub użyć paginacji

- [ ] **Highlight phrasal verb w zdaniach — lepszy regex**
  - Obecnie: prosty regex łapie "bring...up" ale nie zawsze dokładnie
  - Ulepszyć wykrywanie różnych form (brought up, bringing up, brings up)

- [ ] **Edge case: brak głosów w Web Speech API**
  - Safari na iOS czasami nie ładuje głosów od razu
  - Dodać fallback lub komunikat "Wymowa niedostępna"

## 📚 Dokumentacja

- [x] `INSTRUKCJE.md` — pełna specyfikacja
- [x] `docs/jak-dziala-sm2.md` — wyjaśnienie algorytmu
- [ ] `README.md` — opis projektu dla GitHub
  - Funkcje, stack technologiczny, setup, deploy
- [ ] Screenshoty do README
  - Ekran logowania, fiszki, dashboard, podsumowanie
