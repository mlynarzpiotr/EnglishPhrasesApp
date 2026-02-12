# EnglishPhrasesApp — Instrukcje budowy aplikacji

> Aplikacja do nauki phrasal verbs (i w przyszłości idiomów) w języku angielskim,
> z naciskiem na angielski biznesowy. Poziom docelowy: B2 → C1.

---

## 1. Cel aplikacji

Interaktywna aplikacja webowa do nauki phrasal verbs metodą fiszek (flashcards)
z systemem inteligentnych powtórek opartym na krzywej zapominania.
Użytkownik loguje się przez przeglądarkę, uczy się codziennie i śledzi swoje postępy.

---

## 2. Stack technologiczny

| Warstwa | Technologia | Koszt |
|---------|------------|-------|
| Frontend | HTML, CSS, vanilla JavaScript | 0 zł |
| Hosting | GitHub Pages | 0 zł |
| Baza danych | Supabase (free tier) | 0 zł |
| Autoryzacja | Supabase Auth (email + hasło) | 0 zł |
| Wymowa | Web Speech API (wbudowane w przeglądarkę) | 0 zł |

**Zasada**: brak frameworków, brak zależności npm, brak procesu budowania.
Całość jako pliki HTML/CSS/JS serwowane przez GitHub Pages.
Supabase podłączony przez JavaScript SDK ładowany z CDN.

---

## 3. Użytkownicy i autoryzacja

### 3.1 Role
- **Admin** (1 osoba — właściciel aplikacji, Piotr Młynarz)
- **User** (bez limitu — admin kontroluje dostęp przez system zatwierdzania)

### 3.2 Flow rejestracji
1. Nowy użytkownik wchodzi na stronę → widzi ekran logowania / rejestracji
2. Rejestracja: podaje email + hasło
3. Supabase tworzy konto, ale w tabeli `profiles` pole `approved = false`
4. Użytkownik widzi ekran: "Twoje konto czeka na zatwierdzenie przez administratora"
5. Admin widzi w panelu admina listę oczekujących użytkowników
6. Admin klika "Zatwierdź" → `approved = true` → użytkownik ma dostęp
7. Brak limitu użytkowników — admin decyduje kogo zatwierdzić

### 3.3 Flow logowania
1. Użytkownik podaje email + hasło
2. Supabase Auth weryfikuje dane
3. Aplikacja sprawdza `profiles.approved === true`
4. Jeśli tak → przekierowanie do głównego ekranu nauki
5. Jeśli nie → komunikat o oczekiwaniu na zatwierdzenie

### 3.4 Panel admina
- Widoczny tylko dla użytkownika z `profiles.role = 'admin'`
- Zawiera: listę oczekujących użytkowników (email, data rejestracji) + przyciski "Zatwierdź" / "Odrzuć"
- Prosty widok — nie wymaga osobnej strony, wystarczy zakładka w nawigacji

---

## 4. Baza danych — struktura Supabase

### 4.1 Tabela `profiles`
Rozszerzenie wbudowanej tabeli `auth.users` z Supabase.

| Kolumna | Typ | Opis |
|---------|-----|------|
| id | UUID (PK) | Powiązane z `auth.users.id` |
| email | TEXT | Email użytkownika |
| role | TEXT | `admin` lub `user` |
| approved | BOOLEAN | `false` domyślnie, `true` po zatwierdzeniu |
| created_at | TIMESTAMP | Data rejestracji |
| daily_goal | INTEGER | Dzienny cel (domyślnie 10) |

### 4.2 Tabela `phrasal_verbs`
Główna tabela z zawartością edukacyjną.

| Kolumna | Typ | Opis |
|---------|-----|------|
| id | SERIAL (PK) | Identyfikator |
| verb | TEXT | Phrasal verb (np. "bring up") |
| definition_en | TEXT | Definicja po angielsku |
| translation_pl | TEXT | Tłumaczenie na polski (opcjonalna podpowiedź) |
| category | TEXT | Kategoria: `business`, `general`, `both` |
| tags | TEXT[] | Tagi tematyczne: `meetings`, `emails`, `negotiations`, `presentations`, `finance`, `hr`, `daily`, `travel` |
| register | TEXT | Rejestr językowy: `formal`, `informal`, `neutral` |
| difficulty | TEXT | Poziom trudności: `B2`, `C1` |
| examples | JSONB | Tablica 4 zdań przykładowych (struktura poniżej) |
| created_at | TIMESTAMP | Data dodania |

**Struktura pola `examples` (JSONB):**
```json
[
  {
    "sentence": "She brought up an important issue during the meeting.",
    "context": "business meeting",
    "tense": "Past Simple",
    "grammar_note": "brought up + noun"
  },
  {
    "sentence": "I will bring up your suggestion with the board tomorrow.",
    "context": "corporate communication",
    "tense": "Future Simple",
    "grammar_note": "will bring up + noun + with someone"
  },
  {
    "sentence": "This topic has been brought up several times already.",
    "context": "recurring discussion",
    "tense": "Present Perfect Passive",
    "grammar_note": "has been brought up (passive voice)"
  },
  {
    "sentence": "If anyone brings up the budget, let me handle it.",
    "context": "strategy planning",
    "tense": "Present Simple (conditional)",
    "grammar_note": "if + brings up (third person)"
  }
]
```

**Wymagania dot. przykładów:**
- Minimum 4 zdania na każdy phrasal verb
- Każde zdanie w innym czasie gramatycznym
- Każde zdanie odnosi się do innej sytuacji
- Każde zdanie pokazuje inną formę gramatyczną (np. active/passive, conditional, gerund)
- Dla phrasal verbs z kategorią `business` lub `both` — przynajmniej 2 z 4 przykładów w kontekście biznesowym

### 4.3 Tabela `user_progress`
Postępy użytkownika — jedna pozycja na każdy phrasal verb na każdego użytkownika.

| Kolumna | Typ | Opis |
|---------|-----|------|
| id | SERIAL (PK) | Identyfikator |
| user_id | UUID (FK → profiles.id) | Użytkownik |
| verb_id | INTEGER (FK → phrasal_verbs.id) | Phrasal verb |
| ease_factor | FLOAT | Współczynnik łatwości SM-2 (domyślnie 2.5) |
| interval_days | INTEGER | Aktualny interwał powtórki w dniach |
| repetitions | INTEGER | Liczba poprawnych odpowiedzi z rzędu |
| next_review | TIMESTAMP | Data następnej powtórki |
| last_reviewed | TIMESTAMP | Data ostatniego przeglądu |
| times_seen | INTEGER | Ile razy użytkownik widział ten phrasal verb |
| times_known | INTEGER | Ile razy odpowiedział "wiem" |
| times_unknown | INTEGER | Ile razy odpowiedział "nie wiem" |
| first_seen_on | DATE | Dzień, w którym phrasal verb po raz pierwszy trafił do dziennego pakietu |
| created_at | TIMESTAMP | Kiedy użytkownik po raz pierwszy zobaczył ten verb |

**Ważne**: unikatowy indeks na parę `(user_id, verb_id)` — jeden rekord na użytkownika na phrasal verb.

### 4.4 Tabela `session_log`
Historia sesji nauki.

| Kolumna | Typ | Opis |
|---------|-----|------|
| id | SERIAL (PK) | Identyfikator |
| user_id | UUID (FK → profiles.id) | Użytkownik |
| date | DATE | Data sesji |
| total_reviewed | INTEGER | Ile phrasal verbs przerobiono |
| total_known | INTEGER | Ile razy odpowiedziano "wiem" |
| total_unknown | INTEGER | Ile razy odpowiedziano "nie wiem" |
| duration_seconds | INTEGER | Czas trwania sesji w sekundach |

### 4.5 Tabela `streaks`
Seria dni nauki (motywacja).

| Kolumna | Typ | Opis |
|---------|-----|------|
| id | SERIAL (PK) | Identyfikator |
| user_id | UUID (FK → profiles.id) | Użytkownik |
| current_streak | INTEGER | Aktualna seria dni |
| longest_streak | INTEGER | Najdłuższa seria w historii |
| last_active_date | DATE | Data ostatniej aktywności |

---

## 5. Algorytm powtórek — SM-2 (SuperMemo 2)

### 5.1 Dlaczego SM-2
SM-2 to algorytm opracowany przez Piotra Woźniaka (polskiego naukowca), stosowany w Anki
i dziesiątkach aplikacji do nauki. Opiera się na krzywej zapominania Ebbinghausa —
im lepiej znasz materiał, tym rzadziej go powtarzasz. Naukowo udowodniona skuteczność.

### 5.2 Jak działa w kontekście tej aplikacji

**Odpowiedź "wiem" (quality = 4):**
- `repetitions += 1`
- Nowy interwał:
  - Jeśli `repetitions == 1` → `interval = 1` (powtórka jutro)
  - Jeśli `repetitions == 2` → `interval = 6` (powtórka za 6 dni)
  - Jeśli `repetitions >= 3` → `interval = previous_interval × ease_factor`
- `ease_factor` rośnie lekko (min. 1.3): `ease_factor += 0.1 - (5-4) × (0.08 + (5-4) × 0.02)` → `+0.10`
- `next_review = now + interval_days`

**Odpowiedź "nie wiem" (quality = 1):**
- `repetitions = 0` (reset)
- `interval = 1` (powtórka jutro)
- `ease_factor` maleje: `ease_factor += 0.1 - (5-1) × (0.08 + (5-1) × 0.02)` → `−0.30` (ale nie mniej niż 1.3)
- `next_review = now + 1`

### 5.3 Kolejność prezentowania phrasal verbs (tryb dzienny)
Sesja jest podzielona na etapy:
1. **Nowe (pakiet dzienny)** — liczba nowych = `daily_goal`. Jeśli użytkownik zrobi część, reszta czeka do końca dnia.
2. **Powtórki zaległe** — `next_review <= teraz` (od najstarszej zaległości).
3. **Reszta nowych (opcjonalnie)** — po komunikacie o wykonaniu celu dziennego, tylko jeśli użytkownik wybierze „Kontynuuj”.

**Losowość dzienna**: nowe fiszki są losowane stabilnie na dany dzień (ten sam porządek w kolejnych logowaniach).
**Brak twardego limitu** — użytkownik może przerobić wszystkie nowe, ale są dociągane w porcjach.

### 5.4 Cel dzienny (nowe fiszki, nie limit)
- Domyślna wartość: **10 nowych phrasal verbs dziennie** (konfigurowalne w ustawieniach)
- To **dzienny pakiet nowych**, nie twardy limit sesji
- Po przerobieniu **nowych + powtórek** → komunikat „Cel dzienny osiągnięty!”
  - „Kontynuuj naukę” → dalsze **nowe** fiszki (reszta puli)
  - „Zakończ sesję” → podsumowanie i zapis
- Jeśli użytkownik wraca tego samego dnia, dostaje **pozostałe nowe** z dziennego pakietu

---

## 6. Interfejs użytkownika — ekrany

### 6.1 Ekran logowania / rejestracji
- Formularz: email + hasło
- Przełącznik: "Zaloguj się" / "Zarejestruj się"
- Komunikat dla niezatwierdzonych: "Twoje konto czeka na zatwierdzenie"
- Komunikat dla niezatwierdzonych: "Twoje konto czeka na zatwierdzenie"

### 6.2 Ekran główny (po zalogowaniu)
- Powitanie: "Cześć, [imię]"
- Statystyki dnia: ile do przerobienia dziś (zaległe + nowe)
- Seria dni (streak): aktualna i najdłuższa
- Przycisk: dynamiczny opis zależny od etapu dnia:
  - **Nowe** → "Rozpocznij naukę (nowe: X)"
  - **Powtórki** → "Rozpocznij powtórki (pozostało: Y)"
  - **Dodatkowe nowe** → "Kontynuuj naukę (dodatkowe: Z)"
- Nawigacja: Nauka | Dashboard | Ustawienia | (Admin — tylko dla admina)

### 6.3 Ekran nauki (fiszki)
**Stan 1 — pytanie:**
- Wyświetlony phrasal verb (duża czcionka, wyśrodkowany)
- Kategoria i rejestr (małe tagi, np. `business` `formal`)
- Przycisk wymowy (ikona głośnika — Web Speech API)
- Dwa przyciski: "Wiem ✓" / "Nie wiem ✗"
- Licznik etapu:
  - **Nowe: pozostało X** (w pakiecie dziennym)
  - **Powtórki: pozostało X**
  - Brak licznika w etapie „reszta nowych”

**Stan 2 — odpowiedź (po kliknięciu "wiem" lub "nie wiem"):**
- Phrasal verb (nadal widoczny)
- Definicja po angielsku (główna)
- Tłumaczenie PL (domyślnie ukryte, kliknięcie "Pokaż tłumaczenie" odkrywa)
- 4 zdania przykładowe, każde z:
  - Treść zdania (phrasal verb wyróżniony pogrubieniem)
  - Czas gramatyczny (tag, np. `Past Simple`)
  - Kontekst (tag, np. `business meeting`)
- Przycisk: "Dalej →"

### 6.4 Ekran podsumowania sesji
Wyświetla się po przerobeniu wszystkich fiszek w sesji:
- Liczba przerobiona: X phrasal verbs
- Wynik: Y "wiem" / Z "nie wiem"
- Procent poprawnych: Y / X × 100%
- Czas trwania sesji
- Phrasal verbs które sprawiły problem (lista tych z odpowiedzią "nie wiem")
- Przycisk: "Wróć do ekranu głównego"

### 6.5 Dashboard (postępy)
- **Ogólne statystyki**: łączna liczba znanych / w trakcie nauki / nowych
- **Wykres postępów**: linia pokazująca liczbę znanych phrasal verbs w czasie (po dniach)
- **Rozkład kategorii**: ile business vs general, ile z każdego tagu
- **Najtrudniejsze phrasal verbs**: top 10 z najniższym ease_factor (te które sprawiają najwięcej problemów)
- **Seria dni**: kalendarz z zaznaczonymi dniami aktywności (heatmapa w stylu GitHub)
- **Filtr kategorii**: możliwość przeglądania postępów per kategoria / tag

### 6.6 Ustawienia
- Dzienny cel motywacyjny (slider: 3-30, domyślnie 10) — próg po którym pojawia się komunikat zachęty, nie limit
- Filtr kategorii do nauki (checkboxy: business, general, all)
- Filtr tagów (checkboxy: meetings, emails, negotiations, itp.)
- Filtr poziomu trudności (B2, C1, all)
- Wyloguj się

### 6.7 Panel admina (tylko admin)
- Lista użytkowników oczekujących na zatwierdzenie (email, data rejestracji)
- Przyciski: "Zatwierdź" / "Odrzuć" przy każdym
- Lista aktywnych użytkowników (email, data ostatniej aktywności, liczba znanych verbs)
- Licznik aktywnych użytkowników

---

## 7. Design i UX

### 7.1 Motyw wizualny
- **Ciemny motyw** (spójny z istniejącym git-guide)
- CSS custom properties do zarządzania kolorami
- Responsive design — działa na telefonie i komputerze
- Brak zewnętrznych bibliotek CSS

### 7.2 Kolory dodatkowe (uzupełnienie palety)
- Zielony: odpowiedź "wiem", pozytywne statystyki
- Czerwony: odpowiedź "nie wiem", negatywne statystyki
- Niebieski: elementy interaktywne, linki
- Żółty/pomarańczowy: streak, ostrzeżenia
- Tagi kategorii: różne kolory per kategoria (business = niebieski, general = szary, formal = fioletowy, informal = zielony, neutral = szary)

### 7.3 Animacje
- Płynne przejście między stanem pytania a stanem odpowiedzi (slide down)
- Przejście między fiszkami (fade / slide)
- Efekt na przyciskach "wiem" / "nie wiem" (kolor tła zmienia się na chwilę)
- Minimalne — nie spowalniają nauki

---

## 8. Wymowa — Web Speech API

```javascript
function speak(text) {
  const utterance = new SpeechSynthesisUtterance(text);
  utterance.lang = 'en-US';
  utterance.rate = 0.9; // lekko wolniej dla czytelności
  speechSynthesis.speak(utterance);
}
```

- Przycisk głośnika przy phrasal verb (ekran pytania)
- Przycisk głośnika przy każdym zdaniu przykładowym (ekran odpowiedzi)
- Brak zależności zewnętrznych — działa w każdej nowoczesnej przeglądarce

---

## 9. Struktura plików

```
EnglishPhrasesApp/
├── index.html              ← Główna aplikacja (SPA)
├── css/
│   └── styles.css          ← Wszystkie style
├── js/
│   ├── app.js              ← Inicjalizacja, routing, nawigacja
│   ├── auth.js             ← Logowanie, rejestracja, zarządzanie sesją
│   ├── supabase.js         ← Klient Supabase, konfiguracja
│   ├── flashcards.js       ← Logika fiszek, prezentacja phrasal verbs
│   ├── sm2.js              ← Algorytm SM-2 (powtórki)
│   ├── dashboard.js        ← Dashboard, wykresy, statystyki
│   ├── admin.js            ← Panel admina
│   ├── settings.js         ← Ustawienia użytkownika
│   ├── speech.js           ← Wymowa (Web Speech API)
│   └── session.js          ← Podsumowanie sesji, tracking czasu
└── data/
    └── phrasal-verbs.json  ← Seed data: 200 phrasal verbs (do importu do Supabase)
```

**Uwaga**: Struktura podzielona na osobne pliki JS (nie jeden wielki plik)
dla czytelności i łatwości rozwoju. Ładowane przez `<script>` w `index.html`.
Bez bundlera — prosta kolejność ładowania.

---

## 10. Zawartość — 200 phrasal verbs

### 10.1 Podział
- **100+ phrasal verbs biznesowych** (kategoria `business` lub `both`)
- **do 100 phrasal verbs ogólnych** (kategoria `general`) które są powszechne i przydatne

### 10.2 Przykładowe tagi biznesowe i ich kontekst
| Tag | Kontekst | Przykładowe verbs |
|-----|----------|-------------------|
| `meetings` | Spotkania, prezentacje | bring up, carry on, go over, point out, wrap up |
| `emails` | Korespondencja formalna | follow up, get back to, reach out, fill in, pass on |
| `negotiations` | Negocjacje, umowy | back out, come up with, give in, hold off, turn down |
| `presentations` | Wystąpienia, pitche | break down, go through, sum up, touch on, lay out |
| `finance` | Finanse, budżety | cut back, draw up, pay off, write off, bail out |
| `hr` | Zarządzanie ludźmi, HR | take on, let go, step down, hand over, phase out |
| `daily` | Codzienne sytuacje | figure out, look into, set up, sort out, deal with |
| `travel` | Podróże służbowe | check in, drop off, pick up, see off, stop over |

### 10.3 Wymagania dot. każdego phrasal verb
- [ ] Phrasal verb (poprawna forma)
- [ ] Definicja angielska (jasna, max 2 zdania)
- [ ] Tłumaczenie polskie (krótkie, trafne)
- [ ] Kategoria (business / general / both)
- [ ] Minimum 1 tag tematyczny
- [ ] Rejestr (formal / informal / neutral)
- [ ] Poziom trudności (B2 / C1)
- [ ] 4 zdania przykładowe spełniające kryteria z sekcji 4.2

---

## 11. Supabase — konfiguracja

### 11.1 Wymagane ustawienia
- Projekt Supabase (free tier)
- Authentication: Email provider włączony
- Row Level Security (RLS) włączone na wszystkich tabelach
- Polisy RLS:
  - `profiles`: użytkownik czyta tylko swój profil, admin czyta wszystkie
  - `phrasal_verbs`: wszyscy zatwierdzeni użytkownicy czytają, nikt nie edytuje przez frontend
  - `user_progress`: użytkownik czyta/pisze tylko swoje postępy
  - `session_log`: użytkownik czyta/pisze tylko swoje sesje
  - `streaks`: użytkownik czyta/pisze tylko swoje dane

### 11.2 Trigger na rejestrację
Po rejestracji nowego użytkownika w `auth.users` → automatycznie utwórz rekord w `profiles`
z `approved = false` i `role = 'user'`.

```sql
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, approved, created_at, daily_goal)
  VALUES (NEW.id, NEW.email, 'user', false, NOW(), 10);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();
```

### 11.3 Import danych
Phrasal verbs importowane z pliku `data/phrasal-verbs.json` do tabeli `phrasal_verbs`
przez SQL INSERT lub dashboard Supabase. Jednorazowy import + możliwość dodawania nowych.

---

## 12. Skalowalność i przyszłe moduły

### 12.1 Dodawanie nowych phrasal verbs
- Dodanie nowych rekordów do tabeli `phrasal_verbs`
- Nowe phrasal verbs nie mają powiązań w `user_progress` → algorytm traktuje je jako "nowe, niewidziane"
- Automatycznie pojawiają się w kolejce nauki użytkowników
- Zero wpływu na istniejące postępy

### 12.2 Moduł idiomów (przyszłość)
Gdy aplikacja phrasal verbs będzie gotowa i stabilna, dodanie modułu idiomów:
- Nowa tabela `idioms` (analogiczna struktura do `phrasal_verbs`)
- Nowa tabela `idiom_progress` (analogiczna do `user_progress`)
- Nowa zakładka w nawigacji: "Phrasal Verbs | Idioms"
- Ten sam algorytm SM-2, ten sam design, osobne postępy
- Wspólny dashboard z filtrem per moduł

### 12.3 Potencjalne przyszłe rozszerzenia
- Tryb quiz (wielokrotny wybór) — jako alternatywny tryb nauki
- Zdania z lukami (fill in the blank)
- Eksport postępów do CSV
- Tryb ciemny / jasny (przełącznik)

---

## 13. Kolejność implementacji

Sugerowana kolejność budowania aplikacji (od fundamentów do detali):

### Etap 1 — Fundament
1. Konfiguracja projektu Supabase (tabele, RLS, trigger)
2. Plik `supabase.js` — połączenie z bazą
3. Plik `auth.js` — logowanie i rejestracja
4. Ekran logowania / rejestracji w `index.html`
5. Sprawdzenie czy flow rejestracji → oczekiwanie → zatwierdzenie działa

### Etap 2 — Dane
6. Przygotowanie `phrasal-verbs.json` z 200 phrasal verbs
7. Import do Supabase
8. Weryfikacja danych (kompletność, jakość przykładów)

### Etap 3 — Nauka
9. Plik `sm2.js` — algorytm powtórek
10. Plik `flashcards.js` — wyświetlanie fiszek
11. Ekran nauki: stan pytania → stan odpowiedzi → dalej
12. Plik `speech.js` — wymowa
13. Zapis odpowiedzi do `user_progress`

### Etap 4 — Sesja i postępy
14. Plik `session.js` — tracking sesji
15. Ekran podsumowania sesji
16. Plik `dashboard.js` — statystyki i wykresy
17. Streak tracking

### Etap 5 — Admin i ustawienia
18. Plik `admin.js` — panel admina
19. Plik `settings.js` — ustawienia użytkownika
20. Filtrowanie po kategoriach / tagach / poziomie

### Etap 6 — Polish i deploy
21. Testy na różnych przeglądarkach i urządzeniach
22. Optymalizacja mobilna
23. Deploy na GitHub Pages
24. Ręczne ustawienie pierwszego konta admina w Supabase

---

## 14. Dokumentacja

- Skrócony opis i checklistę testów manualnych znajdziesz w `README.md`.
