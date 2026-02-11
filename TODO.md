# TODO — EnglishPhrasesApp

## 🎯 Krytyczne (przed deployem)

- [x] **Deploy na GitHub Pages**
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

- [x] **Limitacja Supabase .in() — max 300**
  - Fix: podzielić na batche po 200 lub użyć paginacji (Zrobione: limit 50 na sesję)

- [x] **Highlight phrasal verb w zdaniach — lepszy regex**
  - Ulepszyć wykrywanie różnych form (brought up, bringing up, brings up) (Zrobione)

- [x] **Edge case: brak głosów w Web Speech API**
  - Dodać fallback lub komunikat "Wymowa niedostępna" (Zrobione: retry + fallback do native)

- [x] **Zawieszanie się aplikacji po sesji nauki**
  - loadHomeScreen: 5 sekwencyjnych zapytań → Promise.all
  - Guard _loading zapobiegający wielokrotnym wywołaniom
  - SM2: fire-and-forget → kolejka sekwencyjna
  - Speech.stop() przy zmianie ekranu

- [x] **Liczniki na panelu głównym nie sumowały się do Wszystkie**
  - Nowe 4 kafelki: Wszystkie / Do nauki / W trakcie nauki / Opanowane

- [x] **Poprawa jakości phrasal verbs ID 200-275**
  - Szczegółowe definicje (1-2 zdania z niuansami)
  - Wielowariantowe tłumaczenia PL z kontekstem
  - 4 przykłady na wpis z różnorodnymi czasami
  - Konteksty 6-15 słów, szczegółowe grammar_note
  - Utworzono `sql/004_update_phrasal_verbs_200_275.sql` do aktualizacji Supabase
  - Utworzono `update_supabase.html` jako alternatywny sposób aktualizacji

- [x] **Sekcja "Jak działa nauka?" na ekranie głównym**
  - Zwijany panel wyjaśniający algorytm SM-2
  - 3 kroki: System pudełek, Dopasowanie do Ciebie, Optymalny moment
  - Domyślnie zwinięty, rozwija się po kliknięciu
  - Umieszczony na górze ekranu home (przed statystykami)

## 📚 Dokumentacja

- [x] `INSTRUKCJE.md` — pełna specyfikacja
- [x] `docs/jak-dziala-sm2.md` — wyjaśnienie algorytmu
- [ ] `README.md` — opis projektu dla GitHub
  - Funkcje, stack technologiczny, setup, deploy
- [ ] Screenshoty do README
  - Ekran logowania, fiszki, dashboard, podsumowanie
