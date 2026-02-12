-- ============================================
-- Add: first_seen_on to user_progress
-- Wklej ten SQL w Supabase SQL Editor i kliknij Run
-- ============================================

ALTER TABLE public.user_progress
ADD COLUMN IF NOT EXISTS first_seen_on DATE;
