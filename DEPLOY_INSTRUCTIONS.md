# Instrukcja Deployu na GitHub Pages

Ponieważ nie mam bezpośredniego dostępu do wykonywania komend `git` w Twoim folderze, musisz wykonać te kroki ręcznie w terminalu.

## Krok 1: Inicjalizacja Repozytorium

Otwórz terminal i upewnij się, że jesteś w folderze projektu:
```bash
cd "/Users/piotrmlynarz/Documents/Claude Code Projects/EnglishPhrasesApp"
```

Zinicjuj repozytorium i zatwierdź pliki:
```bash
git init
git add .
git commit -m "Initial commit"
```

## Krok 2: Utworzenie Repozytorium na GitHub

1. Zaloguj się na [GitHub.com](https://github.com).
2. Kliknij "**New repository**" (lub `+` w prawym górnym rogu).
3. Podaj nazwę, np. `EnglishPhrasesApp`.
4. Wybierz opcję **Public**.
5. **Nie** dodawaj README, .gitignore ani licencji (masz już swoje pliki).
6. Kliknij **Create repository**.

## Krok 3: Wypchnięcie Kodu

Skopiuj komendy z sekcji "...or push an existing repository from the command line" na GitHubie i wklej je do terminala. Powinny wyglądać mniej więcej tak (zastąp `TWOJA_NAZWA` swoim loginem):

```bash
git remote add origin https://github.com/TWOJA_NAZWA/EnglishPhrasesApp.git
git branch -M main
git push -u origin main
```

## Krok 4: Włączenie GitHub Pages

1. W swoim repozytorium na GitHubie wejdź w **Settings**.
2. W menu po lewej wybierz **Pages**.
3. W sekcji **Build and deployment** -> **Source** wybierz `Deploy from a branch`.
4. W sekcji **Branch** wybierz `main` i folder `/ (root)`.
5. Kliknij **Save**.

Po kilku minutach Twoja strona będzie dostępna pod adresem:
`https://TWOJA_NAZWA.github.io/EnglishPhrasesApp/`
