-- ============================================
-- Update phrasal verbs 200-275 with improved content
-- Wklej ten SQL w Supabase SQL Editor i kliknij Run
-- ============================================

UPDATE public.phrasal_verbs
SET 
  verb = 'get across',
  definition_en = 'To successfully communicate or make someone understand an idea, message, or feeling. Often used when expressing something complex or important.',
  translation_pl = 'przekazać (myśl, ideę); wyjaśnić zrozumiale; dotrzeć do kogoś z przekazem',
  category = 'business',
  tags = '{communication,presentations}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "He struggled to get his point across during the heated debate.", "context": "a speaker having difficulty being understood in a tense meeting", "tense": "Past Simple", "grammar_note": "struggled + to get + noun + across (separable phrasal verb with infinitive)"}, {"sentence": "We need to get the message across that safety comes first in all operations.", "context": "management emphasizing company policy to all employees", "tense": "Infinitive", "grammar_note": "need + to get + noun + across + that-clause (separable with content clause)"}, {"sentence": "The presentation really got the value proposition across to potential investors.", "context": "a successful sales pitch demonstrating product benefits clearly", "tense": "Past Simple", "grammar_note": "got + noun + across + to someone (separable with indirect object)"}, {"sentence": "How can we best get this concept across to the team without overwhelming them?", "context": "planning a training strategy for a complicated new workflow", "tense": "Modal Interrogative", "grammar_note": "can + we + get + noun + across (interrogative with modal)"}]'::JSONB
WHERE id = 200;

UPDATE public.phrasal_verbs
SET 
  verb = 'jot down',
  definition_en = 'To write something quickly and briefly, often as a reminder or note. Implies informal, rapid writing rather than careful documentation.',
  translation_pl = 'zanotować szybko; bazgrać; zapisać na szybko; skreślić notkę',
  category = 'business',
  tags = '{meetings,notes}'::TEXT[],
  register = 'informal',
  difficulty = 'B2',
  examples = '[{"sentence": "I''ll just jot down your phone number before I forget it.", "context": "someone quickly recording contact details during a conversation", "tense": "Future Simple", "grammar_note": "will + jot down + noun (separable phrasal verb)"}, {"sentence": "Did you jot down the key points from the speaker''s presentation?", "context": "checking if someone took notes during a lecture or conference", "tense": "Past Simple Interrogative", "grammar_note": "did + you + jot down + noun (interrogative past simple)"}, {"sentence": "Let me grab a pen so I can jot this down properly.", "context": "receiving important information during a phone call and needing to record it", "tense": "Infinitive", "grammar_note": "can + jot + this + down (separable with pronoun between verb and particle)"}, {"sentence": "She is always jotting down ideas in her notebook during brainstorming sessions.", "context": "describing someone''s creative habit of capturing thoughts as they occur", "tense": "Present Continuous", "grammar_note": "is + always + jotting down + noun (continuous with ''always'' for habitual action)"}]'::JSONB
WHERE id = 201;

UPDATE public.phrasal_verbs
SET 
  verb = 'run through',
  definition_en = 'To review, practice, or rehearse something quickly before the main event. Can also mean to check or go over information systematically.',
  translation_pl = 'przećwiczyć; przejrzeć szybko; omówić w skrócie; przebiec wzrokiem',
  category = 'business',
  tags = '{presentations,meetings}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Let''s run through the presentation one more time before the client arrives.", "context": "a team doing a final rehearsal to ensure everything is polished", "tense": "Imperative", "grammar_note": "let''s + run through + noun (imperative with ''let''s'' for suggestion)"}, {"sentence": "Can we run through the agenda quickly at the start of the meeting?", "context": "requesting a brief overview of topics to be covered", "tense": "Modal Interrogative", "grammar_note": "can + we + run through + noun (modal question for polite request)"}, {"sentence": "I''ll run through the main points of the proposal now to save time later.", "context": "providing a summary to give colleagues a preview of key content", "tense": "Future Simple", "grammar_note": "will + run through + noun (future with purpose clause)"}, {"sentence": "Running through the safety checklist before every shift is mandatory in our factory.", "context": "describing a required procedure to ensure workplace compliance", "tense": "Gerund", "grammar_note": "running through + noun (gerund as subject of sentence)"}]'::JSONB
WHERE id = 202;

UPDATE public.phrasal_verbs
SET 
  verb = 'stand for',
  definition_en = 'To represent or be an abbreviation for something. Also means to tolerate or support certain values or principles.',
  translation_pl = 'oznaczać (skrót); reprezentować (wartości); tolerować; popierać (zasady)',
  category = 'business',
  tags = '{general,values}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "What does CEO stand for in a corporate structure?", "context": "someone learning business terminology and asking about acronyms", "tense": "Present Simple Interrogative", "grammar_note": "does + noun + stand for (interrogative for asking about meaning)"}, {"sentence": "Our company stands for integrity, quality, and innovation in everything we do.", "context": "a brand statement defining the organization''s core values", "tense": "Present Simple", "grammar_note": "stands for + list (expressing values or principles)"}, {"sentence": "We will not stand for harassment or discrimination in the workplace under any circumstances.", "context": "a firm policy statement about unacceptable behavior", "tense": "Future Negative", "grammar_note": "will not + stand for + noun (negative future for strong refusal)"}, {"sentence": "I don''t know what this technical acronym stands for — can you explain it?", "context": "requesting clarification on unfamiliar industry jargon", "tense": "Present Simple", "grammar_note": "don''t know + what + stands for (embedded question)"}]'::JSONB
WHERE id = 203;

UPDATE public.phrasal_verbs
SET 
  verb = 'talk over',
  definition_en = 'To discuss a problem, plan, or situation thoroughly with someone before making a decision. Implies collaborative conversation and consideration.',
  translation_pl = 'przedyskutować; omówić szczegółowo; przegadać (sprawę); skonsultować się',
  category = 'business',
  tags = '{meetings,discussions}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "We need to talk over the proposal carefully before presenting it to the board.", "context": "ensuring all team members align on details before a high-stakes meeting", "tense": "Infinitive", "grammar_note": "need + to talk over + noun (infinitive expressing necessity)"}, {"sentence": "They talked it over for hours before reaching a final decision.", "context": "a lengthy deliberation process during difficult negotiations", "tense": "Past Simple", "grammar_note": "talked + it + over (separable with pronoun between verb and particle)"}, {"sentence": "Let''s talk this over lunch tomorrow — it''s too complex for email.", "context": "suggesting an informal face-to-face meeting for a nuanced topic", "tense": "Imperative", "grammar_note": "let''s + talk + this + over (imperative separable form)"}, {"sentence": "Talking things over with colleagues helps clarify the situation and reduces misunderstandings.", "context": "advice about the benefits of collaborative problem-solving", "tense": "Gerund", "grammar_note": "talking + things + over (gerund as subject, separable)"}]'::JSONB
WHERE id = 204;

UPDATE public.phrasal_verbs
SET 
  verb = 'weigh up',
  definition_en = 'To carefully consider and compare the advantages and disadvantages of different options before making a decision. Implies thoughtful evaluation.',
  translation_pl = 'rozważyć (za i przeciw); ocenić; zważyć (opcje); przeanalizować dokładnie',
  category = 'business',
  tags = '{decision making,analysis}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence": "We need to weigh up the benefits and risks before committing to this investment.", "context": "a finance team conducting due diligence on a major business opportunity", "tense": "Infinitive", "grammar_note": "need + to weigh up + noun (infinitive with necessity modal)"}, {"sentence": "She weighed up her options carefully before deciding to quit her stable job.", "context": "someone making a difficult career change after thorough consideration", "tense": "Past Simple", "grammar_note": "weighed up + noun + before + gerund (past simple with time clause)"}, {"sentence": "After weighing everything up, we chose Plan B as the safer alternative.", "context": "arriving at a strategic decision after comprehensive analysis", "tense": "Gerund (Participle Clause)", "grammar_note": "after + weighing + everything + up (separable in participle clause)"}, {"sentence": "It''s difficult to weigh up intangible assets like brand reputation when valuing a company.", "context": "discussing challenges in corporate valuation and financial assessment", "tense": "Infinitive", "grammar_note": "difficult + to weigh up + noun (infinitive after adjective)"}]'::JSONB
WHERE id = 205;

UPDATE public.phrasal_verbs
SET 
  verb = 'account for',
  definition_en = 'To explain the reason or cause of something. Also means to constitute or represent a particular portion of a total.',
  translation_pl = 'stanowić (część całości); wyjaśniać (przyczynę); rozliczać się z czegoś; tłumaczyć',
  category = 'business',
  tags = '{finance,reporting}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "How do you account for the significant loss in revenue this quarter?", "context": "an auditor questioning management about unexpected financial results", "tense": "Present Simple Interrogative", "grammar_note": "how + do + you + account for + noun (interrogative seeking explanation)"}, {"sentence": "Sales in the Asian market account for approximately 30% of our total profit.", "context": "a financial report breaking down revenue by geographical region", "tense": "Present Simple", "grammar_note": "account for + percentage (expressing proportion or composition)"}, {"sentence": "They couldn''t account for the missing files during the investigation.", "context": "an inquiry into lost documents revealing gaps in record-keeping", "tense": "Past Modal Negative", "grammar_note": "couldn''t + account for + noun (past modal negative for inability)"}, {"sentence": "There are several external factors we need to account for when planning next year''s budget.", "context": "strategic planning considering variables beyond the organization''s control", "tense": "Infinitive", "grammar_note": "need + to account for + noun (infinitive expressing requirement)"}]'::JSONB
WHERE id = 206;

UPDATE public.phrasal_verbs
SET 
  verb = 'back up',
  definition_en = 'To support someone''s statement or position. In technology, to create a copy of data for security. Can also mean to move backwards or cause congestion.',
  translation_pl = 'poprzeć (kogoś); wesprzeć; zrobić kopię zapasową; cofnąć się; zatykać (ruch)',
  category = 'business',
  tags = '{it,teamwork}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Don''t forget to back up your files daily to avoid losing important work.", "context": "an IT policy reminder about data protection procedures", "tense": "Imperative", "grammar_note": "don''t forget + to back up + noun (negative imperative with infinitive)"}, {"sentence": "My manager backed me up completely during the difficult client meeting.", "context": "receiving support from a superior when facing challenging questions", "tense": "Past Simple", "grammar_note": "backed + me + up (separable with pronoun in middle position)"}, {"sentence": "We need solid evidence to back up these claims in court.", "context": "preparing for legal proceedings by gathering supporting documentation", "tense": "Infinitive", "grammar_note": "need + evidence + to back up + noun (infinitive of purpose)"}, {"sentence": "The traffic was backed up for miles due to the accident on the motorway.", "context": "describing a logistics delay caused by road congestion", "tense": "Past Simple Passive", "grammar_note": "was + backed up (passive voice indicating state)"}]'::JSONB
WHERE id = 207;

UPDATE public.phrasal_verbs
SET 
  verb = 'bank on',
  definition_en = 'To rely confidently on something happening or to count on a particular outcome. Implies strong expectation or dependence.',
  translation_pl = 'liczyć na coś (pewnie); stawiać na coś; być przekonanym; ufać że coś się stanie',
  category = 'business',
  tags = '{planning,finance}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence": "We are banking on a significant sales increase this quarter to meet our annual targets.", "context": "company forecasting that relies heavily on upcoming revenue growth", "tense": "Present Continuous", "grammar_note": "are + banking on + noun + to-infinitive (continuous for current plan)"}, {"sentence": "Don''t bank on the loan being approved — we should have a backup plan ready.", "context": "warning against overconfidence when waiting for financial approval", "tense": "Negative Imperative", "grammar_note": "don''t + bank on + noun/gerund (imperative with gerund object)"}, {"sentence": "I wouldn''t bank on it if I were you — the situation is too unpredictable.", "context": "expressing skepticism about someone''s expectations in uncertain conditions", "tense": "Conditional", "grammar_note": "wouldn''t + bank on + it (conditional for hypothetical advice)"}, {"sentence": "They unwisely banked on their main competitor failing rather than improving their own product.", "context": "criticizing a flawed business strategy based on competitor weakness", "tense": "Past Simple", "grammar_note": "banked on + noun/gerund (past simple with gerund object)"}]'::JSONB
WHERE id = 208;

UPDATE public.phrasal_verbs
SET 
  verb = 'break into',
  definition_en = 'To successfully enter a new market, industry, or field, often despite barriers or competition. Can also mean to enter forcibly (literal breaking in).',
  translation_pl = 'wejść na rynek (z sukcesem); przebić się (do branży); wedrzeć się; włamać się',
  category = 'business',
  tags = '{expansion,marketing}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "It is extremely difficult to break into the highly regulated Chinese pharmaceutical market.", "context": "discussing challenges of international business expansion in protected sectors", "tense": "Infinitive", "grammar_note": "difficult + to break into + noun (infinitive after adjective)"}, {"sentence": "They successfully broke into the luxury fashion sector after years of positioning their brand.", "context": "a company achieving market entry after long-term strategic preparation", "tense": "Past Simple", "grammar_note": "broke into + noun (past simple for completed achievement)"}, {"sentence": "We are currently trying to break into a new demographic with this product line.", "context": "marketing strategy aimed at reaching previously untapped customer segments", "tense": "Present Continuous", "grammar_note": "are + trying + to break into + noun (continuous with infinitive)"}, {"sentence": "Breaking into this industry requires both technical expertise and strong networking connections.", "context": "advice about barriers to entry in a competitive professional field", "tense": "Gerund", "grammar_note": "breaking into + noun (gerund as subject requiring plural verb)"}]'::JSONB
WHERE id = 209;

UPDATE public.phrasal_verbs
SET 
  verb = 'bring down',
  definition_en = 'To reduce or lower costs, prices, levels, or rates. Can also mean to cause the fall or defeat of a leader or organization.',
  translation_pl = 'obniżyć (ceny, koszty); zredukować; obalić (rząd, lidera); spowodować upadek',
  category = 'business',
  tags = '{finance,pricing}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "We aim to bring down production costs by 15% through process automation.", "context": "a manufacturing company setting efficiency improvement targets", "tense": "Infinitive", "grammar_note": "aim + to bring down + noun + by percentage (infinitive with quantifier)"}, {"sentence": "Increased competition has brought down prices significantly across the entire sector.", "context": "market analysis showing how rivalry affects pricing dynamics", "tense": "Present Perfect", "grammar_note": "has + brought down + noun (present perfect for recent change with impact)"}, {"sentence": "Can you bring down the final offer by another £5,000 to close this deal?", "context": "negotiation tactics during contract discussions seeking price reduction", "tense": "Modal Interrogative", "grammar_note": "can + you + bring down + noun (modal question for request)"}, {"sentence": "The corruption scandal ultimately brought down the CEO and several board members.", "context": "corporate governance crisis resulting in leadership changes (alternative meaning)", "tense": "Past Simple", "grammar_note": "brought down + noun (past simple for completed downfall)"}]'::JSONB
WHERE id = 210;

UPDATE public.phrasal_verbs
SET 
  verb = 'cash in on',
  definition_en = 'To take advantage of a situation or opportunity to make money or gain benefit. Often implies opportunistic behavior or capitalizing on trends.',
  translation_pl = 'zarobić na czymś; skorzystać z okazji; wykorzystać sytuację (do zysku); zbić kapitał',
  category = 'business',
  tags = '{finance,strategy}'::TEXT[],
  register = 'informal',
  difficulty = 'C1',
  examples = '[{"sentence": "The company cashed in on the sudden surge in demand during the pandemic.", "context": "a business capitalizing on market conditions created by global crisis", "tense": "Past Simple", "grammar_note": "cashed in on + noun (inseparable phrasal verb)"}, {"sentence": "We should cash in on our brand''s current popularity while consumer sentiment is strong.", "context": "strategic planning to maximize returns during a favorable period", "tense": "Modal (should)", "grammar_note": "should + cash in on + noun (modal for advice)"}, {"sentence": "Investors are cashing in on rising tech stocks before the bubble bursts.", "context": "market behavior as speculators take profits amid growing valuations", "tense": "Present Continuous", "grammar_note": "are + cashing in on + noun (continuous for ongoing action)"}, {"sentence": "Don''t miss the chance to cash in on this limited-time market opportunity.", "context": "investment advice urging quick action on a time-sensitive situation", "tense": "Infinitive", "grammar_note": "chance + to cash in on + noun (infinitive after noun)"}]'::JSONB
WHERE id = 211;

UPDATE public.phrasal_verbs
SET 
  verb = 'contract out',
  definition_en = 'To outsource work or services to an external company or contractor rather than handling them internally. Common in business operations and project management.',
  translation_pl = 'zlecić na zewnątrz; zoutsource''ować; przekazać wykonawcy zewnętrznemu; wydzierżawić',
  category = 'business',
  tags = '{operations,hr}'::TEXT[],
  register = 'formal',
  difficulty = 'C1',
  examples = '[{"sentence": "We decided to contract out the IT support services to reduce overhead costs.", "context": "a cost-cutting measure involving outsourcing of non-core functions", "tense": "Infinitive", "grammar_note": "decided + to contract out + noun (infinitive after decision verb)"}, {"sentence": "Manufacturing is often contracted out to facilities in lower-cost Asian countries.", "context": "explaining global supply chain strategies in multinational corporations", "tense": "Present Simple Passive", "grammar_note": "is + contracted out + to location (passive for general practice)"}, {"sentence": "Contracting out this entire project phase will save us significant time and resources.", "context": "project management decision based on capacity and efficiency analysis", "tense": "Gerund", "grammar_note": "contracting out + noun (gerund as subject with future benefit)"}, {"sentence": "They routinely contract out most of their specialized technical work to freelance experts.", "context": "describing a company''s standard operating model for accessing talent", "tense": "Present Simple", "grammar_note": "contract out + noun + to someone (habitual action with recipient)"}]'::JSONB
WHERE id = 212;

UPDATE public.phrasal_verbs
SET 
  verb = 'dip into',
  definition_en = 'To use a small portion of savings, reserves, or resources that you would prefer to keep intact. Implies drawing from limited funds reluctantly.',
  translation_pl = 'sięgnąć do (oszczędności, rezerw); uszczuplić; nadwyrężyć (budżet); wykorzystać część',
  category = 'business',
  tags = '{finance,banking}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence": "We had to dip into our emergency reserves to cover unexpected operational expenses.", "context": "a company facing cash flow difficulties requiring use of contingency funds", "tense": "Past Simple", "grammar_note": "had to + dip into + noun (past modal expressing necessity)"}, {"sentence": "Try to avoid dipping into the pension fund for short-term cash needs.", "context": "financial planning advice warning against depleting retirement savings", "tense": "Gerund (after ''avoid'')", "grammar_note": "avoid + dipping into + noun (gerund after verb requiring gerund object)"}, {"sentence": "Sales are down this quarter, so we are dipping into savings to maintain inventory levels.", "context": "explaining temporary financial measures during a revenue shortfall", "tense": "Present Continuous", "grammar_note": "are + dipping into + noun (continuous for temporary current action)"}, {"sentence": "He reluctantly dipped into his own pocket to pay for the client entertainment expenses.", "context": "an employee using personal funds when company reimbursement isn''t available", "tense": "Past Simple", "grammar_note": "dipped into + possessive + noun (with adverb showing reluctance)"}]'::JSONB
WHERE id = 213;

UPDATE public.phrasal_verbs
SET 
  verb = 'do away with',
  definition_en = 'To abolish, eliminate, or get rid of something completely, especially rules, systems, or practices. Often used for formal or permanent removal.',
  translation_pl = 'zlikwidować; znieść (przepis, zwyczaj); pozbyć się; wyeliminować; usunąć całkowicie',
  category = 'business',
  tags = '{policy,change mgmt}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence": "We should do away with unnecessary bureaucratic paperwork to improve efficiency.", "context": "a reform proposal targeting administrative burden reduction", "tense": "Modal (should)", "grammar_note": "should + do away with + noun (modal for recommendation)"}, {"sentence": "They did away with the old performance bonus system and introduced equity compensation instead.", "context": "HR policy overhaul replacing one reward structure with another", "tense": "Past Simple", "grammar_note": "did away with + noun + and + past simple (coordinated actions)"}, {"sentence": "The department was not completely done away with, but its functions were significantly reduced.", "context": "organizational restructuring involving partial rather than total elimination", "tense": "Past Simple Passive", "grammar_note": "was not + done away with (passive negative for partial action)"}, {"sentence": "Doing away with these outdated rules will boost employee morale and innovation.", "context": "arguing for cultural change by removing restrictive policies", "tense": "Gerund", "grammar_note": "doing away with + noun (gerund as subject with future consequence)"}]'::JSONB
WHERE id = 214;

UPDATE public.phrasal_verbs
SET 
  verb = 'drag on',
  definition_en = 'To continue for an excessively long time, usually longer than expected or desired. Often implies boredom, frustration, or inefficiency.',
  translation_pl = 'ciągnąć się (w nieskończoność); przeciągać się; wlec się; trwać zbyt długo',
  category = 'business',
  tags = '{meetings,projects}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The quarterly review meeting dragged on for over three hours with no clear outcome.", "context": "frustration about an unproductive and unnecessarily lengthy session", "tense": "Past Simple", "grammar_note": "dragged on + for duration (past simple with time expression)"}, {"sentence": "Don''t let the contract negotiations drag on indefinitely — set a firm deadline.", "context": "advice to maintain momentum and avoid endless discussions", "tense": "Negative Imperative", "grammar_note": "don''t let + noun + drag on (causative with imperative)"}, {"sentence": "This restructuring project has dragged on for far too long already.", "context": "expressing impatience about delayed organizational changes", "tense": "Present Perfect", "grammar_note": "has + dragged on + for duration (present perfect with time adverbial)"}, {"sentence": "If the legal dispute drags on much longer, our legal costs will become unsustainable.", "context": "warning about financial consequences of protracted litigation", "tense": "First Conditional", "grammar_note": "if + present simple, will + infinitive (conditional with future consequence)"}]'::JSONB
WHERE id = 215;

UPDATE public.phrasal_verbs
SET 
  verb = 'draw on',
  definition_en = 'To use or make use of a resource, experience, knowledge, or skill that is available. Implies accessing existing assets or capabilities when needed.',
  translation_pl = 'czerpać z (doświadczenia, zasobów); korzystać z; wykorzystywać; opierać się na',
  category = 'business',
  tags = '{skills,resources}'::TEXT[],
  register = 'formal',
  difficulty = 'C1',
  examples = '[{"sentence": "I will draw on my fifteen years of marketing experience when developing this campaign strategy.", "context": "applying accumulated professional knowledge to a new project", "tense": "Future Simple", "grammar_note": "will + draw on + noun + when + gerund (future with time clause)"}, {"sentence": "The company draws on a global network of technical experts for specialized projects.", "context": "describing how an organization accesses external talent resources", "tense": "Present Simple", "grammar_note": "draws on + noun + for purpose (habitual action with purpose)"}, {"sentence": "We can draw on the strategic reserve fund if we face unexpected cash shortages.", "context": "explaining contingency financial planning and available backup resources", "tense": "Modal (can)", "grammar_note": "can + draw on + noun + if clause (modal possibility with condition)"}, {"sentence": "He successfully drew on his legal background to negotiate favorable contract terms.", "context": "someone leveraging their professional training in a business situation", "tense": "Past Simple", "grammar_note": "drew on + noun + to-infinitive (past simple with purpose infinitive)"}]'::JSONB
WHERE id = 216;

UPDATE public.phrasal_verbs
SET 
  verb = 'drop in',
  definition_en = 'To visit someone briefly and casually, usually without a prior appointment or formal arrangement. Implies informal, spontaneous visiting.',
  translation_pl = 'wpaść (z wizytą); zajść; wpasć na chwilę; odwiedzić niespodziewanie',
  category = 'general',
  tags = '{social,office}'::TEXT[],
  register = 'informal',
  difficulty = 'B2',
  examples = '[{"sentence": "Feel free to drop in anytime if you have questions about the new software system.", "context": "a manager encouraging open-door communication with team members", "tense": "Imperative", "grammar_note": "feel free + to drop in (imperative with infinitive for permission)"}, {"sentence": "I''ll drop in on the client while I''m in London next week to maintain our relationship.", "context": "relationship-building through informal face-to-face contact during travel", "tense": "Future Simple", "grammar_note": "will + drop in on someone (with preposition ''on'' for visiting someone)"}, {"sentence": "She dropped in to say hello and ended up staying for an hour discussing the project.", "context": "a casual visit that unexpectedly turned into a longer conversation", "tense": "Past Simple", "grammar_note": "dropped in + to-infinitive + and + past simple (purpose with result)"}, {"sentence": "Sales figures dropped in Q3 due to seasonal market conditions.", "context": "CAUTION: different meaning — ''dropped'' (decreased) + ''in Q3'' (not phrasal verb)", "tense": "Past Simple", "grammar_note": "NOT phrasal verb — ''dropped'' + prepositional phrase (separate words)"}]'::JSONB
WHERE id = 217;

UPDATE public.phrasal_verbs
SET 
  verb = 'drop off',
  definition_en = 'To deliver someone or something to a location. Also means to decrease or decline in quantity, level, or intensity.',
  translation_pl = 'podrzucić (kogoś/coś); dostarczyć; spaść (o liczbie, sprzedaży); zmniejszyć się',
  category = 'business',
  tags = '{logistics,sales}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Can you drop off these confidential documents at headquarters on your way home?", "context": "asking a colleague to deliver materials during their commute", "tense": "Modal Interrogative", "grammar_note": "can + you + drop off + noun (modal question for polite request)"}, {"sentence": "Customer demand dropped off sharply after the holiday shopping season ended.", "context": "analyzing seasonal sales patterns and post-peak decline", "tense": "Past Simple", "grammar_note": "dropped off + adverb (intransitive meaning ''decreased'')"}, {"sentence": "I need to drop off a parcel at the courier collection point before 5 PM.", "context": "logistics task requiring delivery within a specific timeframe", "tense": "Infinitive", "grammar_note": "need + to drop off + noun + at location (transitive with destination)"}, {"sentence": "Attendance at training sessions has dropped off significantly in recent months.", "context": "HR concern about declining employee participation levels", "tense": "Present Perfect", "grammar_note": "has + dropped off + adverb (present perfect for recent change)"}]'::JSONB
WHERE id = 218;

UPDATE public.phrasal_verbs
SET 
  verb = 'face up to',
  definition_en = 'To accept and deal with a difficult, unpleasant, or challenging situation or truth rather than avoiding or denying it. Often implies courage or maturity in confronting reality.',
  translation_pl = 'stawić czoła (czemuś); zmierzyć się z (problemem); przyznać się do (prawdy); zaakceptować (trudną rzeczywistość)',
  category = 'business',
  tags = '{responsibility,challenges}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence": "The CEO finally faced up to the company''s declining market share.", "context": "a leader acknowledging a serious business problem after months of denial", "tense": "Past Simple", "grammar_note": "faced up to + noun phrase (inseparable phrasal verb in active voice)"}, {"sentence": "We need to face up to the fact that our current strategy isn''t working.", "context": "a management team discussing the necessity of strategic change", "tense": "Present Simple (infinitive)", "grammar_note": "need to + face up to + that-clause (inseparable phrasal verb after modal construction)"}, {"sentence": "She has been facing up to her mistakes and learning from them.", "context": "an employee demonstrating personal growth after making errors", "tense": "Present Perfect Continuous", "grammar_note": "has been facing up to + noun phrase (inseparable phrasal verb in present perfect continuous)"}, {"sentence": "If we don''t face up to these challenges now, they''ll only get worse.", "context": "a consultant warning about the consequences of avoiding difficult decisions", "tense": "Present Simple (conditional)", "grammar_note": "don''t + face up to + noun (inseparable phrasal verb in negative conditional clause)"}]'::JSONB
WHERE id = 219;

UPDATE public.phrasal_verbs
SET 
  verb = 'fight off',
  definition_en = 'To successfully resist or defend against competition, threats, or challenges through determined effort. In business contexts, often refers to defending market position or resisting takeover attempts.',
  translation_pl = 'odeprzeć (atak, konkurencję); obronić się przed (zagrożeniem); powstrzymać (próbę przejęcia); zwalczyć (rywali)',
  category = 'business',
  tags = '{strategy,competition}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The company fought off three takeover bids last year.", "context": "a firm successfully resisting acquisition attempts by larger competitors", "tense": "Past Simple", "grammar_note": "fought off + noun phrase (separable phrasal verb, object placed after particle)"}, {"sentence": "We''re fighting off intense competition from new market entrants.", "context": "a business dealing with aggressive rivals threatening their market share", "tense": "Present Continuous", "grammar_note": "are fighting off + noun phrase (separable phrasal verb in present continuous active)"}, {"sentence": "They had fought off bankruptcy through aggressive cost-cutting measures.", "context": "a struggling company that avoided financial collapse through difficult decisions", "tense": "Past Perfect", "grammar_note": "had fought off + noun (separable phrasal verb in past perfect, showing completed action before another past event)"}, {"sentence": "The brand will need to fight off cheaper alternatives to maintain premium positioning.", "context": "a marketing team discussing competitive strategy for a high-end product", "tense": "Future Simple (infinitive)", "grammar_note": "will need to + fight off + noun phrase (separable phrasal verb after modal construction)"}]'::JSONB
WHERE id = 220;

UPDATE public.phrasal_verbs
SET 
  verb = 'focus on',
  definition_en = 'To concentrate attention, effort, or resources on a particular task, goal, or subject. Implies prioritization and directing energy toward specific objectives while potentially excluding others.',
  translation_pl = 'skupić się na (czymś); skoncentrować się na (zadaniu); poświęcić uwagę (priorytetowi); nacisk na (cel)',
  category = 'general',
  tags = '{strategy,productivity}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Let''s focus on the key deliverables for this quarter.", "context": "a project manager redirecting team attention to critical priorities", "tense": "Present Simple (imperative)", "grammar_note": "let''s + focus on + noun phrase (inseparable phrasal verb in imperative suggestion form)"}, {"sentence": "She focused on building relationships with key stakeholders throughout the project.", "context": "a consultant describing her strategic approach to client management", "tense": "Past Simple", "grammar_note": "focused on + gerund phrase (inseparable phrasal verb followed by -ing form)"}, {"sentence": "The team has been focusing on operational efficiency improvements.", "context": "a department dedicating sustained effort to streamlining processes", "tense": "Present Perfect Continuous", "grammar_note": "has been focusing on + noun phrase (inseparable phrasal verb in present perfect continuous)"}, {"sentence": "We should focus on what we can control rather than external factors.", "context": "a leader advising team members during uncertain market conditions", "tense": "Present Simple (modal)", "grammar_note": "should + focus on + what-clause (inseparable phrasal verb after modal verb)"}]'::JSONB
WHERE id = 221;

UPDATE public.phrasal_verbs
SET 
  verb = 'get down to',
  definition_en = 'To begin working seriously and focusing on the main task or business at hand, often after preliminaries or distractions. Suggests a shift from casual discussion to productive work.',
  translation_pl = 'zabrać się (poważnie) do (pracy); przejść do (sedna sprawy); skupić się na (konkretach); zająć się (rzeczywistą pracą)',
  category = 'business',
  tags = '{meetings,productivity}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "After the coffee break, we got down to discussing the budget.", "context": "a meeting transitioning from informal chat to serious financial planning", "tense": "Past Simple", "grammar_note": "got down to + gerund (inseparable phrasal verb followed by -ing form)"}, {"sentence": "It''s time to get down to business and finalize this proposal.", "context": "a team leader ending small talk and initiating focused work session", "tense": "Present Simple (infinitive)", "grammar_note": "time to + get down to + noun (inseparable phrasal verb in infinitive after ''it''s time'')"}, {"sentence": "We''ve been getting down to the details of the implementation plan.", "context": "a project team working through specific technical requirements", "tense": "Present Perfect Continuous", "grammar_note": "have been getting down to + noun phrase (inseparable phrasal verb in present perfect continuous)"}, {"sentence": "Let''s skip the introductions and get down to the main agenda items.", "context": "a facilitator starting a time-constrained meeting efficiently", "tense": "Present Simple (imperative)", "grammar_note": "let''s + get down to + noun phrase (inseparable phrasal verb in imperative suggestion)"}]'::JSONB
WHERE id = 222;

UPDATE public.phrasal_verbs
SET 
  verb = 'go under',
  definition_en = 'To fail completely as a business and cease operations, typically due to bankruptcy or insurmountable financial difficulties. Describes the final collapse of a company.',
  translation_pl = 'upaść (o firmie); zbankrutować; zakończyć działalność (z powodu problemów finansowych); splajtować (potocznie)',
  category = 'business',
  tags = '{finance,bankruptcy}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Three major retailers went under during the economic downturn.", "context": "news report describing business casualties of a recession", "tense": "Past Simple", "grammar_note": "went under (intransitive phrasal verb, no object required)"}, {"sentence": "The company is going under unless we secure emergency funding immediately.", "context": "a CFO warning the board about imminent financial collapse", "tense": "Present Continuous", "grammar_note": "is going under (intransitive phrasal verb in present continuous showing ongoing process)"}, {"sentence": "Many startups had gone under before finding product-market fit.", "context": "an entrepreneur reflecting on the high failure rate in the startup ecosystem", "tense": "Past Perfect", "grammar_note": "had gone under (intransitive phrasal verb in past perfect, showing completion before another past point)"}, {"sentence": "Without restructuring, the business will go under within six months.", "context": "a consultant presenting stark findings about a company''s financial trajectory", "tense": "Future Simple", "grammar_note": "will go under (intransitive phrasal verb in future simple with time expression)"}]'::JSONB
WHERE id = 223;

UPDATE public.phrasal_verbs
SET 
  verb = 'hand in',
  definition_en = 'To submit or deliver something officially to a person in authority, such as a report, resignation, or completed work. Implies formal transfer of documents or materials.',
  translation_pl = 'złożyć (dokument, rezygnację); wręczyć (oficjalnie); oddać (pracę, raport); przekazać (formalnie)',
  category = 'business',
  tags = '{hr,admin}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "She handed in her resignation yesterday after accepting a new position.", "context": "an employee formally notifying HR of her departure from the company", "tense": "Past Simple", "grammar_note": "handed in + noun (separable phrasal verb, object placed after particle)"}, {"sentence": "All team members must hand in their expense reports by Friday.", "context": "a manager setting a deadline for administrative submissions", "tense": "Present Simple (modal)", "grammar_note": "must + hand in + noun phrase (separable phrasal verb after modal verb)"}, {"sentence": "I''m handing in my project documentation to the steering committee tomorrow.", "context": "a project lead preparing to submit final deliverables to senior leadership", "tense": "Present Continuous", "grammar_note": "am handing in + noun phrase (separable phrasal verb in present continuous with time marker)"}, {"sentence": "He had handed in his notice two weeks before the scandal broke.", "context": "an employee who coincidentally resigned just before company crisis emerged", "tense": "Past Perfect", "grammar_note": "had handed in + noun (separable phrasal verb in past perfect showing prior completion)"}]'::JSONB
WHERE id = 224;

UPDATE public.phrasal_verbs
SET 
  verb = 'head up',
  definition_en = 'To lead or be in charge of a team, project, department, or organization. Implies taking the position of primary responsibility and leadership.',
  translation_pl = 'kierować (projektem, zespołem); stać na czele (działu); przewodzić (inicjatywie); zarządzać (obszarem)',
  category = 'business',
  tags = '{management,leadership}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Sarah will head up the new digital transformation initiative.", "context": "an announcement about leadership assignment for a strategic company program", "tense": "Future Simple", "grammar_note": "will head up + noun phrase (separable phrasal verb in future simple)"}, {"sentence": "He''s been heading up the European operations for three years now.", "context": "a senior executive with sustained regional management responsibility", "tense": "Present Perfect Continuous", "grammar_note": "has been heading up + noun phrase (separable phrasal verb in present perfect continuous with duration)"}, {"sentence": "Who headed up the merger integration team last year?", "context": "a question about past leadership during a major corporate transaction", "tense": "Past Simple (question)", "grammar_note": "who + headed up + noun phrase (separable phrasal verb in past simple interrogative)"}, {"sentence": "The board asked me to head up the compliance review.", "context": "a manager receiving assignment to lead an important regulatory audit", "tense": "Past Simple (infinitive)", "grammar_note": "asked + to head up + noun phrase (separable phrasal verb in infinitive after ''ask'')"}]'::JSONB
WHERE id = 225;

UPDATE public.phrasal_verbs
SET 
  verb = 'knuckle down',
  definition_en = 'To begin working hard and seriously with focused determination, especially after a period of procrastination or distraction. Suggests disciplined, concentrated effort.',
  translation_pl = 'wziąć się (ostro) do roboty; przyłożyć się do (pracy); skupić się i pracować ciężko; zasuwać (potocznie)',
  category = 'general',
  tags = '{productivity,focus}'::TEXT[],
  register = 'informal',
  difficulty = 'C1',
  examples = '[{"sentence": "With the deadline approaching, the team really knuckled down.", "context": "a group intensifying their work effort as time pressure increased", "tense": "Past Simple", "grammar_note": "knuckled down (intransitive phrasal verb, no object needed, informal register)"}, {"sentence": "I need to knuckle down and finish this report tonight.", "context": "someone committing to focused work to complete an overdue task", "tense": "Present Simple (infinitive)", "grammar_note": "need to + knuckle down (intransitive phrasal verb after modal construction)"}, {"sentence": "She''s been knuckling down ever since her performance review.", "context": "an employee showing improved work ethic following feedback from management", "tense": "Present Perfect Continuous", "grammar_note": "has been knuckling down (intransitive phrasal verb in present perfect continuous)"}, {"sentence": "If you want to pass the certification exam, you''ll have to knuckle down.", "context": "advice given to someone who needs to study seriously for professional qualification", "tense": "Future Simple (infinitive)", "grammar_note": "will have to + knuckle down (intransitive phrasal verb after modal phrase)"}]'::JSONB
WHERE id = 226;

UPDATE public.phrasal_verbs
SET 
  verb = 'level with',
  definition_en = 'To be completely honest and straightforward with someone, especially when revealing difficult truths or sensitive information. Implies dropping pretense and speaking candidly.',
  translation_pl = 'być szczerym z (kimś); powiedzieć prawdę (wprost); nie owijać w bawełnę; być z kimś na czysto',
  category = 'general',
  tags = '{communication,transparency}'::TEXT[],
  register = 'informal',
  difficulty = 'C1',
  examples = '[{"sentence": "Let me level with you – this project is behind schedule.", "context": "a manager being frank with stakeholders about problems instead of sugarcoating", "tense": "Present Simple (imperative)", "grammar_note": "let me + level with + pronoun (inseparable phrasal verb in first-person imperative)"}, {"sentence": "He finally leveled with his team about the company''s financial struggles.", "context": "a leader choosing transparency over optimistic messaging during crisis", "tense": "Past Simple", "grammar_note": "leveled with + noun phrase (inseparable phrasal verb with indirect object)"}, {"sentence": "I appreciate you leveling with me about my performance issues.", "context": "an employee thanking their manager for honest, direct feedback", "tense": "Present Continuous (gerund)", "grammar_note": "appreciate + you + leveling with + pronoun (inseparable phrasal verb in gerund form)"}, {"sentence": "We should level with clients about potential delays early on.", "context": "a consultant advising proactive honest communication with stakeholders", "tense": "Present Simple (modal)", "grammar_note": "should + level with + noun (inseparable phrasal verb after modal verb)"}]'::JSONB
WHERE id = 227;

UPDATE public.phrasal_verbs
SET 
  verb = 'note down',
  definition_en = 'To write something briefly in order to remember or record it, typically during meetings, conversations, or while gathering information. Implies quick, informal documentation.',
  translation_pl = 'zanotować; zapisać (krótko); odnotować (na papierze); skreślić notatkę',
  category = 'business',
  tags = '{meetings,admin}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "She noted down all the action items during the meeting.", "context": "a participant documenting responsibilities assigned throughout a discussion", "tense": "Past Simple", "grammar_note": "noted down + noun phrase (separable phrasal verb, object after particle)"}, {"sentence": "Could you note down the client''s feedback for our records?", "context": "a manager requesting that important customer input be documented", "tense": "Present Simple (modal question)", "grammar_note": "could + you + note down + noun phrase (separable phrasal verb in polite request)"}, {"sentence": "I''ve been noting down ideas for the presentation all week.", "context": "someone continuously collecting thoughts in preparation for an important talk", "tense": "Present Perfect Continuous", "grammar_note": "have been noting down + noun phrase (separable phrasal verb in present perfect continuous)"}, {"sentence": "Make sure to note down the reference numbers before you close the case.", "context": "instruction to record critical information before completing administrative task", "tense": "Present Simple (imperative with ''make sure'')", "grammar_note": "make sure to + note down + noun phrase (separable phrasal verb in imperative instruction)"}]'::JSONB
WHERE id = 228;

UPDATE public.phrasal_verbs
SET 
  verb = 'phase in',
  definition_en = 'To introduce or implement something gradually over time in stages rather than all at once. Often used in organizational change management to minimize disruption.',
  translation_pl = 'wprowadzać stopniowo; wdrażać etapami; implementować fazowo; rozłożyć w czasie (wprowadzenie czegoś)',
  category = 'business',
  tags = '{strategy,change mgmt}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence": "The company is phasing in a new performance management system.", "context": "an organization implementing HR changes gradually to allow adjustment time", "tense": "Present Continuous", "grammar_note": "is phasing in + noun phrase (separable phrasal verb in present continuous)"}, {"sentence": "We phased in the new technology across departments over six months.", "context": "a completed IT implementation that occurred incrementally to reduce risk", "tense": "Past Simple", "grammar_note": "phased in + noun phrase (separable phrasal verb with time expression)"}, {"sentence": "The changes will be phased in starting next quarter.", "context": "announcement about planned gradual implementation of organizational updates", "tense": "Future Simple (passive)", "grammar_note": "will be phased in (separable phrasal verb in future simple passive voice)"}, {"sentence": "They had phased in the new policy before announcing it company-wide.", "context": "a pilot program that was tested gradually before full rollout", "tense": "Past Perfect", "grammar_note": "had phased in + noun phrase (separable phrasal verb in past perfect active)"}]'::JSONB
WHERE id = 229;

UPDATE public.phrasal_verbs
SET 
  verb = 'plan ahead',
  definition_en = 'To think about and prepare for future events, needs, or challenges in advance. Implies proactive thinking and anticipation of what may be required.',
  translation_pl = 'planować z wyprzedzeniem; myśleć strategicznie o przyszłości; przygotowywać się zawczasu; planować naprzód',
  category = 'general',
  tags = '{strategy,planning}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "We need to plan ahead for the busy season in December.", "context": "a retail manager discussing proactive preparation for high-demand period", "tense": "Present Simple (infinitive)", "grammar_note": "need to + plan ahead (intransitive phrasal verb after modal construction)"}, {"sentence": "She always plans ahead and anticipates potential roadblocks.", "context": "describing a colleague known for strategic foresight in project management", "tense": "Present Simple", "grammar_note": "plans ahead (intransitive phrasal verb, no object, with frequency adverb ''always'')"}, {"sentence": "The team had planned ahead for various contingency scenarios.", "context": "a group that conducted risk planning before project execution", "tense": "Past Perfect", "grammar_note": "had planned ahead (intransitive phrasal verb in past perfect showing prior completion)"}, {"sentence": "If we don''t plan ahead, we''ll face resource shortages next quarter.", "context": "warning about consequences of failing to anticipate future needs", "tense": "Present Simple (conditional)", "grammar_note": "don''t + plan ahead (intransitive phrasal verb in negative conditional clause)"}]'::JSONB
WHERE id = 230;

UPDATE public.phrasal_verbs
SET 
  verb = 'press ahead',
  definition_en = 'To continue with determination despite difficulties, opposition, or uncertainty. Implies persistence and forward momentum even when facing obstacles or doubts.',
  translation_pl = 'kontynuować pomimo trudności; posuwać się naprzód (z determinacją); iść dalej mimo przeszkód; parcie do przodu',
  category = 'business',
  tags = '{strategy,resilience}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence": "Despite budget cuts, management decided to press ahead with the expansion.", "context": "leaders choosing to continue strategic initiative despite financial constraints", "tense": "Past Simple (infinitive)", "grammar_note": "decided to + press ahead (intransitive phrasal verb in infinitive after ''decide'')"}, {"sentence": "We''re pressing ahead with the merger negotiations.", "context": "a company continuing complex business deal discussions with determination", "tense": "Present Continuous", "grammar_note": "are pressing ahead (intransitive phrasal verb in present continuous showing ongoing action)"}, {"sentence": "The team pressed ahead even after receiving negative feedback.", "context": "a group maintaining momentum on project despite discouraging input", "tense": "Past Simple", "grammar_note": "pressed ahead (intransitive phrasal verb in past simple, no object needed)"}, {"sentence": "Should we press ahead or wait for market conditions to improve?", "context": "executives debating whether to proceed with plans or delay due to uncertainty", "tense": "Present Simple (modal question)", "grammar_note": "should + we + press ahead (intransitive phrasal verb in yes/no question with modal)"}]'::JSONB
WHERE id = 231;

UPDATE public.phrasal_verbs
SET 
  verb = 'report back',
  definition_en = 'To return and provide information or updates about what was observed, learned, or accomplished, typically after being assigned a task or investigation. Implies accountability and communication loop.',
  translation_pl = 'zdać raport; poinformować o wynikach; wrócić z informacją; raportować (po wykonaniu zadania)',
  category = 'business',
  tags = '{communication,management}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The team will report back on their findings next Tuesday.", "context": "a project group scheduled to present research results to leadership", "tense": "Future Simple", "grammar_note": "will report back (intransitive phrasal verb in future simple with time marker)"}, {"sentence": "She reported back after meeting with the client about their concerns.", "context": "an account manager sharing feedback gathered from customer discussion", "tense": "Past Simple", "grammar_note": "reported back (intransitive phrasal verb with prepositional phrase ''after meeting'')"}, {"sentence": "I''m reporting back as requested on the competitor analysis.", "context": "someone delivering assigned research findings to their manager", "tense": "Present Continuous", "grammar_note": "am reporting back (intransitive phrasal verb in present continuous with prepositional phrase)"}, {"sentence": "Please report back to me by end of day with the latest numbers.", "context": "a supervisor requesting timely update on financial data from team member", "tense": "Present Simple (imperative)", "grammar_note": "report back (intransitive phrasal verb in imperative with deadline specification)"}]'::JSONB
WHERE id = 232;

UPDATE public.phrasal_verbs
SET 
  verb = 'sell off',
  definition_en = 'To dispose of assets, inventory, or business units by selling them, often quickly or at reduced prices to raise cash or streamline operations. Can indicate strategic divestment or financial distress.',
  translation_pl = 'wyprzedać (aktywa, zapasy); pozbyć się (przez sprzedaż); zbyć (część firmy); sprzedać (szybko lub tanio)',
  category = 'business',
  tags = '{finance,asset mgmt}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The company sold off several underperforming divisions last year.", "context": "a corporation divesting business units as part of strategic restructuring", "tense": "Past Simple", "grammar_note": "sold off + noun phrase (separable phrasal verb, object after particle)"}, {"sentence": "They''re selling off excess inventory at discounted prices.", "context": "a retailer liquidating surplus stock to free up warehouse space and capital", "tense": "Present Continuous", "grammar_note": "are selling off + noun phrase (separable phrasal verb in present continuous)"}, {"sentence": "The struggling retailer had sold off its real estate assets to avoid bankruptcy.", "context": "a company in financial distress liquidating property to generate emergency funds", "tense": "Past Perfect", "grammar_note": "had sold off + noun phrase (separable phrasal verb in past perfect showing prior action)"}, {"sentence": "We may need to sell off non-core assets to fund the acquisition.", "context": "executives considering divestment to finance strategic purchase", "tense": "Present Simple (modal)", "grammar_note": "may need to + sell off + noun phrase (separable phrasal verb after modal construction)"}]'::JSONB
WHERE id = 233;

UPDATE public.phrasal_verbs
SET 
  verb = 'ask around',
  definition_en = 'To inquire informally among several people to gather information, opinions, or recommendations. Suggests casual networking or research through multiple sources.',
  translation_pl = 'wypytać (kilka osób); dowiedzieć się (od znajomych); rozpytać wokół; zapytać tu i tam',
  category = 'general',
  tags = '{networking,research}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "I''ll ask around and see if anyone knows a good contractor.", "context": "someone using their network to find recommendations for a service provider", "tense": "Future Simple", "grammar_note": "will ask around (intransitive phrasal verb in future simple, no object needed)"}, {"sentence": "She asked around before deciding which software vendor to use.", "context": "a professional gathering informal input from colleagues about business decision", "tense": "Past Simple", "grammar_note": "asked around (intransitive phrasal verb in past simple with temporal clause)"}, {"sentence": "Have you asked around to see if anyone is interested in the project?", "context": "checking whether someone has informally gauged interest among potential participants", "tense": "Present Perfect (question)", "grammar_note": "have + you + asked around (intransitive phrasal verb in present perfect interrogative)"}, {"sentence": "We''re asking around for feedback on the new policy proposal.", "context": "a team informally collecting opinions from various stakeholders", "tense": "Present Continuous", "grammar_note": "are asking around (intransitive phrasal verb in present continuous with purpose phrase)"}]'::JSONB
WHERE id = 234;

UPDATE public.phrasal_verbs
SET 
  verb = 'call back',
  definition_en = 'To return a phone call to someone who tried to reach you earlier, or to telephone someone again. Implies reciprocal communication and follow-up.',
  translation_pl = 'oddzwonić; zadzwonić z powrotem; przekazać telefon zwrotny; skontaktować się telefonicznie (ponownie)',
  category = 'general',
  tags = '{communication,phone}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "I missed your call earlier – can I call you back now?", "context": "someone returning a phone call after being unavailable previously", "tense": "Present Simple (modal question)", "grammar_note": "can + I + call + you + back (separable phrasal verb, pronoun object between verb and particle)"}, {"sentence": "The client called back within ten minutes of my voicemail.", "context": "a customer responding quickly to a message left by service provider", "tense": "Past Simple", "grammar_note": "called back (separable phrasal verb without explicit object, intransitive use)"}, {"sentence": "Please call me back when you have the quarterly figures ready.", "context": "requesting return call once specific information becomes available", "tense": "Present Simple (imperative)", "grammar_note": "call + me + back (separable phrasal verb, pronoun object between verb and particle)"}, {"sentence": "She''s been calling back potential suppliers all morning.", "context": "a procurement officer returning calls to vendors as part of sourcing process", "tense": "Present Perfect Continuous", "grammar_note": "has been calling back + noun phrase (separable phrasal verb in present perfect continuous)"}]'::JSONB
WHERE id = 235;

UPDATE public.phrasal_verbs
SET 
  verb = 'call in',
  definition_en = 'To request or summon someone to provide help, expertise, or support, often in challenging situations. Can also mean to telephone one''s workplace, typically to report absence.',
  translation_pl = 'wezwać (eksperta, pomoc); sprowadzić (fachowca); zawiadomić telefonicznie (o nieobecności); poprosić o wsparcie',
  category = 'business',
  tags = '{management,support}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "We had to call in a specialist to resolve the technical issue.", "context": "a team requesting external expert assistance with complex problem", "tense": "Past Simple (infinitive)", "grammar_note": "had to + call in + noun phrase (separable phrasal verb after modal construction)"}, {"sentence": "Management is calling in consultants to review our processes.", "context": "leadership bringing external advisors to assess operational efficiency", "tense": "Present Continuous", "grammar_note": "is calling in + noun phrase (separable phrasal verb in present continuous)"}, {"sentence": "She called in sick this morning and won''t be at the meeting.", "context": "an employee telephoning to report illness and absence from work", "tense": "Past Simple", "grammar_note": "called in + adjective (separable phrasal verb with adjective complement ''sick'')"}, {"sentence": "If this escalates, we''ll need to call in senior leadership.", "context": "anticipating need to involve higher management in developing situation", "tense": "Future Simple (infinitive)", "grammar_note": "will need to + call in + noun phrase (separable phrasal verb after modal phrase)"}]'::JSONB
WHERE id = 236;

UPDATE public.phrasal_verbs
SET 
  verb = 'check up on',
  definition_en = 'To monitor or verify someone''s progress, well-being, or compliance, often to ensure things are proceeding as expected. Can imply supervision or concern.',
  translation_pl = 'sprawdzić (postępy kogoś); skontrolować (czy wszystko w porządku); doglądnąć (czyjeś działania); zweryfikować (status)',
  category = 'general',
  tags = '{management,supervision}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The manager checks up on the team''s progress every Friday.", "context": "a supervisor conducting regular monitoring of project advancement", "tense": "Present Simple", "grammar_note": "checks up on + noun phrase (inseparable phrasal verb with frequency adverb)"}, {"sentence": "I''m checking up on the status of the shipment with the vendor.", "context": "someone verifying delivery progress with supplier to ensure timeline compliance", "tense": "Present Continuous", "grammar_note": "am checking up on + noun phrase (inseparable phrasal verb in present continuous)"}, {"sentence": "She checked up on the new hires during their first month.", "context": "a mentor monitoring recently onboarded employees to support their integration", "tense": "Past Simple", "grammar_note": "checked up on + noun phrase (inseparable phrasal verb with temporal expression)"}, {"sentence": "Could you check up on whether the report was submitted?", "context": "requesting someone verify completion and delivery of expected deliverable", "tense": "Present Simple (modal request)", "grammar_note": "could + you + check up on + whether-clause (inseparable phrasal verb in polite question)"}]'::JSONB
WHERE id = 237;

UPDATE public.phrasal_verbs
SET 
  verb = 'clear up',
  definition_en = 'To resolve confusion or uncertainty by providing an explanation or clarification. It can also refer to weather improving or an illness disappearing.',
  translation_pl = 'wyjaśnić (nieporozumienie); rozwiązać (problem); przejaśnić się (o pogodzie); ustąpić (o chorobie)',
  category = 'general',
  tags = '{communication,organization}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Let me clear up any confusion about the new policy.", "context": "Manager addressing team questions during a meeting", "tense": "Present Simple", "grammar_note": "''Clear up'' is used with the infinitive form after ''let me'' to express the speaker''s intention to resolve confusion in the present."}, {"sentence": "The weather cleared up just before the outdoor event started.", "context": "Describing sudden weather improvement at a company picnic", "tense": "Past Simple", "grammar_note": "''Cleared up'' is the past simple form showing a completed action; the phrasal verb is intransitive here (no direct object)."}, {"sentence": "We need to clear up this misunderstanding before moving forward.", "context": "Project team resolving communication issues", "tense": "Present Simple (with modal ''need to'')", "grammar_note": "''Clear up'' follows ''need to'' and takes ''this misunderstanding'' as a direct object, showing the transitive use of the phrasal verb."}, {"sentence": "His skin condition has been clearing up since he changed his diet.", "context": "Discussing health improvements over several weeks", "tense": "Present Perfect Continuous", "grammar_note": "''Has been clearing up'' uses the present perfect continuous to emphasize the ongoing improvement process; here the phrasal verb is intransitive."}]'::JSONB
WHERE id = 238;

UPDATE public.phrasal_verbs
SET 
  verb = 'come out',
  definition_en = 'To become publicly known or available, such as information being revealed or a product being released. It can also mean to emerge from a place or situation.',
  translation_pl = 'wyjść na jaw (informacja); ukazać się (publikacja); wyjść (z miejsca); ujawnić się (prawda)',
  category = 'general',
  tags = '{marketing,results}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The truth about the scandal came out last week.", "context": "News reporter discussing a political revelation", "tense": "Past Simple", "grammar_note": "''Came out'' is the past simple form of the intransitive phrasal verb, indicating that information became public at a specific time."}, {"sentence": "Their new smartphone model is coming out next month.", "context": "Tech company announcing product launch timeline", "tense": "Present Continuous", "grammar_note": "''Is coming out'' uses present continuous to describe a planned future event; the phrasal verb is intransitive with no direct object."}, {"sentence": "The stain won''t come out no matter what I try.", "context": "Someone struggling to remove a mark from clothing", "tense": "Future Simple (with modal ''will'')", "grammar_note": "''Come out'' follows the negative modal ''won''t'', showing the stain''s resistance to removal; the phrasal verb is intransitive here."}, {"sentence": "Several witnesses have come out with new information.", "context": "Police investigation receiving additional testimonies", "tense": "Present Perfect", "grammar_note": "''Have come out'' uses present perfect to connect past actions to the present situation; ''with new information'' adds a prepositional phrase."}]'::JSONB
WHERE id = 239;

UPDATE public.phrasal_verbs
SET 
  verb = 'count in',
  definition_en = 'To include someone in a plan, activity, or group. This phrasal verb expresses willingness to participate or confirmation that someone will be included.',
  translation_pl = 'wliczyć (kogoś); dołączyć (do planu); uwzględnić (w grupie); zapisać (na listę uczestników)',
  category = 'general',
  tags = '{social,planning}'::TEXT[],
  register = 'informal',
  difficulty = 'B2',
  examples = '[{"sentence": "If you''re organizing a team dinner, count me in!", "context": "Colleague responding enthusiastically to social invitation", "tense": "Present Simple (imperative)", "grammar_note": "''Count in'' is used as an imperative with ''me'' as the direct object, expressing the speaker''s desire to be included."}, {"sentence": "They counted us in for the project without asking first.", "context": "Team members surprised by automatic assignment", "tense": "Past Simple", "grammar_note": "''Counted in'' is the past simple form with ''us'' as the direct object, showing completed inclusion; the phrasal verb is separable."}, {"sentence": "Can you count John in for the weekend trip?", "context": "Friend checking if there''s space for another person", "tense": "Present Simple (modal question with ''can'')", "grammar_note": "''Count in'' follows the modal ''can'' in question form with ''John'' as the direct object placed between the verb and particle."}, {"sentence": "We''ve been counting everyone in who expressed interest.", "context": "Event organizer explaining registration approach", "tense": "Present Perfect Continuous", "grammar_note": "''Have been counting in'' uses present perfect continuous to show an ongoing process; ''everyone'' is the direct object of the separable phrasal verb."}]'::JSONB
WHERE id = 240;

UPDATE public.phrasal_verbs
SET 
  verb = 'do without',
  definition_en = 'To manage or survive without something that you normally have or want. It implies coping with the absence of something, often suggesting resilience or necessity.',
  translation_pl = 'obejść się bez (czegoś); poradzić sobie bez; żyć bez; обойтись без',
  category = 'general',
  tags = '{resources,resilience}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "We''ll have to do without air conditioning until the repair is done.", "context": "Office manager informing staff about temporary inconvenience", "tense": "Future Simple (with modal ''have to'')", "grammar_note": "''Do without'' follows ''have to'' and takes ''air conditioning'' as its object; the phrasal verb is inseparable."}, {"sentence": "I can''t do without my morning coffee.", "context": "Person explaining their daily routine necessity", "tense": "Present Simple (with modal ''can'')", "grammar_note": "''Do without'' is used with the negative modal ''can''t'' and takes ''my morning coffee'' as the object; the phrasal verb is inseparable."}, {"sentence": "They did without electricity for three days after the storm.", "context": "Family describing post-disaster living conditions", "tense": "Past Simple", "grammar_note": "''Did without'' is the past simple form with ''electricity'' as the object, showing how they managed during a specific past period."}, {"sentence": "We''ve been doing without proper equipment for months now.", "context": "Employee complaining about inadequate workplace resources", "tense": "Present Perfect Continuous", "grammar_note": "''Have been doing without'' uses present perfect continuous to emphasize the ongoing nature of the deprivation; the phrasal verb is inseparable."}]'::JSONB
WHERE id = 241;

UPDATE public.phrasal_verbs
SET 
  verb = 'drop back',
  definition_en = 'To move to a position behind others, either deliberately or due to inability to maintain pace. It can refer to physical movement in sports or metaphorical positioning in rankings or progress.',
  translation_pl = 'cofnąć się (w grupie); spaść na dalszą pozycję; zostać z tyłu; zwolnić tempo',
  category = 'general',
  tags = '{movement,position}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The runner dropped back to conserve energy for the final lap.", "context": "Sports commentator analyzing marathon race strategy", "tense": "Past Simple", "grammar_note": "''Dropped back'' is the past simple form of the intransitive phrasal verb, indicating a deliberate tactical movement."}, {"sentence": "Our sales team is dropping back in the regional rankings.", "context": "Manager reviewing quarterly performance metrics", "tense": "Present Continuous", "grammar_note": "''Is dropping back'' uses present continuous to show an ongoing decline in position; the phrasal verb is intransitive with no direct object."}, {"sentence": "He told them to drop back and regroup.", "context": "Military commander issuing tactical orders", "tense": "Past Simple (infinitive in reported speech)", "grammar_note": "''Drop back'' appears in infinitive form after ''told them to'', functioning as an imperative in reported speech."}, {"sentence": "The cyclist had dropped back after puncturing his tire.", "context": "Explaining why a competitor lost their lead position", "tense": "Past Perfect", "grammar_note": "''Had dropped back'' uses past perfect to show the action occurred before another past event; the phrasal verb is intransitive."}]'::JSONB
WHERE id = 242;

UPDATE public.phrasal_verbs
SET 
  verb = 'fill up',
  definition_en = 'To make something completely full, or to become completely full. It commonly refers to filling a container, vehicle tank, or space with people or things.',
  translation_pl = 'napełnić (do pełna); zatankować (paliwo); zapełnić się (o miejscu); najeść się (do syta)',
  category = 'general',
  tags = '{daily,travel}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "I need to fill up the car before the long drive.", "context": "Driver planning ahead for a road trip", "tense": "Present Simple (with modal ''need to'')", "grammar_note": "''Fill up'' follows ''need to'' with ''the car'' as direct object; the phrasal verb is separable but not separated here."}, {"sentence": "The conference room filled up quickly.", "context": "Describing high attendance at a popular meeting", "tense": "Past Simple", "grammar_note": "''Filled up'' is the past simple form used intransitively (no direct object), with ''quickly'' as an adverb of manner."}, {"sentence": "Could you fill up this form and return it tomorrow?", "context": "Receptionist giving instructions to a patient", "tense": "Present Simple (modal question with ''could'')", "grammar_note": "''Fill up'' follows the modal ''could'' with ''this form'' as the direct object; note the separable nature allows ''fill this form up''."}, {"sentence": "The storage has been filling up with old files.", "context": "IT administrator noticing decreasing server capacity", "tense": "Present Perfect Continuous", "grammar_note": "''Has been filling up'' uses present perfect continuous to show gradual accumulation; the phrasal verb is intransitive here."}]'::JSONB
WHERE id = 243;

UPDATE public.phrasal_verbs
SET 
  verb = 'get back',
  definition_en = 'To return to a place or previous state, or to receive something that was taken or lost. It can also mean to retaliate or respond to someone at a later time.',
  translation_pl = 'wrócić (do miejsca); odzyskać (coś utraconego); oddzwonić (później); zemścić się (na kimś)',
  category = 'general',
  tags = '{travel,time}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "What time will you get back from the conference?", "context": "Colleague asking about expected return time", "tense": "Future Simple (with ''will'')", "grammar_note": "''Get back'' follows the modal ''will'' in a question; the phrasal verb is intransitive here, with ''from the conference'' as a prepositional phrase."}, {"sentence": "She got back her stolen laptop thanks to the police.", "context": "Victim recovering property after a theft", "tense": "Past Simple", "grammar_note": "''Got back'' is the past simple form with ''her stolen laptop'' as direct object; the phrasal verb is separable, showing the transitive use."}, {"sentence": "I''ll get back to you with an answer by Friday.", "context": "Manager promising to respond after checking details", "tense": "Future Simple (with ''will'')", "grammar_note": "''Get back'' is used with ''to you'' forming ''get back to someone'', a common collocation meaning to respond later."}, {"sentence": "We''ve just gotten back from our vacation.", "context": "Friends sharing news after returning home", "tense": "Present Perfect", "grammar_note": "''Have gotten back'' (US) or ''have got back'' (UK) uses present perfect to connect the recent return to the present; the phrasal verb is intransitive."}]'::JSONB
WHERE id = 244;

UPDATE public.phrasal_verbs
SET 
  verb = 'get in',
  definition_en = 'To enter a place or vehicle, or to arrive at a destination. It can also mean to be admitted to an institution or to successfully submit something before a deadline.',
  translation_pl = 'wejść (do środka); wsiąść (do pojazdu); przybyć (na miejsce); dostać się (do szkoły/instytucji)',
  category = 'general',
  tags = '{travel,logistics}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The train gets in at 6:30 PM.", "context": "Checking arrival schedule at a railway station", "tense": "Present Simple", "grammar_note": "''Gets in'' is present simple showing scheduled arrival; the phrasal verb is intransitive, commonly used with transportation."}, {"sentence": "She got in through the back door.", "context": "Describing how someone entered a building", "tense": "Past Simple", "grammar_note": "''Got in'' is the past simple form used intransitively with ''through the back door'' as a prepositional phrase showing method of entry."}, {"sentence": "Did you manage to get in before the deadline?", "context": "Colleague asking about application submission success", "tense": "Past Simple (in question form with ''did'')", "grammar_note": "''Get in'' appears in infinitive form after ''manage to'', referring to successful submission within a time limit."}, {"sentence": "He''s been trying to get in to see the director all week.", "context": "Employee seeking urgent meeting with leadership", "tense": "Present Perfect Continuous", "grammar_note": "''Has been trying to get in'' shows ongoing effort; ''to see'' indicates purpose, and ''get in'' here means gaining access."}]'::JSONB
WHERE id = 245;

UPDATE public.phrasal_verbs
SET 
  verb = 'get off',
  definition_en = 'To leave or descend from a vehicle or elevated surface. It can also mean to finish work, avoid punishment, or remove something from a surface.',
  translation_pl = 'wysiąść (z pojazdu); zejść (z powierzchni); skończyć pracę; uniknąć kary; usunąć (plamę)',
  category = 'general',
  tags = '{travel,daily}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "You should get off at the next stop.", "context": "Giving directions to a bus passenger", "tense": "Present Simple (with modal ''should'')", "grammar_note": "''Get off'' follows the modal ''should'' and is intransitive; ''at the next stop'' is a prepositional phrase indicating location."}, {"sentence": "He got off work early yesterday.", "context": "Friend explaining why they had free time", "tense": "Past Simple", "grammar_note": "''Got off'' is the past simple form with ''work'' as the object, meaning to finish employment duties for the day."}, {"sentence": "The lawyer helped him get off with just a fine.", "context": "Discussing the outcome of a legal case", "tense": "Infinitive (after ''helped'')", "grammar_note": "''Get off'' appears after ''helped him'' in infinitive form; ''with just a fine'' shows the lenient punishment received."}, {"sentence": "I''ve been trying to get these stains off all morning.", "context": "Homeowner struggling with carpet cleaning", "tense": "Present Perfect Continuous", "grammar_note": "''Have been trying to get off'' shows ongoing effort; ''these stains'' is the direct object, making the phrasal verb transitive and separable."}]'::JSONB
WHERE id = 246;

UPDATE public.phrasal_verbs
SET 
  verb = 'get on',
  definition_en = 'To board a vehicle or mount something, or to make progress with a task. It can also describe how well people relate to each other in social situations.',
  translation_pl = 'wsiąść (do pojazdu); wspiąć się (na coś); robić postępy (w pracy); dogadywać się (z kimś)',
  category = 'general',
  tags = '{travel,progress}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "We need to get on the bus now or we''ll miss it.", "context": "Travelers rushing to catch their transportation", "tense": "Present Simple (with modal ''need to'')", "grammar_note": "''Get on'' follows ''need to'' with ''the bus'' as the object, showing the action of boarding; the phrasal verb is inseparable here."}, {"sentence": "How are you getting on with the new project?", "context": "Manager checking progress during a team meeting", "tense": "Present Continuous (in question form)", "grammar_note": "''Are getting on'' uses present continuous to ask about ongoing progress; ''with the new project'' indicates what is progressing."}, {"sentence": "They got on really well from the first meeting.", "context": "Describing positive rapport between new colleagues", "tense": "Past Simple", "grammar_note": "''Got on'' is past simple used intransitively to describe social compatibility; ''really well'' is an adverbial phrase of manner."}, {"sentence": "I must get on with this report or I''ll never finish.", "context": "Employee motivating themselves to continue working", "tense": "Present Simple (with modal ''must'')", "grammar_note": "''Get on'' follows ''must'' meaning to continue or make progress; ''with this report'' shows what work needs advancing."}]'::JSONB
WHERE id = 247;

UPDATE public.phrasal_verbs
SET 
  verb = 'get out',
  definition_en = 'To leave or exit a place or vehicle, or to become publicly known (referring to information or secrets). It can also mean to extract something or remove someone from a situation.',
  translation_pl = 'wyjść (z miejsca); wysiąść (z pojazdu); wydostać się; wyciec (o informacji); wyjąć (coś)',
  category = 'general',
  tags = '{news,exit}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The news about the merger got out before the official announcement.", "context": "Company concerned about premature information leak", "tense": "Past Simple", "grammar_note": "''Got out'' is the past simple form used intransitively, meaning information became publicly known; ''before'' introduces a time clause."}, {"sentence": "Get out of the car and put your hands up!", "context": "Police officer issuing commands during an arrest", "tense": "Present Simple (imperative)", "grammar_note": "''Get out'' is used as an imperative with ''of the car'' as a prepositional phrase; the command structure makes it forceful."}, {"sentence": "How did that confidential information get out?", "context": "Executive investigating a security breach", "tense": "Past Simple (in question form with ''did'')", "grammar_note": "''Get out'' appears in infinitive after ''did'' in the question; the phrasal verb is intransitive, referring to leaked information."}, {"sentence": "She''s been trying to get out of that contract for months.", "context": "Lawyer discussing client''s attempts to terminate agreement", "tense": "Present Perfect Continuous", "grammar_note": "''Has been trying to get out'' shows ongoing effort; ''of that contract'' indicates what she wants to escape from."}]'::JSONB
WHERE id = 248;

UPDATE public.phrasal_verbs
SET 
  verb = 'get through',
  definition_en = 'To make contact by phone or to successfully complete a difficult task or period. It can also mean to make someone understand something or to pass through something physically.',
  translation_pl = 'dodzwonić się (przez telefon); przebrnąć przez (trudny okres); dotrzeć (z komunikatem); przejść (przez coś)',
  category = 'general',
  tags = '{phone,workload}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "I''ve been trying to get through to customer service all morning.", "context": "Frustrated caller waiting on hold repeatedly", "tense": "Present Perfect Continuous", "grammar_note": "''Have been trying to get through'' emphasizes ongoing effort; ''to customer service'' shows the intended connection target."}, {"sentence": "We got through the audit without any major issues.", "context": "Finance team relieved after successful inspection", "tense": "Past Simple", "grammar_note": "''Got through'' is past simple with ''the audit'' as the object, meaning successfully completed; ''without'' adds a prepositional phrase."}, {"sentence": "Can you get through to him that this is urgent?", "context": "Manager asking someone to convey message importance", "tense": "Present Simple (modal question with ''can'')", "grammar_note": "''Get through'' follows ''can'' meaning to make someone understand; ''to him'' indicates the recipient, ''that this is urgent'' is the message."}, {"sentence": "The supplies will get through by the end of the week.", "context": "Logistics coordinator updating on delivery timeline", "tense": "Future Simple (with ''will'')", "grammar_note": "''Get through'' follows ''will'' used intransitively meaning to arrive or pass through obstacles; ''by'' indicates deadline."}]'::JSONB
WHERE id = 249;

UPDATE public.phrasal_verbs
SET 
  verb = 'get together',
  definition_en = 'To meet socially or gather for a purpose, or to organize and assemble things. It can also refer to people beginning a romantic relationship.',
  translation_pl = 'spotkać się (towarzysko); zebrać się (w grupie); zorganizować (rzeczy); związać się (w parę)',
  category = 'general',
  tags = '{social,meetings}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Let''s get together for coffee next week.", "context": "Friends making casual plans after chance encounter", "tense": "Present Simple (imperative with ''let''s'')", "grammar_note": "''Get together'' follows ''let''s'' as a suggestion for a future meeting; ''for coffee'' indicates the purpose."}, {"sentence": "The team gets together every Friday for a briefing.", "context": "Describing regular workplace meeting schedule", "tense": "Present Simple", "grammar_note": "''Gets together'' is present simple showing habitual action; ''every Friday'' indicates frequency, ''for a briefing'' shows purpose."}, {"sentence": "We got together all the documents needed for the application.", "context": "Assistant completing paperwork preparation task", "tense": "Past Simple", "grammar_note": "''Got together'' is past simple used transitively with ''all the documents'' as the object, meaning assembled or organized."}, {"sentence": "They''ve been getting together secretly for months.", "context": "Office gossip about colleagues'' romantic relationship", "tense": "Present Perfect Continuous", "grammar_note": "''Have been getting together'' uses present perfect continuous to show an ongoing meeting pattern; ''secretly'' is an adverb of manner."}]'::JSONB
WHERE id = 250;

UPDATE public.phrasal_verbs
SET 
  verb = 'give back',
  definition_en = 'To return something to its owner or to contribute to society or a community, often through charitable acts or volunteering. It emphasizes reciprocity and social responsibility.',
  translation_pl = 'oddać (coś właścicielowi); zwrócić (pożyczoną rzecz); odwdzięczyć się (społeczeństwu); wspomóc (społeczność)',
  category = 'general',
  tags = '{social,charity}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Please give back the keys when you''re done.", "context": "Facility manager lending equipment temporarily", "tense": "Present Simple (imperative)", "grammar_note": "''Give back'' is used as an imperative with ''the keys'' as direct object; the phrasal verb is separable but not separated here."}, {"sentence": "The company gives back to the community through education programs.", "context": "Corporate social responsibility initiative description", "tense": "Present Simple", "grammar_note": "''Gives back'' is present simple showing habitual action; ''to the community'' indicates recipient, ''through'' shows method."}, {"sentence": "I gave back the money I borrowed last month.", "context": "Person settling a debt with a friend", "tense": "Past Simple", "grammar_note": "''Gave back'' is past simple with ''the money'' as direct object; the phrasal verb is separable, and the relative clause describes the money."}, {"sentence": "She''s been giving back her time to volunteer work.", "context": "Describing someone''s ongoing charitable commitment", "tense": "Present Perfect Continuous", "grammar_note": "''Has been giving back'' uses present perfect continuous to show ongoing contribution; ''her time'' is the direct object being contributed."}]'::JSONB
WHERE id = 251;

UPDATE public.phrasal_verbs
SET 
  verb = 'go after',
  definition_en = 'To pursue or chase someone or something, either physically or metaphorically. It can mean to actively seek a goal, opportunity, job, or to pursue someone romantically or legally.',
  translation_pl = 'gonić (za kimś); dążyć do (celu); ubiegać się o (stanowisko); ścigać (prawnie)',
  category = 'general',
  tags = '{ambition,strategy}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "She decided to go after her dream of becoming a doctor.", "context": "Career counselor discussing student''s ambitions", "tense": "Past Simple (infinitive after ''decided to'')", "grammar_note": "''Go after'' appears in infinitive form after ''decided to''; ''her dream'' is the object being pursued metaphorically."}, {"sentence": "The company is going after a larger market share this year.", "context": "CEO presenting aggressive business strategy", "tense": "Present Continuous", "grammar_note": "''Is going after'' uses present continuous to show current pursuit; ''a larger market share'' is the direct object representing the goal."}, {"sentence": "They went after the suspect immediately after the robbery.", "context": "Police report describing chase sequence", "tense": "Past Simple", "grammar_note": "''Went after'' is past simple with ''the suspect'' as the object, indicating physical pursuit; ''immediately'' adds timing."}, {"sentence": "He''s been going after that promotion for over a year.", "context": "Colleague observing someone''s career advancement efforts", "tense": "Present Perfect Continuous", "grammar_note": "''Has been going after'' uses present perfect continuous to emphasize persistent effort; ''that promotion'' is the object of pursuit."}]'::JSONB
WHERE id = 252;

UPDATE public.phrasal_verbs
SET 
  verb = 'go off',
  definition_en = 'To explode, make a loud noise (like an alarm), or stop functioning. It can also mean food becoming spoiled or an event proceeding in a particular way.',
  translation_pl = 'wybuchnąć (eksplozja); włączyć się (alarm); zepsuć się (jedzenie); przebiec (o wydarzeniu)',
  category = 'general',
  tags = '{safety,daily}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The fire alarm went off during the meeting.", "context": "Interruption causing office evacuation", "tense": "Past Simple", "grammar_note": "''Went off'' is past simple used intransitively, meaning the alarm activated and made noise; ''during'' introduces a time reference."}, {"sentence": "This milk has gone off - don''t drink it!", "context": "Roommate warning about spoiled food in fridge", "tense": "Present Perfect", "grammar_note": "''Has gone off'' uses present perfect to show a change of state; the phrasal verb is intransitive, meaning became spoiled."}, {"sentence": "My alarm didn''t go off this morning.", "context": "Explaining reason for being late to work", "tense": "Past Simple (negative with ''didn''t'')", "grammar_note": "''Go off'' appears in infinitive after ''didn''t'', showing the alarm failed to activate; ''this morning'' provides time context."}, {"sentence": "The event is going off smoothly so far.", "context": "Coordinator monitoring conference progress", "tense": "Present Continuous", "grammar_note": "''Is going off'' uses present continuous to describe how an event is proceeding; ''smoothly'' is an adverb describing the manner."}]'::JSONB
WHERE id = 253;

UPDATE public.phrasal_verbs
SET 
  verb = 'hang on',
  definition_en = 'To wait for a short time or to hold something tightly. It can also mean to persevere through a difficult situation or to depend on something.',
  translation_pl = 'poczekać chwilę (na coś); trzymać się (kurczowo); wytrwać (w trudnej sytuacji); zależeć od (czegoś)',
  category = 'general',
  tags = '{phone,requests}'::TEXT[],
  register = 'informal',
  difficulty = 'B2',
  examples = '[{"sentence": "Hang on a second, I''ll be right with you.", "context": "Busy receptionist asking visitor to wait briefly", "tense": "Present Simple (imperative)", "grammar_note": "''Hang on'' is used as an imperative meaning wait; ''a second'' indicates the short duration expected."}, {"sentence": "She hung on to the railing as the boat rocked.", "context": "Passenger maintaining balance during rough seas", "tense": "Past Simple", "grammar_note": "''Hung on'' is past simple with ''to the railing'' showing what she gripped; the phrasal verb is intransitive here."}, {"sentence": "Can you hang on while I transfer your call?", "context": "Customer service representative managing phone routing", "tense": "Present Simple (modal question with ''can'')", "grammar_note": "''Hang on'' follows the modal ''can'' in a polite request to wait; ''while'' introduces a temporal clause."}, {"sentence": "We''ve been hanging on despite the financial difficulties.", "context": "Business owner describing survival through crisis", "tense": "Present Perfect Continuous", "grammar_note": "''Have been hanging on'' uses present perfect continuous to show persistent endurance; ''despite'' introduces a contrasting element."}]'::JSONB
WHERE id = 254;

UPDATE public.phrasal_verbs
SET 
  verb = 'join in',
  definition_en = 'To participate in an activity that is already happening, often in a social or collaborative context. It emphasizes becoming part of an ongoing group action or event.',
  translation_pl = 'przyłączyć się (do zabawy); włączyć się (do rozmowy); uczestniczyć (w aktywności); dołączyć (do grupy)',
  category = 'general',
  tags = '{teamwork,social}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "Everyone is welcome to join in the discussion.", "context": "Meeting facilitator encouraging participation", "tense": "Present Simple (infinitive after ''welcome to'')", "grammar_note": "''Join in'' appears in infinitive form after ''welcome to''; ''the discussion'' is the object showing what to participate in."}, {"sentence": "The children joined in the singing immediately.", "context": "Teacher observing enthusiastic student participation", "tense": "Past Simple", "grammar_note": "''Joined in'' is past simple with ''the singing'' as the object; ''immediately'' is an adverb showing timing of participation."}, {"sentence": "Don''t be shy - join in!", "context": "Friend encouraging someone to participate in group activity", "tense": "Present Simple (imperative)", "grammar_note": "''Join in'' is used as an imperative without an object, meaning participate in the obvious ongoing activity."}, {"sentence": "He''s been joining in more since he became comfortable with the team.", "context": "Manager noting new employee''s growing confidence", "tense": "Present Perfect Continuous", "grammar_note": "''Has been joining in'' uses present perfect continuous to show increasing participation; ''more'' is an adverb indicating frequency change."}]'::JSONB
WHERE id = 255;

UPDATE public.phrasal_verbs
SET 
  verb = 'keep out',
  definition_en = 'To prevent someone or something from entering a place, or to stay outside. It often relates to security measures, warnings, or protection from unwanted elements.',
  translation_pl = 'nie wpuszczać (kogoś); trzymać z dala; pozostać na zewnątrz; nie dopuścić (czegoś)',
  category = 'general',
  tags = '{security,safety}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence": "The fence keeps out unwanted animals.", "context": "Gardener explaining protective measures for plants", "tense": "Present Simple", "grammar_note": "''Keeps out'' is present simple with ''unwanted animals'' as the direct object; the phrasal verb is separable but not separated here."}, {"sentence": "Keep out - authorized personnel only!", "context": "Warning sign posted on restricted area door", "tense": "Present Simple (imperative)", "grammar_note": "''Keep out'' is used as an imperative without an object, functioning as a direct warning to stay outside; the dash adds emphasis."}, {"sentence": "The curtains kept out most of the sunlight.", "context": "Describing bedroom darkness during daytime", "tense": "Past Simple", "grammar_note": "''Kept out'' is past simple with ''most of the sunlight'' as the direct object; the phrasal verb is separable but not separated."}, {"sentence": "We''ve been keeping out intruders with the new security system.", "context": "Facility manager reporting on security improvements", "tense": "Present Perfect Continuous", "grammar_note": "''Have been keeping out'' uses present perfect continuous to show ongoing prevention; ''intruders'' is the direct object being excluded."}]'::JSONB
WHERE id = 256;

UPDATE public.phrasal_verbs
SET 
  verb = 'log in',
  definition_en = 'To gain access to a computer system, website, or application by entering your username and password or other credentials. This is a fundamental action in digital security that verifies your identity before granting access to protected information or services.',
  translation_pl = 'zalogować się; logować się do systemu; uwierzytelnić się (w systemie); uzyskać dostęp (po weryfikacji)',
  category = 'general',
  tags = '{technology,daily}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "I can''t log in to my email account because I''ve forgotten my password.", "sentence_pl": "Nie mogę zalogować się do mojego konta e-mail, ponieważ zapomniałem hasła.", "context_en": "User experiencing authentication problem with credentials", "context_pl": "Użytkownik ma problem z uwierzytelnieniem i dostępem", "tense": "Present Simple (negative)", "grammar_note": "Modal verb ''can''t'' followed by base form ''log in'' expresses present inability to access the account."}, {"sentence_en": "She logged in to the company portal to submit her timesheet before the deadline.", "sentence_pl": "Zalogowała się do portalu firmowego, aby wysłać swój raport czasu przed terminem.", "context_en": "Employee accessing internal system for administrative task", "context_pl": "Pracownik loguje się do systemu wewnętrznego w celach administracyjnych", "tense": "Past Simple", "grammar_note": "Past Simple ''logged in'' indicates completed action of accessing the portal, followed by purpose clause with infinitive ''to submit''."}, {"sentence_en": "You''ll need to log in with your new credentials after the security update.", "sentence_pl": "Będziesz musiał zalogować się przy użyciu nowych danych logowania po aktualizacji zabezpieczeń.", "context_en": "IT notification about authentication requirements following system upgrade", "context_pl": "Powiadomienie IT o wymaganiach logowania po aktualizacji systemu", "tense": "Future Simple (will + need to)", "grammar_note": "Future structure ''will need to'' followed by base form ''log in'' expresses future necessity after the security update."}, {"sentence_en": "We''ve been logging in remotely since the office moved to hybrid working arrangements.", "sentence_pl": "Logujemy się zdalnie odkąd biuro przeszło na hybrydowy model pracy.", "context_en": "Team describing ongoing remote access pattern after workplace changes", "context_pl": "Zespół opisuje ciągły wzorzec zdalnego dostępu po zmianach w miejscu pracy", "tense": "Present Perfect Continuous", "grammar_note": "Present Perfect Continuous ''have been logging in'' emphasizes the ongoing, repeated action since the transition to hybrid work."}]'::JSONB
WHERE id = 257;

UPDATE public.phrasal_verbs
SET 
  verb = 'log off',
  definition_en = 'To end your session on a computer system, website, or application by formally exiting, which closes your access and protects your account. This action is important for security, especially when using shared or public computers, as it prevents unauthorized access to your information.',
  translation_pl = 'wylogować się; zakończyć sesję; rozłączyć się z systemu; zamknąć sesję roboczą',
  category = 'general',
  tags = '{technology,security}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Always log off from your banking app when you finish checking your account.", "sentence_pl": "Zawsze wyloguj się z aplikacji bankowej, gdy skończysz sprawdzać swoje konto.", "context_en": "Security advice for protecting financial information on mobile devices", "context_pl": "Porada bezpieczeństwa dotycząca ochrony informacji finansowych na urządzeniach mobilnych", "tense": "Imperative", "grammar_note": "Imperative form ''log off'' gives direct instruction about security practice, with adverb ''always'' emphasizing the importance."}, {"sentence_en": "He forgot to log off yesterday, so his computer was still unlocked this morning.", "sentence_pl": "Wczoraj zapomniał się wylogować, więc jego komputer był wciąż odblokowany dziś rano.", "context_en": "Security breach explanation showing consequences of improper system exit", "context_pl": "Wyjaśnienie naruszenia bezpieczeństwa pokazujące konsekwencje niewłaściwego wyjścia z systemu", "tense": "Past Simple", "grammar_note": "Past Simple ''forgot to log off'' describes a completed failure to perform the action, with infinitive showing the intended action."}, {"sentence_en": "The system will automatically log you off after 15 minutes of inactivity.", "sentence_pl": "System automatycznie cię wyloguje po 15 minutach braku aktywności.", "context_en": "IT security policy notification about automatic session termination feature", "context_pl": "Powiadomienie o polityce bezpieczeństwa IT dotyczące automatycznego zakończenia sesji", "tense": "Future Simple (will)", "grammar_note": "Future Simple ''will log off'' with adverb ''automatically'' describes the system''s future action triggered by inactivity timeout."}, {"sentence_en": "I''m logging off now because I need to restart my computer for the updates.", "sentence_pl": "Wylogowuję się teraz, ponieważ muszę zrestartować komputer w celu instalacji aktualizacji.", "context_en": "User announcement about ending session before system maintenance", "context_pl": "Ogłoszenie użytkownika o zakończeniu sesji przed konserwacją systemu", "tense": "Present Continuous", "grammar_note": "Present Continuous ''am logging off'' indicates action happening right now, emphasized by ''now'', with reason clause explaining necessity."}]'::JSONB
WHERE id = 258;

UPDATE public.phrasal_verbs
SET 
  verb = 'look back',
  definition_en = 'To think about or remember past events, experiences, or periods of time, often to reflect on what happened or what has been learned. This can involve nostalgia, evaluation of past decisions, or analysis of how things have changed over time.',
  translation_pl = 'spojrzeć wstecz; rozważyć przeszłość; wspominać; reflektować nad przeszłością; oceniać minione wydarzenia',
  category = 'general',
  tags = '{reflection,history}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "When I look back on my university years, I realize how much I''ve grown personally.", "sentence_pl": "Kiedy patrzę wstecz na lata uniwersyteckie, zdaję sobie sprawę, jak bardzo rozwinąłem się osobiście.", "context_en": "Personal reflection on educational period and self-development journey", "context_pl": "Osobista refleksja nad okresem edukacyjnym i drogą samorozwoju", "tense": "Present Simple", "grammar_note": "Present Simple ''look back'' in temporal clause describes habitual reflection, followed by main clause with Present Simple ''realize''."}, {"sentence_en": "The CEO looked back at the company''s achievements during her retirement speech.", "sentence_pl": "Dyrektor generalna spojrzała wstecz na osiągnięcia firmy podczas swojego przemówienia pożegnalnego.", "context_en": "Executive reviewing organizational accomplishments at career milestone event", "context_pl": "Dyrektor przegląda osiągnięcia organizacji podczas wydarzenia związanego z kamieniem milowym kariery", "tense": "Past Simple", "grammar_note": "Past Simple ''looked back'' describes completed reflective action during the speech, with preposition ''at'' introducing the object of reflection."}, {"sentence_en": "We shouldn''t look back with regret but instead learn from our mistakes.", "sentence_pl": "Nie powinniśmy patrzeć wstecz z żalem, ale zamiast tego uczyć się na naszych błędach.", "context_en": "Motivational advice about constructive attitude toward past experiences", "context_pl": "Porada motywacyjna dotycząca konstruktywnego podejścia do przeszłych doświadczeń", "tense": "Modal verb (should + negative)", "grammar_note": "Modal ''shouldn''t'' with base form ''look back'' expresses advice against regretful reflection, contrasted with alternative action ''learn''."}, {"sentence_en": "Historians have been looking back at this period to understand the social changes.", "sentence_pl": "Historycy analizują ten okres, aby zrozumieć zmiany społeczne.", "context_en": "Academic research examining historical era for sociological insights", "context_pl": "Badania akademickie analizujące epokę historyczną w celu uzyskania spostrzeżeń socjologicznych", "tense": "Present Perfect Continuous", "grammar_note": "Present Perfect Continuous ''have been looking back'' emphasizes ongoing historical analysis, with purpose infinitive ''to understand''."}]'::JSONB
WHERE id = 259;

UPDATE public.phrasal_verbs
SET 
  verb = 'look up to',
  definition_en = 'To admire and respect someone, typically because of their qualities, achievements, or position, and often to regard them as a role model or source of inspiration. This phrasal verb expresses a positive emotional attitude of reverence or aspiration toward another person.',
  translation_pl = 'podziwiać kogoś; szanować; patrzeć na kogoś z podziwem; brać z kogoś przykład; mieć wzór w kimś',
  category = 'general',
  tags = '{mentorship,respect}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Young professionals often look up to senior managers who demonstrate strong leadership skills.", "sentence_pl": "Młodzi profesjonaliści często podziwiają starszych menedżerów, którzy demonstrują silne umiejętności przywódcze.", "context_en": "Workplace mentorship dynamic between junior and experienced employees", "context_pl": "Dynamika mentoringu w miejscu pracy między młodszymi i doświadczonymi pracownikami", "tense": "Present Simple", "grammar_note": "Present Simple ''look up to'' describes habitual admiration pattern, with adverb ''often'' indicating frequency and relative clause describing the managers."}, {"sentence_en": "She''s always looked up to her grandmother, who built a successful business from nothing.", "sentence_pl": "Zawsze podziwiała swoją babcię, która zbudowała udany biznes z niczego.", "context_en": "Family relationship showing long-term admiration for entrepreneurial achievement", "context_pl": "Relacja rodzinna pokazująca długoterminowy podziw dla osiągnięć przedsiębiorczych", "tense": "Present Perfect", "grammar_note": "Present Perfect ''has looked up to'' with ''always'' emphasizes continuous admiration from past to present, with relative clause providing context."}, {"sentence_en": "As children, we looked up to teachers who made learning exciting and accessible.", "sentence_pl": "Jako dzieci podziwialiśmy nauczycieli, którzy sprawiali, że nauka była ekscytująca i dostępna.", "context_en": "Childhood memory of respected educators and their teaching methods", "context_pl": "Wspomnienie z dzieciństwa szanowanych nauczycieli i ich metod nauczania", "tense": "Past Simple", "grammar_note": "Past Simple ''looked up to'' describes admiration during a specific past period (childhood), with relative clause explaining the reason."}, {"sentence_en": "You should find someone to look up to in your field for guidance and inspiration.", "sentence_pl": "Powinieneś znaleźć kogoś, kogo będziesz podziwiał w swojej dziedzinie, aby uzyskać wskazówki i inspirację.", "context_en": "Career development advice about identifying professional role models", "context_pl": "Porada dotycząca rozwoju kariery o identyfikowaniu zawodowych wzorów do naśladowania", "tense": "Modal verb (should) + infinitive", "grammar_note": "Modal ''should'' followed by infinitive ''to look up to'' gives advice about finding mentors, with purpose phrase explaining the benefit."}]'::JSONB
WHERE id = 260;

UPDATE public.phrasal_verbs
SET 
  verb = 'move on',
  definition_en = 'To progress to the next topic, task, or stage of something, leaving the previous one behind. In business contexts, this often means transitioning to the next agenda item in a meeting or advancing to a new phase of a project, while in personal contexts it can mean emotionally letting go of past events.',
  translation_pl = 'przejść dalej; kontynuować; posunąć się naprzód; przejść do następnego punktu; zostawić coś za sobą (emocjonalnie)',
  category = 'business',
  tags = '{meetings,progress}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Let''s move on to the next agenda item since we''ve covered the budget thoroughly.", "sentence_pl": "Przejdźmy do następnego punktu programu, ponieważ dokładnie omówiliśmy budżet.", "context_en": "Meeting facilitator transitioning discussion after completing previous topic", "context_pl": "Prowadzący spotkanie przechodzi do kolejnego tematu po zakończeniu poprzedniego", "tense": "Imperative (Let''s)", "grammar_note": "Imperative form ''let''s move on'' suggests collective action, with preposition ''to'' introducing the next topic and ''since'' clause providing justification."}, {"sentence_en": "After the company restructuring, she moved on to a new role in the marketing department.", "sentence_pl": "Po restrukturyzacji firmy przeszła do nowej roli w dziale marketingu.", "context_en": "Employee career transition following organizational changes and new opportunity", "context_pl": "Zmiana kariery pracownika po zmianach organizacyjnych i nowej możliwości", "tense": "Past Simple", "grammar_note": "Past Simple ''moved on'' indicates completed transition to new position, with preposition ''to'' introducing the destination role."}, {"sentence_en": "We can''t move on with the project until the client approves the initial design.", "sentence_pl": "Nie możemy kontynuować projektu, dopóki klient nie zatwierdzi wstępnego projektu.", "context_en": "Project dependency explaining delay waiting for stakeholder approval", "context_pl": "Zależność projektowa wyjaśniająca opóźnienie w oczekiwaniu na zgodę interesariusza", "tense": "Present Simple (modal + negative)", "grammar_note": "Modal ''can''t'' with base form ''move on'' expresses present inability to progress, with ''until'' clause specifying the required condition."}, {"sentence_en": "The team has been struggling to move on from the failed product launch last quarter.", "sentence_pl": "Zespół ma trudności z przejściem do przodu po nieudanym wprowadzeniu produktu w ostatnim kwartale.", "context_en": "Group facing difficulty recovering psychologically from business setback", "context_pl": "Grupa ma trudności z psychologicznym wyjściem z niepowodzenia biznesowego", "tense": "Present Perfect Continuous", "grammar_note": "Present Perfect Continuous ''has been struggling'' emphasizes ongoing difficulty, with infinitive ''to move on from'' expressing the challenging action."}]'::JSONB
WHERE id = 261;

UPDATE public.phrasal_verbs
SET 
  verb = 'print out',
  definition_en = 'To produce a physical paper copy of a digital document using a printer. This action transforms electronic information stored on a computer or device into a tangible printed format for reading, signing, filing, or distribution.',
  translation_pl = 'wydrukować; drukować (z komputera); zrobić wydruk; wykonać kopię papierową',
  category = 'general',
  tags = '{office,admin}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Could you print out the quarterly report before tomorrow''s board meeting?", "sentence_pl": "Czy mógłbyś wydrukować raport kwartalny przed jutrzejszym posiedzeniem zarządu?", "context_en": "Colleague requesting document preparation for executive presentation", "context_pl": "Kolega prosi o przygotowanie dokumentu na prezentację dla kadry zarządzającej", "tense": "Modal verb (could)", "grammar_note": "Modal ''could'' with base form ''print out'' forms polite request, with time phrase ''before tomorrow''s meeting'' specifying the deadline."}, {"sentence_en": "She printed out all the contracts and organized them in folders for the audit.", "sentence_pl": "Wydrukowała wszystkie umowy i uporządkowała je w teczkach na potrzeby audytu.", "context_en": "Administrative preparation creating physical documentation for compliance review", "context_pl": "Przygotowanie administracyjne tworzące fizyczną dokumentację do przeglądu zgodności", "tense": "Past Simple", "grammar_note": "Past Simple ''printed out'' describes completed action, coordinated with ''organized'' to show sequential administrative tasks."}, {"sentence_en": "We''re trying to print out fewer documents to reduce our environmental footprint.", "sentence_pl": "Staramy się drukować mniej dokumentów, aby zmniejszyć nasz ślad środowiskowy.", "context_en": "Office sustainability initiative encouraging digital-first document management", "context_pl": "Inicjatywa zrównoważonego rozwoju w biurze zachęcająca do cyfrowego zarządzania dokumentami", "tense": "Present Continuous", "grammar_note": "Present Continuous ''are trying to print out'' with comparative ''fewer'' emphasizes ongoing effort toward environmental goal, with purpose infinitive."}, {"sentence_en": "The printer has been printing out blank pages all morning and needs servicing.", "sentence_pl": "Drukarka drukuje puste strony przez cały ranek i wymaga serwisowania.", "context_en": "Equipment malfunction report describing technical problem requiring maintenance", "context_pl": "Raport o awarii sprzętu opisujący problem techniczny wymagający konserwacji", "tense": "Present Perfect Continuous", "grammar_note": "Present Perfect Continuous ''has been printing out'' emphasizes the duration of the malfunction, with time phrase ''all morning'' and consequence ''needs servicing''."}]'::JSONB
WHERE id = 262;

UPDATE public.phrasal_verbs
SET 
  verb = 'see off',
  definition_en = 'To accompany someone to their point of departure (such as an airport, train station, or dock) and say goodbye to them as they leave on a journey. This action demonstrates care and involves staying until the person departs, often with emotional farewells.',
  translation_pl = 'odprowadzić (kogoś na dworzec/lotnisko); pożegnać przy wyjeździe; towarzyszyć do momentu odjazdu',
  category = 'general',
  tags = '{travel,social}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "My whole family came to see me off at the airport when I moved abroad.", "sentence_pl": "Cała moja rodzina przyszła odprowadzić mnie na lotnisko, gdy wyprowadzałem się za granicę.", "context_en": "Emotional family farewell at significant life transition and relocation", "context_pl": "Emocjonalne pożegnanie rodzinne przy ważnym przejściu życiowym i przeprowadzce", "tense": "Past Simple", "grammar_note": "Past Simple ''came to see off'' describes completed action, with infinitive of purpose and temporal clause explaining the context."}, {"sentence_en": "We always see our international visitors off at the train station after conferences.", "sentence_pl": "Zawsze odprowadzamy naszych międzynarodowych gości na dworzec kolejowy po konferencjach.", "context_en": "Corporate hospitality practice for business guests departing after events", "context_pl": "Praktyka gościnności korporacyjnej dla gości biznesowych wyjeżdżających po wydarzeniach", "tense": "Present Simple", "grammar_note": "Present Simple ''see off'' with ''always'' indicates habitual practice of hospitality, with time phrase ''after conferences'' providing context."}, {"sentence_en": "I''m planning to see him off tomorrow morning before his flight to Singapore.", "sentence_pl": "Planuję odprowadzić go jutro rano przed jego lotem do Singapuru.", "context_en": "Personal commitment to farewell friend or colleague before journey", "context_pl": "Osobiste zobowiązanie do pożegnania przyjaciela lub kolegi przed podróżą", "tense": "Present Continuous (future arrangement)", "grammar_note": "Present Continuous ''am planning'' with infinitive ''to see off'' expresses future intention, with time and location details providing specificity."}, {"sentence_en": "She would have seen us off, but she had an important meeting that morning.", "sentence_pl": "Odprowadzałaby nas, ale miała tego ranka ważne spotkanie.", "context_en": "Explanation of absence from farewell due to scheduling conflict", "context_pl": "Wyjaśnienie nieobecności na pożegnaniu z powodu konfliktu harmonogramowego", "tense": "Conditional Perfect (would have)", "grammar_note": "Conditional Perfect ''would have seen off'' expresses unrealized past possibility, with ''but'' introducing the preventing circumstance."}]'::JSONB
WHERE id = 263;

UPDATE public.phrasal_verbs
SET 
  verb = 'switch off',
  definition_en = 'To turn off a device, machine, or electrical appliance by using a switch or button, stopping its operation. Figuratively, it can also mean to stop paying attention, stop thinking about work, or mentally disengage and relax.',
  translation_pl = 'wyłączyć (urządzenie); zgasić; odłączyć od prądu; odciąć się (mentalnie); przestać myśleć (o pracy)',
  category = 'general',
  tags = '{technology,relaxation}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Please switch off all electronic devices during the flight''s takeoff and landing.", "sentence_pl": "Proszę wyłączyć wszystkie urządzenia elektroniczne podczas startu i lądowania samolotu.", "context_en": "Flight safety instruction from cabin crew about electronics policy", "context_pl": "Instrukcja bezpieczeństwa lotu od personelu pokładowego dotycząca polityki elektroniki", "tense": "Imperative", "grammar_note": "Imperative form ''switch off'' gives direct instruction, with ''please'' adding politeness and time phrase specifying when."}, {"sentence_en": "He finds it difficult to switch off from work even during vacations.", "sentence_pl": "Ma trudności z odcięciem się od pracy nawet podczas wakacji.", "context_en": "Personal struggle with work-life balance and mental disengagement", "context_pl": "Osobista walka z równowagą między pracą a życiem prywatnym i mentalnym odłączeniem", "tense": "Present Simple", "grammar_note": "Present Simple ''finds it difficult'' with infinitive ''to switch off'' expresses habitual difficulty, with ''from work'' showing figurative meaning."}, {"sentence_en": "The heating system automatically switched off when the temperature reached 22 degrees.", "sentence_pl": "System ogrzewania automatycznie się wyłączył, gdy temperatura osiągnęła 22 stopnie.", "context_en": "Smart home automation describing thermostat''s programmed response to temperature", "context_pl": "Automatyka inteligentnego domu opisująca zaprogramowaną reakcję termostatu na temperaturę", "tense": "Past Simple", "grammar_note": "Past Simple ''switched off'' describes completed automatic action, with adverb ''automatically'' and temporal clause specifying the trigger condition."}, {"sentence_en": "We should switch off the lights when leaving the office to save energy.", "sentence_pl": "Powinniśmy wyłączać światła, wychodząc z biura, aby oszczędzać energię.", "context_en": "Workplace sustainability recommendation about electricity conservation practice", "context_pl": "Zalecenie dotyczące zrównoważonego rozwoju w miejscu pracy o praktyce oszczędzania energii elektrycznej", "tense": "Modal verb (should)", "grammar_note": "Modal ''should'' with base form ''switch off'' expresses recommendation, with temporal clause ''when leaving'' and purpose infinitive ''to save''."}]'::JSONB
WHERE id = 264;

UPDATE public.phrasal_verbs
SET 
  verb = 'switch on',
  definition_en = 'To activate or turn on a device, machine, or electrical appliance by using a switch or button, starting its operation. This is the opposite of switch off and begins the functioning of equipment or systems.',
  translation_pl = 'włączyć (urządzenie); uruchomić; zapalić (światło); załączyć prąd',
  category = 'general',
  tags = '{technology,daily}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Could you switch on the air conditioning? It''s getting quite warm in here.", "sentence_pl": "Czy mógłbyś włączyć klimatyzację? Robi się tu dość ciepło.", "context_en": "Request for climate control adjustment due to uncomfortable temperature", "context_pl": "Prośba o regulację klimatyzacji z powodu niewygodnej temperatury", "tense": "Modal verb (could)", "grammar_note": "Modal ''could'' with base form ''switch on'' forms polite request, followed by explanation with Present Continuous describing current condition."}, {"sentence_en": "The office lights switch on automatically at 7 AM every weekday morning.", "sentence_pl": "Światła biurowe włączają się automatycznie o 7 rano każdego dnia powszedniego.", "context_en": "Building automation system describing scheduled lighting control routine", "context_pl": "System automatyki budynkowej opisujący zaplanowaną rutynę kontroli oświetlenia", "tense": "Present Simple", "grammar_note": "Present Simple ''switch on'' describes habitual automated action, with adverb ''automatically'' and time phrases indicating the schedule."}, {"sentence_en": "She switched on her laptop and immediately checked her emails for urgent messages.", "sentence_pl": "Włączyła laptopa i natychmiast sprawdziła swoje e-maile w poszukiwaniu pilnych wiadomości.", "context_en": "Morning work routine beginning with device activation and priority checking", "context_pl": "Poranna rutyna pracy rozpoczynająca się od aktywacji urządzenia i sprawdzania priorytetów", "tense": "Past Simple", "grammar_note": "Past Simple ''switched on'' describes completed action, coordinated with ''checked'' using ''and'' to show quick sequential actions, emphasized by ''immediately''."}, {"sentence_en": "Don''t switch on the equipment until you''ve read the safety instructions carefully.", "sentence_pl": "Nie włączaj sprzętu, dopóki dokładnie nie przeczytasz instrukcji bezpieczeństwa.", "context_en": "Safety warning emphasizing importance of reading documentation before operation", "context_pl": "Ostrzeżenie bezpieczeństwa podkreślające znaczenie przeczytania dokumentacji przed obsługą", "tense": "Imperative (negative)", "grammar_note": "Negative imperative ''don''t switch on'' gives safety instruction, with ''until'' clause specifying the required prior action in Present Perfect."}]'::JSONB
WHERE id = 265;

UPDATE public.phrasal_verbs
SET 
  verb = 'take up',
  definition_en = 'To begin a new activity, hobby, or pursuit, especially one that requires regular time and commitment. It can also mean to occupy time or space, or to accept an offer or opportunity that has been presented.',
  translation_pl = 'rozpocząć (hobby/aktywność); podjąć się (czegoś); zająć się; zabrać (czas/miejsce); przyjąć (ofertę)',
  category = 'general',
  tags = '{hobbies,time mgmt}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "I''ve decided to take up yoga to improve my flexibility and reduce stress.", "sentence_pl": "Zdecydowałem się rozpocząć jogę, aby poprawić elastyczność i zmniejszyć stres.", "context_en": "Personal wellness decision to start new physical activity for health", "context_pl": "Osobista decyzja o dobrym samopoczuciu, aby rozpocząć nową aktywność fizyczną dla zdrowia", "tense": "Present Perfect", "grammar_note": "Present Perfect ''have decided'' with infinitive ''to take up'' expresses recent decision about starting a hobby, with purpose infinitives explaining motivation."}, {"sentence_en": "The new project is taking up most of my time, so I''ve had to postpone other tasks.", "sentence_pl": "Nowy projekt zabiera większość mojego czasu, więc musiałem przełożyć inne zadania.", "context_en": "Time management challenge explaining workload impact on other responsibilities", "context_pl": "Wyzwanie zarządzania czasem wyjaśniające wpływ obciążenia pracą na inne obowiązki", "tense": "Present Continuous", "grammar_note": "Present Continuous ''is taking up'' emphasizes ongoing consumption of time, with result clause showing the consequence in Present Perfect."}, {"sentence_en": "She took up the manager''s offer to lead the international expansion team.", "sentence_pl": "Przyjęła ofertę menedżera, aby poprowadzić zespół ekspansji międzynarodowej.", "context_en": "Career opportunity acceptance showing professional advancement decision", "context_pl": "Przyjęcie możliwości kariery pokazujące decyzję o awansie zawodowym", "tense": "Past Simple", "grammar_note": "Past Simple ''took up'' indicates completed acceptance of opportunity, with infinitive ''to lead'' explaining the role offered."}, {"sentence_en": "Many professionals are taking up online courses to develop new skills during evenings.", "sentence_pl": "Wielu profesjonalistów podejmuje kursy online, aby rozwijać nowe umiejętności podczas wieczorów.", "context_en": "Professional development trend showing learning pattern outside work hours", "context_pl": "Trend rozwoju zawodowego pokazujący wzorzec uczenia się poza godzinami pracy", "tense": "Present Continuous", "grammar_note": "Present Continuous ''are taking up'' describes current trend of starting courses, with purpose infinitive and time phrase specifying when."}]'::JSONB
WHERE id = 266;

UPDATE public.phrasal_verbs
SET 
  verb = 'write down',
  definition_en = 'To record information on paper or in a digital document for future reference, typically to remember important details, instructions, or ideas. This action helps preserve information that might otherwise be forgotten and creates a physical or digital record.',
  translation_pl = 'zapisać; zanotować; spisać; wpisać do notatek; udokumentować na piśmie',
  category = 'general',
  tags = '{admin,meetings}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Make sure you write down all the action items from today''s meeting.", "sentence_pl": "Upewnij się, że zapiszesz wszystkie zadania do wykonania z dzisiejszego spotkania.", "context_en": "Meeting management instruction ensuring task documentation for follow-up", "context_pl": "Instrukcja zarządzania spotkaniem zapewniająca dokumentację zadań do śledzenia", "tense": "Imperative", "grammar_note": "Imperative ''make sure'' followed by clause with Present Simple ''write down'' gives instruction about recording meeting outcomes."}, {"sentence_en": "She always writes down customer feedback immediately to ensure accuracy in our records.", "sentence_pl": "Zawsze od razu zapisuje opinie klientów, aby zapewnić dokładność w naszych zapisach.", "context_en": "Customer service practice emphasizing prompt and accurate information capture", "context_pl": "Praktyka obsługi klienta podkreślająca szybkie i dokładne rejestrowanie informacji", "tense": "Present Simple", "grammar_note": "Present Simple ''writes down'' with ''always'' indicates habitual practice, with adverb ''immediately'' and purpose infinitive explaining the reason."}, {"sentence_en": "I wrote down the client''s requirements during our call so I wouldn''t forget anything.", "sentence_pl": "Zapisałem wymagania klienta podczas naszej rozmowy, żebym niczego nie zapomniał.", "context_en": "Sales or project call documentation showing careful attention to details", "context_pl": "Dokumentacja rozmowy sprzedażowej lub projektowej pokazująca uważne zwracanie uwagi na szczegóły", "tense": "Past Simple", "grammar_note": "Past Simple ''wrote down'' describes completed action during the call, with purpose clause using conditional ''wouldn''t forget'' explaining motivation."}, {"sentence_en": "Could you write down your email address for me? I don''t have a business card with me.", "sentence_pl": "Czy mógłbyś zapisać mi swój adres e-mail? Nie mam przy sobie wizytówki.", "context_en": "Networking situation requesting contact information without standard business tools", "context_pl": "Sytuacja networkingowa prosząca o informacje kontaktowe bez standardowych narzędzi biznesowych", "tense": "Modal verb (could)", "grammar_note": "Modal ''could'' with base form ''write down'' forms polite request, with indirect object ''for me'' and explanation providing context."}]'::JSONB
WHERE id = 267;

UPDATE public.phrasal_verbs
SET 
  verb = 'zoom in',
  definition_en = 'To enlarge or magnify a view of something, typically on a screen or through a camera lens, to see more detail or examine something more closely. Figuratively, it can mean to focus attention on specific details or aspects of a larger topic or situation.',
  translation_pl = 'powiększyć (obraz); przybliżyć; zoomować; skupić się na szczegółach; skoncentrować uwagę (na detalu)',
  category = 'general',
  tags = '{technology,analysis}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Can you zoom in on that chart so we can see the exact figures more clearly?", "sentence_pl": "Czy możesz powiększyć ten wykres, żebyśmy mogli wyraźniej zobaczyć dokładne liczby?", "context_en": "Presentation request for better visibility of data visualization details", "context_pl": "Prośba prezentacyjna o lepszą widoczność szczegółów wizualizacji danych", "tense": "Modal verb (can)", "grammar_note": "Modal ''can'' with base form ''zoom in'' forms request, with purpose clause explaining the reason for magnification."}, {"sentence_en": "The analyst zoomed in on the quarterly sales data to identify the declining trend.", "sentence_pl": "Analityk skupił się na kwartalnych danych sprzedażowych, aby zidentyfikować spadkowy trend.", "context_en": "Business analysis showing detailed examination to find patterns", "context_pl": "Analiza biznesowa pokazująca szczegółowe badanie w celu znalezienia wzorców", "tense": "Past Simple", "grammar_note": "Past Simple ''zoomed in'' describes completed action of focusing attention, with preposition ''on'' introducing the object and purpose infinitive."}, {"sentence_en": "We need to zoom in on the customer complaints to understand what''s causing dissatisfaction.", "sentence_pl": "Musimy skupić się na skargach klientów, aby zrozumieć, co powoduje niezadowolenie.", "context_en": "Quality improvement initiative requiring detailed investigation of feedback", "context_pl": "Inicjatywa poprawy jakości wymagająca szczegółowego badania opinii", "tense": "Present Simple (modal + need to)", "grammar_note": "Modal structure ''need to zoom in'' expresses necessity of detailed focus, with purpose infinitive explaining the objective."}, {"sentence_en": "The photographer was zooming in to capture the intricate details of the product.", "sentence_pl": "Fotograf powiększał obraz, aby uchwycić skomplikowane szczegóły produktu.", "context_en": "Product photography session focusing on capturing fine details for marketing", "context_pl": "Sesja fotografii produktowej skupiająca się na uchwyceniu drobnych szczegółów do marketingu", "tense": "Past Continuous", "grammar_note": "Past Continuous ''was zooming in'' emphasizes ongoing action of magnifying, with purpose infinitive ''to capture'' explaining the photographer''s goal."}]'::JSONB
WHERE id = 268;

UPDATE public.phrasal_verbs
SET 
  verb = 'zoom out',
  definition_en = 'To reduce magnification or widen the view to see more of the surrounding context or overall picture, opposite of zoom in. Figuratively, it means to step back and look at the bigger picture, considering broader context rather than focusing on specific details.',
  translation_pl = 'pomniejszyć (obraz); oddalić widok; spojrzeć szerzej; przyjąć szerszą perspektywę; zobaczyć pełny obraz',
  category = 'general',
  tags = '{strategy,perspective}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Let''s zoom out and look at the overall market trends before making this decision.", "sentence_pl": "Przyjrzyjmy się szerzej i spójrzmy na ogólne trendy rynkowe przed podjęciem tej decyzji.", "context_en": "Strategic planning discussion encouraging holistic perspective before commitment", "context_pl": "Dyskusja nad planowaniem strategicznym zachęcająca do holistycznej perspektywy przed zobowiązaniem", "tense": "Imperative (Let''s)", "grammar_note": "Imperative ''let''s zoom out'' suggests collaborative action of broadening perspective, coordinated with ''look at'' and temporal clause."}, {"sentence_en": "When you zoom out on the map, you can see how all the regional offices are distributed.", "sentence_pl": "Kiedy oddalasz widok mapy, możesz zobaczyć, jak rozmieszczone są wszystkie biura regionalne.", "context_en": "Geographic visualization explaining spatial relationships at macro level", "context_pl": "Wizualizacja geograficzna wyjaśniająca relacje przestrzenne na poziomie makro", "tense": "Present Simple", "grammar_note": "Present Simple ''zoom out'' in temporal clause describes action, with main clause showing the resulting ability using modal ''can see''."}, {"sentence_en": "The consultant zoomed out from the operational details to discuss long-term strategy.", "sentence_pl": "Konsultant odszedł od szczegółów operacyjnych, aby omówić długoterminową strategię.", "context_en": "Advisory meeting shifting focus from tactical to strategic level thinking", "context_pl": "Spotkanie doradcze przesuwające uwagę z poziomu taktycznego na strategiczne myślenie", "tense": "Past Simple", "grammar_note": "Past Simple ''zoomed out'' describes completed shift in perspective, with ''from'' indicating departure point and purpose infinitive showing goal."}, {"sentence_en": "We''ve been too focused on small issues; we should zoom out and reassess our priorities.", "sentence_pl": "Byliśmy zbyt skupieni na małych problemach; powinniśmy spojrzeć szerzej i ponownie ocenić nasze priorytety.", "context_en": "Team reflection recognizing need to shift from details to strategic view", "context_pl": "Refleksja zespołowa rozpoznająca potrzebę przejścia od szczegółów do perspektywy strategicznej", "tense": "Present Perfect + Modal (should)", "grammar_note": "Present Perfect ''have been'' describes recent pattern, followed by modal ''should'' with base form ''zoom out'' recommending perspective change."}]'::JSONB
WHERE id = 269;

UPDATE public.phrasal_verbs
SET 
  verb = 'brush up on',
  definition_en = 'To review, practice, or study something you learned before in order to refresh your knowledge or skills that may have become rusty or outdated due to lack of use. This typically refers to revisiting previously acquired competencies rather than learning something completely new.',
  translation_pl = 'odświeżyć (wiedzę); powtórzyć (umiejętności); przypomnieć sobie; podszlifować; przećwiczyć ponownie',
  category = 'general',
  tags = '{learning,skills}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence_en": "I need to brush up on my German before the business trip to Berlin next month.", "sentence_pl": "Muszę odświeżyć mój niemiecki przed służbową podróżą do Berlina w przyszłym miesiącu.", "context_en": "Professional preparation reviewing language skills for international engagement", "context_pl": "Przygotowanie zawodowe przeglądające umiejętności językowe do zaangażowania międzynarodowego", "tense": "Present Simple (modal + need to)", "grammar_note": "Modal structure ''need to brush up on'' expresses necessity of refreshing skills, with time phrase indicating deadline."}, {"sentence_en": "She''s been brushing up on financial regulations since she accepted the compliance role.", "sentence_pl": "Odświeża przepisy finansowe, odkąd przyjęła rolę związaną z compliance.", "context_en": "Career transition requiring knowledge update for new responsibilities", "context_pl": "Zmiana kariery wymagająca aktualizacji wiedzy do nowych obowiązków", "tense": "Present Perfect Continuous", "grammar_note": "Present Perfect Continuous ''has been brushing up on'' emphasizes ongoing study since accepting the position, with ''since'' clause providing context."}, {"sentence_en": "The HR department organized workshops for employees to brush up on presentation skills.", "sentence_pl": "Dział HR zorganizował warsztaty dla pracowników, aby odświeżyli umiejętności prezentacyjne.", "context_en": "Corporate training initiative providing skill refreshment opportunity for staff", "context_pl": "Inicjatywa szkoleniowa firmy zapewniająca możliwość odświeżenia umiejętności dla pracowników", "tense": "Past Simple", "grammar_note": "Past Simple ''organized'' describes completed action, with purpose infinitive ''to brush up on'' explaining the workshops'' objective."}, {"sentence_en": "You should brush up on data analysis techniques before the advanced course begins.", "sentence_pl": "Powinieneś odświeżyć techniki analizy danych przed rozpoczęciem kursu zaawansowanego.", "context_en": "Educational advice recommending prerequisite review before higher-level training", "context_pl": "Porada edukacyjna zalecająca przegląd wymagań wstępnych przed szkoleniem wyższego poziomu", "tense": "Modal verb (should)", "grammar_note": "Modal ''should'' with base form ''brush up on'' gives advice about preparation, with temporal clause specifying timing."}]'::JSONB
WHERE id = 270;

UPDATE public.phrasal_verbs
SET 
  verb = 'come by',
  definition_en = 'To visit someone briefly or casually, often without a formal appointment. It can also mean to obtain or acquire something, especially when it''s difficult to get, or to happen upon something by chance.',
  translation_pl = 'wpaść (do kogoś); odwiedzić krótko; zdobyć (coś trudnego); natrafić na coś; nabyć',
  category = 'general',
  tags = '{social,acquisition}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence_en": "Feel free to come by my office this afternoon if you need to discuss the proposal.", "sentence_pl": "Możesz wpaść do mojego biura dziś po południu, jeśli musisz omówić propozycję.", "context_en": "Informal meeting invitation offering flexible discussion opportunity", "context_pl": "Nieformalne zaproszenie na spotkanie oferujące elastyczną możliwość dyskusji", "tense": "Imperative", "grammar_note": "Imperative ''feel free to come by'' gives informal permission to visit, with time phrase and conditional clause explaining purpose."}, {"sentence_en": "Skilled data analysts are hard to come by in this competitive market.", "sentence_pl": "Wykwalifikowanych analityków danych trudno znaleźć na tym konkurencyjnym rynku.", "context_en": "Recruitment challenge describing talent scarcity in employment landscape", "context_pl": "Wyzwanie rekrutacyjne opisujące niedobór talentów na rynku pracy", "tense": "Present Simple (infinitive construction)", "grammar_note": "Adjective ''hard'' with infinitive ''to come by'' expresses difficulty of acquisition, with subject ''skilled data analysts'' and context phrase."}, {"sentence_en": "A colleague came by earlier to drop off the documents you requested.", "sentence_pl": "Kolega wpadł wcześniej, aby zostawić dokumenty, o które prosiłeś.", "context_en": "Office delivery notification explaining brief visit for document handover", "context_pl": "Powiadomienie o dostawie biurowej wyjaśniające krótką wizytę w celu przekazania dokumentów", "tense": "Past Simple", "grammar_note": "Past Simple ''came by'' describes completed brief visit, with time adverb ''earlier'' and purpose infinitive ''to drop off'' explaining reason."}, {"sentence_en": "How did you come by this rare industry report? I''ve been searching for it everywhere.", "sentence_pl": "Jak zdobyłeś ten rzadki raport branżowy? Szukałem go wszędzie.", "context_en": "Curious inquiry about acquisition of difficult-to-obtain business intelligence", "context_pl": "Ciekawe zapytanie o nabycie trudnego do zdobycia wywiadu biznesowego", "tense": "Past Simple (interrogative)", "grammar_note": "Interrogative Past Simple ''did come by'' asks about method of acquisition, with adjective ''rare'' emphasizing difficulty and follow-up explanation."}]'::JSONB
WHERE id = 271;

UPDATE public.phrasal_verbs
SET 
  verb = 'hold back',
  definition_en = 'To restrain, prevent, or keep something or someone from moving forward or progressing. It can refer to physically restraining, emotionally suppressing feelings, withholding information, or preventing advancement or development.',
  translation_pl = 'powstrzymać (się); zatrzymać; hamować rozwój; ukrywać (emocje/informacje); trzymać w rezerwie',
  category = 'general',
  tags = '{negotiation,emotion}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Don''t hold back your ideas during brainstorming sessions; every suggestion is valuable.", "sentence_pl": "Nie powstrzymuj swoich pomysłów podczas sesji burzy mózgów; każda sugestia jest cenna.", "context_en": "Team facilitation encouraging open contribution and creative participation", "context_pl": "Facylitacja zespołowa zachęcająca do otwartego wkładu i kreatywnego uczestnictwa", "tense": "Imperative (negative)", "grammar_note": "Negative imperative ''don''t hold back'' instructs against restraint, with time phrase and explanation clause justifying the encouragement."}, {"sentence_en": "The lack of investment has been holding back the company''s digital transformation.", "sentence_pl": "Brak inwestycji hamuje cyfrową transformację firmy.", "context_en": "Business analysis identifying financial constraint preventing organizational progress", "context_pl": "Analiza biznesowa identyfikująca ograniczenie finansowe zapobiegające postępowi organizacyjnemu", "tense": "Present Perfect Continuous", "grammar_note": "Present Perfect Continuous ''has been holding back'' emphasizes ongoing restraining effect, with subject explaining the cause of impediment."}, {"sentence_en": "She held back tears during the emotional farewell speech at her retirement party.", "sentence_pl": "Powstrzymywała łzy podczas emocjonalnego przemówienia pożegnalnego na swojej imprezie emerytalnej.", "context_en": "Emotional moment showing effort to suppress feelings at significant event", "context_pl": "Emocjonalny moment pokazujący wysiłek tłumienia uczuć podczas ważnego wydarzenia", "tense": "Past Simple", "grammar_note": "Past Simple ''held back'' describes successful emotional restraint, with time phrase and context explaining the challenging situation."}, {"sentence_en": "I think he''s holding back some information about the project''s budget challenges.", "sentence_pl": "Myślę, że ukrywa niektóre informacje o wyzwaniach budżetowych projektu.", "context_en": "Suspicion about incomplete disclosure regarding financial difficulties", "context_pl": "Podejrzenie o niekompletne ujawnienie dotyczące trudności finansowych", "tense": "Present Continuous", "grammar_note": "Present Continuous ''is holding back'' describes ongoing withholding, with introductory ''I think'' expressing speculation and quantifier ''some''."}]'::JSONB
WHERE id = 272;

UPDATE public.phrasal_verbs
SET 
  verb = 'give off',
  definition_en = 'To emit, produce, or send out something such as heat, light, smell, or signals. It can also mean to project a particular impression, feeling, or atmosphere that others perceive, often unintentionally.',
  translation_pl = 'wydzielać; emitować (zapach/ciepło); emanować; sprawiać wrażenie; dawać odczucie',
  category = 'general',
  tags = '{environment,impression}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "The new office design gives off a modern and collaborative atmosphere that employees love.", "sentence_pl": "Nowy projekt biura emanuje nowoczesną i współpracującą atmosferą, którą pracownicy uwielbiają.", "context_en": "Workplace environment assessment describing positive ambience created by design", "context_pl": "Ocena środowiska pracy opisująca pozytywny klimat stworzony przez projekt", "tense": "Present Simple", "grammar_note": "Present Simple ''gives off'' describes ongoing emission of atmosphere, with adjectives describing the impression and relative clause showing reception."}, {"sentence_en": "The faulty equipment was giving off a strange smell, so we evacuated the building.", "sentence_pl": "Wadliwy sprzęt wydzielał dziwny zapach, więc ewakuowaliśmy budynek.", "context_en": "Safety incident requiring immediate response to potential hazard", "context_pl": "Incydent bezpieczeństwa wymagający natychmiastowej reakcji na potencjalne zagrożenie", "tense": "Past Continuous", "grammar_note": "Past Continuous ''was giving off'' emphasizes ongoing emission during the incident, with result clause explaining the safety response taken."}, {"sentence_en": "Her confident presentation gave off an impression of expertise and thorough preparation.", "sentence_pl": "Jej pewna siebie prezentacja sprawiała wrażenie ekspertyzy i dokładnego przygotowania.", "context_en": "Professional communication success demonstrating strong competence signals", "context_pl": "Sukces komunikacji zawodowej demonstrujący silne sygnały kompetencji", "tense": "Past Simple", "grammar_note": "Past Simple ''gave off'' describes the impression created, with adjective ''confident'' modifying subject and compound object describing the perception."}, {"sentence_en": "These LED lights don''t give off much heat compared to traditional bulbs.", "sentence_pl": "Te lampki LED nie wydzielają dużo ciepła w porównaniu do tradycyjnych żarówek.", "context_en": "Energy efficiency comparison highlighting thermal advantage of technology", "context_pl": "Porównanie efektywności energetycznej podkreślające zalety termiczne technologii", "tense": "Present Simple (negative)", "grammar_note": "Present Simple negative ''don''t give off'' describes characteristic of LEDs, with quantifier ''much'' and comparative phrase providing context."}]'::JSONB
WHERE id = 273;

UPDATE public.phrasal_verbs
SET 
  verb = 'grow on',
  definition_en = 'To gradually become more liked, appreciated, or accepted over time, despite an initial neutral or negative reaction. This phrasal verb describes how opinions or preferences change through repeated exposure or experience, often unexpectedly.',
  translation_pl = 'stopniowo się podobać; zacząć przypadać do gustu; z czasem polubić; przyzwyczaić się (do czegoś/kogoś)',
  category = 'general',
  tags = '{preference,opinion}'::TEXT[],
  register = 'neutral',
  difficulty = 'C1',
  examples = '[{"sentence_en": "The new office location didn''t appeal to me at first, but it''s growing on me.", "sentence_pl": "Nowa lokalizacja biura nie przemawiała do mnie na początku, ale zaczyna mi się podobać.", "context_en": "Workplace change showing evolving positive attitude toward new environment", "context_pl": "Zmiana miejsca pracy pokazująca rozwijające się pozytywne nastawienie do nowego środowiska", "tense": "Present Continuous", "grammar_note": "Present Continuous ''is growing on'' emphasizes ongoing change in opinion, with contrast to Past Simple negative ''didn''t appeal'' showing evolution."}, {"sentence_en": "His unconventional management style has gradually grown on the team over the past year.", "sentence_pl": "Jego niekonwencjonalny styl zarządzania stopniowo przypadł do gustu zespołowi w ciągu ostatniego roku.", "context_en": "Leadership acceptance describing team''s changing perception of different approach", "context_pl": "Akceptacja przywództwa opisująca zmieniające się postrzeganie innego podejścia przez zespół", "tense": "Present Perfect", "grammar_note": "Present Perfect ''has grown on'' emphasizes completed change in perception, with adverb ''gradually'' and time phrase showing the process."}, {"sentence_en": "I wasn''t sure about the new software at first, but after using it daily, it grew on me.", "sentence_pl": "Nie byłem pewien nowego oprogramowania na początku, ale po codziennym używaniu zaczęło mi się podobać.", "context_en": "Technology adoption showing acceptance developing through regular usage", "context_pl": "Adopcja technologii pokazująca akceptację rozwijającą się przez regularne użytkowanie", "tense": "Past Simple", "grammar_note": "Past Simple ''grew on'' describes completed change in opinion, with temporal phrase ''after using'' explaining the cause of changing perception."}, {"sentence_en": "This type of analytical work might not excite you initially, but it tends to grow on people.", "sentence_pl": "Ten rodzaj pracy analitycznej może nie ekscytować cię początkowo, ale ma tendencję do podobania się ludziom z czasem.", "context_en": "Career guidance explaining common pattern of developing appreciation for role", "context_pl": "Poradnictwo zawodowe wyjaśniające powszechny wzorzec rozwijania uznania dla roli", "tense": "Present Simple (infinitive)", "grammar_note": "Present Simple ''tends to grow on'' expresses general pattern, with modal ''might not'' showing initial reaction and time adverb ''initially''."}]'::JSONB
WHERE id = 274;

UPDATE public.phrasal_verbs
SET 
  verb = 'hand out',
  definition_en = 'To distribute or give things to a group of people, typically to each person individually. This is commonly done in meetings, classes, or events when materials, documents, or items need to be shared with multiple recipients.',
  translation_pl = 'rozdać; rozdzielić; wręczyć (materiały); rozprowadzić (dokumenty)',
  category = 'general',
  tags = '{meetings,training}'::TEXT[],
  register = 'neutral',
  difficulty = 'B2',
  examples = '[{"sentence_en": "Please hand out these agendas to everyone before the meeting starts.", "sentence_pl": "Proszę rozdaj te programy spotkań wszystkim, zanim rozpocznie się zebranie.", "context_en": "Meeting preparation instruction ensuring participants receive necessary documents", "context_pl": "Instrukcja przygotowania spotkania zapewniająca uczestnikom otrzymanie niezbędnych dokumentów", "tense": "Imperative", "grammar_note": "Imperative ''hand out'' gives direct instruction about distribution, with time clause specifying deadline and recipient ''to everyone''."}, {"sentence_en": "The trainer handed out worksheets and asked participants to complete them in pairs.", "sentence_pl": "Trener rozdał arkusze robocze i poprosił uczestników o wypełnienie ich w parach.", "context_en": "Training session activity involving material distribution for collaborative exercise", "context_pl": "Aktywność szkoleniowa obejmująca dystrybucję materiałów do ćwiczenia grupowego", "tense": "Past Simple", "grammar_note": "Past Simple ''handed out'' describes completed distribution, coordinated with ''asked'' using ''and'' to show sequential training actions."}, {"sentence_en": "We''ve been handing out customer satisfaction surveys at the end of each consultation.", "sentence_pl": "Rozdajemy ankiety satysfakcji klientów na końcu każdej konsultacji.", "context_en": "Quality assurance practice collecting feedback through systematic distribution process", "context_pl": "Praktyka zapewnienia jakości zbierająca opinie poprzez systematyczny proces dystrybucji", "tense": "Present Perfect Continuous", "grammar_note": "Present Perfect Continuous ''have been handing out'' emphasizes ongoing practice of distribution, with time phrase indicating when."}, {"sentence_en": "Could someone hand out the name badges to the conference attendees at registration?", "sentence_pl": "Czy ktoś mógłby rozdać identyfikatory uczestnikom konferencji przy rejestracji?", "context_en": "Event logistics request for volunteer to manage credential distribution", "context_pl": "Prośba logistyczna wydarzenia o wolontariusza do zarządzania dystrybucją akredytacji", "tense": "Modal verb (could)", "grammar_note": "Modal ''could'' with indefinite subject ''someone'' forms polite request, with location phrase ''at registration'' specifying where distribution occurs."}]'::JSONB
WHERE id = 275;
