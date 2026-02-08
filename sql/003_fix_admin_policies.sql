-- ============================================
-- Fix: infinite recursion w politykach admina
-- Wklej ten SQL w Supabase SQL Editor i kliknij Run
-- ============================================

-- 1. Funkcja pomocnicza (SECURITY DEFINER = omija RLS)
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
$$ LANGUAGE sql SECURITY DEFINER;

-- 2. Usuń stare polityki admina (te z rekurencją)
DROP POLICY IF EXISTS "Admin reads all profiles" ON public.profiles;
DROP POLICY IF EXISTS "Admin updates profiles" ON public.profiles;

-- 3. Nowe polityki admina (bez rekurencji)
CREATE POLICY "Admin reads all profiles"
  ON public.profiles FOR SELECT
  USING (public.is_admin());

CREATE POLICY "Admin updates profiles"
  ON public.profiles FOR UPDATE
  USING (public.is_admin());
