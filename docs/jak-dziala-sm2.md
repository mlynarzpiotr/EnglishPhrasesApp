# Jak działa algorytm SM-2 — proste wyjaśnienie

## Analogia: pudełka z fiszkami

Wyobraź sobie, że masz 5 pudełek:

```
Pudełko 1 → powtarzam JUTRO
Pudełko 2 → powtarzam za 6 DNI
Pudełko 3 → powtarzam za ~2 TYGODNIE
Pudełko 4 → powtarzam za ~1 MIESIĄC
Pudełko 5 → powtarzam za ~2-3 MIESIĄCE
```

- Nowa fiszka zaczyna w **Pudełku 1**
- Odpowiadasz **"wiem"** → fiszka przechodzi do następnego pudełka (rzadsze powtórki)
- Odpowiadasz **"nie wiem"** → fiszka wraca do **Pudełka 1** (powtórka jutro)

SM-2 działa dokładnie tak, tylko zamiast 5 pudełek używa matematycznego wzoru.

---

## Co oblicza SM-2

Dla każdego phrasal verb algorytm śledzi 3 liczby:

### 1. Repetitions (seria poprawnych odpowiedzi)
- Ile razy **z rzędu** odpowiedziałeś "wiem"
- "Nie wiem" resetuje serię do 0

**Przykład:**
```
wiem → wiem → wiem → nie wiem → wiem → wiem
  1       2       3       0        1       2
```

### 2. Interval (interwał w dniach)
- Za ile dni zobaczysz tę fiszkę ponownie

| Seria (repetitions) | Interwał |
|---------------------|----------|
| 1 odpowiedź "wiem" | 1 dzień (jutro) |
| 2 z rzędu "wiem" | 6 dni |
| 3 z rzędu "wiem" | 6 × ease_factor ≈ 15 dni |
| 4 z rzędu "wiem" | 15 × ease_factor ≈ 38 dni |
| 5 z rzędu "wiem" | 38 × ease_factor ≈ 95 dni |

Przy odpowiedzi "nie wiem" → interwał zawsze wraca do **1 dnia**.

### 3. Ease Factor (współczynnik łatwości)
- Startuje od **2.5**
- "Wiem" → rośnie o **+0.10** (fiszka staje się "łatwiejsza")
- "Nie wiem" → maleje o **-0.30** (fiszka staje się "trudniejsza")
- Nigdy nie spada poniżej **1.3**

**Co to zmienia w praktyce?**
- Wysoki EF (np. 2.5) → interwały rosną szybko → rzadsze powtórki
- Niski EF (np. 1.3) → interwały rosną wolno → częstsze powtórki

To znaczy: phrasal verbs które ci sprawiają kłopot, będziesz widział CZĘŚCIEJ.

---

## Przykład z życia

Uczysz się "bring up":

| Dzień | Odpowiedź | Seria | Interwał | Ease Factor | Następna powtórka |
|-------|-----------|-------|----------|-------------|-------------------|
| 1 | wiem | 1 | 1 dzień | 2.60 | dzień 2 |
| 2 | wiem | 2 | 6 dni | 2.70 | dzień 8 |
| 8 | nie wiem | 0 | 1 dzień | 2.40 | dzień 9 |
| 9 | wiem | 1 | 1 dzień | 2.50 | dzień 10 |
| 10 | wiem | 2 | 6 dni | 2.60 | dzień 16 |
| 16 | wiem | 3 | 16 dni | 2.70 | dzień 32 |
| 32 | wiem | 4 | 43 dni | 2.80 | dzień 75 |

Zauważ: po jednej odpowiedzi "nie wiem" w dniu 8, fiszka wróciła na początek — ale ease factor spadł tylko trochę, więc po kilku poprawnych odpowiedziach interwały znów szybko rosną.

---

## Kolejność prezentowania fiszek (tryb dzienny)

Sesja ma trzy etapy:

1. **Nowe (pakiet dzienny)** — dostajesz określoną liczbę nowych fiszek na start dnia (domyślnie 10, ustawialne).
   Jeśli zrobisz tylko część, reszta czeka do końca dnia i pojawi się przy kolejnym logowaniu.
2. **Powtórki zaległe** — fiszki, których termin powtórki już minął (najpierw najstarsze zaległości).
3. **Reszta nowych (opcjonalnie)** — po komunikacie „cel dzienny osiągnięty” możesz kontynuować i przerabiać
   kolejne nowe fiszki aż do wyczerpania puli.

**Ważne:** nowe fiszki są losowane stabilnie na dany dzień, więc przy kolejnym logowaniu
zobaczysz te same „pozostałe” nowe, a nie inne.

Na ekranie startowym przycisk nauki pokazuje aktualny etap dnia:
**Nowe**, **Powtórki** albo **Dodatkowe nowe**.

---

## Dlaczego to działa?

Bazuje na **krzywej zapominania Ebbinghausa** (1885):
- Po nauczeniu czegoś nowego, zapominasz ~50% w ciągu 1 dnia
- Ale jeśli powtórzysz w odpowiednim momencie, zapominasz wolniej
- Każda powtórka wydłuża czas zapamiętywania

SM-2 oblicza **optymalny moment powtórki** — nie za wcześnie (strata czasu), nie za późno (już zapomniałeś).

---

Checklistę testów manualnych znajdziesz w `README.md`.
