-- ============================================
-- EnglishPhrasesApp — tworzenie tabel
-- Wklej ten SQL w Supabase SQL Editor i kliknij Run
-- ============================================

-- 1. Tabela profiles (rozszerzenie auth.users)
CREATE TABLE public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('admin', 'user')),
  approved BOOLEAN NOT NULL DEFAULT false,
  daily_goal INTEGER NOT NULL DEFAULT 10,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Tabela phrasal_verbs (zawartość edukacyjna)
CREATE TABLE public.phrasal_verbs (
  id SERIAL PRIMARY KEY,
  verb TEXT NOT NULL,
  definition_en TEXT NOT NULL,
  translation_pl TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('business', 'general', 'both')),
  tags TEXT[] NOT NULL DEFAULT '{}',
  register TEXT NOT NULL CHECK (register IN ('formal', 'informal', 'neutral')),
  difficulty TEXT NOT NULL CHECK (difficulty IN ('B2', 'C1')),
  examples JSONB NOT NULL DEFAULT '[]',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3. Tabela user_progress (postępy użytkownika per phrasal verb)
CREATE TABLE public.user_progress (
  id SERIAL PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  verb_id INTEGER NOT NULL REFERENCES public.phrasal_verbs(id) ON DELETE CASCADE,
  ease_factor FLOAT NOT NULL DEFAULT 2.5,
  interval_days INTEGER NOT NULL DEFAULT 0,
  repetitions INTEGER NOT NULL DEFAULT 0,
  next_review TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_reviewed TIMESTAMPTZ,
  times_seen INTEGER NOT NULL DEFAULT 0,
  times_known INTEGER NOT NULL DEFAULT 0,
  times_unknown INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, verb_id)
);

-- 4. Tabela session_log (historia sesji nauki)
CREATE TABLE public.session_log (
  id SERIAL PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  total_reviewed INTEGER NOT NULL DEFAULT 0,
  total_known INTEGER NOT NULL DEFAULT 0,
  total_unknown INTEGER NOT NULL DEFAULT 0,
  duration_seconds INTEGER NOT NULL DEFAULT 0
);

-- 5. Tabela streaks (seria dni nauki)
CREATE TABLE public.streaks (
  id SERIAL PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  current_streak INTEGER NOT NULL DEFAULT 0,
  longest_streak INTEGER NOT NULL DEFAULT 0,
  last_active_date DATE,
  UNIQUE(user_id)
);

-- ============================================
-- Trigger: automatyczne tworzenie profilu po rejestracji
-- ============================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role, approved, created_at, daily_goal)
  VALUES (NEW.id, NEW.email, 'user', false, now(), 10);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- ============================================
-- Row Level Security (RLS) — kto co może
-- ============================================

-- Włącz RLS na wszystkich tabelach
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.phrasal_verbs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.session_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.streaks ENABLE ROW LEVEL SECURITY;

-- PROFILES: użytkownik czyta swój profil, admin czyta wszystkie
CREATE POLICY "Users read own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Admin reads all profiles"
  ON public.profiles FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Admin updates profiles"
  ON public.profiles FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Users update own profile"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- PHRASAL_VERBS: wszyscy zatwierdzeni użytkownicy czytają
CREATE POLICY "Approved users read phrasal verbs"
  ON public.phrasal_verbs FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND approved = true
    )
  );

-- USER_PROGRESS: użytkownik czyta/pisze tylko swoje postępy
CREATE POLICY "Users read own progress"
  ON public.user_progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own progress"
  ON public.user_progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users update own progress"
  ON public.user_progress FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- SESSION_LOG: użytkownik czyta/pisze tylko swoje sesje
CREATE POLICY "Users read own sessions"
  ON public.session_log FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own sessions"
  ON public.session_log FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- STREAKS: użytkownik czyta/pisze tylko swoje dane
CREATE POLICY "Users read own streaks"
  ON public.streaks FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own streaks"
  ON public.streaks FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users update own streaks"
  ON public.streaks FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
