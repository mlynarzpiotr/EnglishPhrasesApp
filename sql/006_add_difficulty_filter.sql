-- ============================================
-- Add: difficulty_filter to profiles
-- Wklej ten SQL w Supabase SQL Editor i kliknij Run
-- ============================================

ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS difficulty_filter TEXT NOT NULL DEFAULT 'all'
CHECK (difficulty_filter IN ('all', 'B2', 'C1'));
