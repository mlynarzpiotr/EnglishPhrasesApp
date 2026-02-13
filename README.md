# EnglishPhrasesApp

Aplikacja webowa do nauki phrasal verbs metodą fiszek, z algorytmem SM-2 oraz dziennym pakietem nowych fiszek.

## Najważniejsze funkcje
- Fiszki + inteligentne powtórki (SM-2)
- Dzienny pakiet nowych fiszek (kontynuowany między logowaniami tego samego dnia)
- Filtr poziomu (B2/C1/All) dla nowych fiszek
- Tryb quiz
- Wymowa (Web Speech API)
- Dashboard postępów
- Panel admina (zatwierdzanie użytkowników)

## Dzienny pakiet — jak działa
1. **Nowe (pakiet dzienny)** — liczba nowych = `daily_goal` z ustawień.
2. **Powtórki zaległe** — wszystko, co ma `next_review <= teraz`.
3. **Reszta nowych (opcjonalnie)** — po komunikacie „Cel dzienny osiągnięty!”.

Nowe fiszki są losowane stabilnie **per dzień**, więc przy kolejnym logowaniu
zobaczysz pozostałe „brakujące” nowe, a nie inne.

Filtr poziomu (B2/C1/All) dotyczy tylko nowych fiszek — powtórki zawsze się pojawiają.

## Stack
- HTML/CSS/Vanilla JS
- Supabase (Auth + DB)
- Web Speech API
- GitHub Pages

## Uruchomienie
1. Skonfiguruj Supabase i uruchom SQL z `sql/`.
2. W `js/supabase.js` ustaw `SUPABASE_URL` i `SUPABASE_ANON_KEY`.
3. Otwórz `index.html` w przeglądarce.

## Supabase — minimalny zestaw SQL
- `sql/001_create_tables.sql`
- `sql/003_fix_admin_policies.sql`
- `sql/005_add_first_seen_on.sql` (dla istniejących baz)
- `sql/006_add_difficulty_filter.sql` (dla istniejących baz)

## Checklist testów manualnych
- Logowanie/rejestracja, konto czeka na zatwierdzenie, zatwierdzenie admina.
- `daily_goal=12`, pierwsze logowanie → 12 nowych, potem powtórki.
- W trakcie dnia: zrób 6 nowych, wyloguj → po ponownym logowaniu start od pozostałych 6 nowych.
- Po ukończeniu nowych + powtórek: komunikat „Cel dzienny osiągnięty!” z wyborem „Kontynuuj/Zakończ”.
- Po „Kontynuuj”: brak licznika w nagłówku, doładowywanie kolejnych nowych.
- Zmiana `daily_goal` w trakcie dnia działa od razu.
- Przejście przez północ: sesja rozpoczęta przed północą zachowuje pakiet dnia startu.
- Quiz: identyczna kolejność i komunikaty jak w fiszkach.
- Dashboard: historia sesji agregowana dziennie.
