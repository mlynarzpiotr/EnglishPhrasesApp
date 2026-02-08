const SUPABASE_URL = 'https://taelbqpknblktdamkfhi.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhZWxicXBrbmJsa3RkYW1rZmhpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA1NTI2NzAsImV4cCI6MjA4NjEyODY3MH0.xvkVrpKWlCcr7gtxaleQU67iPINMlZcKb7cuOtc-JK8';

// CDN tworzy globalną zmienną `supabase` (moduł z createClient)
// Nadpisujemy ją instancją klienta, której używają pozostałe pliki JS
supabase = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
