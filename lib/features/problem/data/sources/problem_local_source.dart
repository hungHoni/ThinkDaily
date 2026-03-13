import 'package:think_daily/features/problem/data/models/problem.dart';
import 'package:think_daily/features/problem/data/models/track.dart';
import 'package:think_daily/features/problem/data/models/user_progress.dart';

class ProblemLocalSource {
  List<Track> getAllTracks() => _tracks;

  List<Unit> getUnitsForTrack(String trackId) =>
      _units.where((u) => u.trackId == trackId).toList();

  List<Problem> getProblemsByTrack(String trackId) =>
      _problems.where((p) => p.trackId == trackId).toList();

  List<Problem> getAllProblems() => List.unmodifiable(_problems);

  /// Returns the next problem in the curriculum based on user progress.
  /// Returns null if the track is complete.
  Problem? getNextProblem(UserProgress progress, List<Problem> trackProblems) {
    try {
      return trackProblems.firstWhere(
        (p) =>
            p.unitIndex == progress.currentUnitIndex &&
            p.questionIndex == progress.currentQuestionIndex,
      );
    } catch (_) {
      return null;
    }
  }
}

// ─── Tracks ──────────────────────────────────────────────────────────────────

const _tracks = <Track>[
  Track(
    id: 'problem-decomposition',
    title: 'Problem Decomposition',
    description: 'Learn to frame the right problem before solving anything.',
    totalUnits: 4,
  ),
  Track(
    id: 'systems-thinking',
    title: 'Systems Thinking',
    description: 'See how parts connect, loops form, and changes ripple.',
    totalUnits: 4,
  ),
  Track(
    id: 'mental-models',
    title: 'Mental Models',
    description: 'Choose the right frame for any problem.',
    totalUnits: 5,
  ),
  Track(
    id: 'decision-making',
    title: 'Decision Making',
    description: 'How do I choose under uncertainty?',
    totalUnits: 4,
  ),
  Track(
    id: 'estimation-scale',
    title: 'Estimation & Scale',
    description: 'Is this number reasonable?',
    totalUnits: 4,
  ),
  Track(
    id: 'critical-evaluation',
    title: 'Critical Evaluation',
    description: 'What could go wrong?',
    totalUnits: 4,
  ),
  Track(
    id: 'system-design',
    title: 'System Design Thinking',
    description: 'How do the pieces fit?',
    totalUnits: 4,
  ),
  Track(
    id: 'communication',
    title: 'Communication Thinking',
    description: 'How do I make this understood?',
    totalUnits: 3,
  ),
];

// ─── Units ───────────────────────────────────────────────────────────────────

const _units = <Unit>[
  Unit(
    trackId: 'problem-decomposition',
    index: 0,
    title: 'Framing the Right Problem',
    subtitle: 'Are you solving the right thing?',
  ),
  Unit(
    trackId: 'problem-decomposition',
    index: 1,
    title: 'Breaking It Down',
    subtitle: 'How do you split a big problem?',
  ),
  Unit(
    trackId: 'problem-decomposition',
    index: 2,
    title: 'Knowing When to Stop',
    subtitle: 'How deep is deep enough?',
  ),
  Unit(
    trackId: 'problem-decomposition',
    index: 3,
    title: 'Constraints as Clarity',
    subtitle: 'What limits are actually telling you.',
  ),

  // ── Track 2: Systems Thinking ───────────────────────────────────────────────

  Unit(
    trackId: 'systems-thinking',
    index: 0,
    title: 'Feedback Loops',
    subtitle: 'What happens next, and then what?',
  ),
  Unit(
    trackId: 'systems-thinking',
    index: 1,
    title: 'Second-Order Effects',
    subtitle: 'The consequences of your consequences.',
  ),
  Unit(
    trackId: 'systems-thinking',
    index: 2,
    title: 'Bottlenecks',
    subtitle: 'Where does the system actually slow down?',
  ),
  Unit(
    trackId: 'systems-thinking',
    index: 3,
    title: 'Emergence',
    subtitle: 'When the whole is more than its parts.',
  ),

  // ── Track 3: Mental Models ───────────────────────────────────────────────────

  Unit(
    trackId: 'mental-models',
    index: 0,
    title: 'First Principles Thinking',
    subtitle: 'Break it down to what is actually true.',
  ),
  Unit(
    trackId: 'mental-models',
    index: 1,
    title: 'Inversion',
    subtitle: 'Ask what would make it fail.',
  ),
  Unit(
    trackId: 'mental-models',
    index: 2,
    title: "Occam's Razor",
    subtitle: 'Start with the simplest explanation.',
  ),
  Unit(
    trackId: 'mental-models',
    index: 3,
    title: 'Map vs Territory',
    subtitle: 'The model is not the thing it models.',
  ),
  Unit(
    trackId: 'mental-models',
    index: 4,
    title: 'Second-Order Thinking',
    subtitle: 'And then what happens after that?',
  ),

  // ── Track 4: Decision Making ────────────────────────────────────────────────

  Unit(
    trackId: 'decision-making',
    index: 0,
    title: 'Reversible vs Irreversible',
    subtitle: 'Which type of decision is this?',
  ),
  Unit(
    trackId: 'decision-making',
    index: 1,
    title: 'Deciding with Incomplete Information',
    subtitle: 'What is the minimum you need to know?',
  ),
  Unit(
    trackId: 'decision-making',
    index: 2,
    title: 'Trade-offs',
    subtitle: 'Every choice costs something.',
  ),
  Unit(
    trackId: 'decision-making',
    index: 3,
    title: 'Cognitive Bias in Technical Decisions',
    subtitle: 'Watch out for these patterns.',
  ),

  // ── Track 5: Estimation & Scale ─────────────────────────────────────────────

  Unit(
    trackId: 'estimation-scale',
    index: 0,
    title: 'Fermi Estimation',
    subtitle: 'Decompose the big question.',
  ),
  Unit(
    trackId: 'estimation-scale',
    index: 1,
    title: 'Orders of Magnitude',
    subtitle: 'Recognise the scale.',
  ),
  Unit(
    trackId: 'estimation-scale',
    index: 2,
    title: 'Cost Estimation',
    subtitle: 'What is the real cost?',
  ),
  Unit(
    trackId: 'estimation-scale',
    index: 3,
    title: 'Capacity Thinking',
    subtitle: 'How much can this hold?',
  ),

  // ── Track 6: Critical Evaluation ────────────────────────────────────────────

  Unit(
    trackId: 'critical-evaluation',
    index: 0,
    title: 'Spotting Flawed Assumptions',
    subtitle: 'What is unstated?',
  ),
  Unit(
    trackId: 'critical-evaluation',
    index: 1,
    title: 'Edge Cases',
    subtitle: 'Zero, one, and many.',
  ),
  Unit(
    trackId: 'critical-evaluation',
    index: 2,
    title: 'Failure Modes',
    subtitle: 'How could this break?',
  ),
  Unit(
    trackId: 'critical-evaluation',
    index: 3,
    title: 'Evaluating AI Output',
    subtitle: 'Trust, but verify.',
  ),

  // ── Track 7: System Design Thinking ─────────────────────────────────────────

  Unit(
    trackId: 'system-design',
    index: 0,
    title: 'Trade-offs in Architecture',
    subtitle: 'Consistency vs availability.',
  ),
  Unit(
    trackId: 'system-design',
    index: 1,
    title: 'Scalability Patterns',
    subtitle: 'Growing without breaking.',
  ),
  Unit(
    trackId: 'system-design',
    index: 2,
    title: 'Reliability',
    subtitle: 'What does 99.9% mean?',
  ),
  Unit(
    trackId: 'system-design',
    index: 3,
    title: 'Bottleneck Thinking in Systems',
    subtitle: 'Find the weakest link.',
  ),

  // ── Track 8: Communication Thinking ─────────────────────────────────────────

  Unit(
    trackId: 'communication',
    index: 0,
    title: 'Audience Awareness',
    subtitle: 'Who am I talking to?',
  ),
  Unit(
    trackId: 'communication',
    index: 1,
    title: 'Making Complexity Clear',
    subtitle: 'Clarity over jargon.',
  ),
  Unit(
    trackId: 'communication',
    index: 2,
    title: 'Writing for Decisions',
    subtitle: 'Make the case.',
  ),
];

// ─── Problems — Track 1: Problem Decomposition ───────────────────────────────

const _problems = <Problem>[

  // ── Unit 0: Framing the Right Problem ──────────────────────────────────────

  Problem(
    id: 'pd-u0-q0',
    trackId: 'problem-decomposition',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'FRAMING THE RIGHT PROBLEM',
    type: ProblemType.choice,
    prompt:
        'A user emails support: "How do I delete a row from my spreadsheet?" '
        'You fix it. Next day: "How do I remove the blank line it leaves?" '
        'You fix that. A week later: "How do I stop duplicates appearing?"\n\n'
        'What is the real problem they have been trying to solve all along?',
    options: [
      'They do not know how to use spreadsheets',
      'Their underlying data process is generating duplicates',
      'The UI is too confusing',
      'They need better documentation',
    ],
    correctAnswer: 1,
    explanation:
        'This is the XY Problem — people ask about their attempted solution, '
        'not their actual problem. Each message was a symptom. The real problem '
        'is upstream: something is creating duplicates in the first place. '
        'Good problem solvers ask "why are you trying to do that?" before '
        'answering the surface question.',
    thinkingPattern: 'Root Cause vs Symptom',
  ),

  Problem(
    id: 'pd-u0-q1',
    trackId: 'problem-decomposition',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'FRAMING THE RIGHT PROBLEM',
    type: ProblemType.choice,
    prompt:
        'A city hires you to fix traffic congestion on a bridge. After studying '
        'it, you find that 60% of cars cross the bridge only to reach a shopping '
        'mall — which also has a direct entrance from the highway bypass nearby.\n\n'
        'What is the right problem to solve?',
    options: [
      'Widen the bridge to add more lanes',
      'Add tolls to reduce bridge usage',
      'Improve signage so mall traffic uses the highway bypass instead',
      'Build a second bridge nearby',
    ],
    correctAnswer: 2,
    explanation:
        'The problem was not "the bridge is too small" — it was "cars are '
        'using the wrong route." Widening costs millions and solves a symptom. '
        'Redirecting traffic removes the cause cheaply. Before solving, always '
        'ask: why is this happening? The solution might already exist.',
    thinkingPattern: 'Reframing',
  ),

  Problem(
    id: 'pd-u0-q2',
    trackId: 'problem-decomposition',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'FRAMING THE RIGHT PROBLEM',
    type: ProblemType.choice,
    prompt:
        'A product team interviews 50 users. They all say they want "a faster '
        'checkout." The team spends 3 months optimising checkout speed. '
        'Usage drops anyway.\n\n'
        'What most likely went wrong?',
    options: [
      'The optimisation was not fast enough',
      'Users described a symptom — they wanted less friction, not raw speed',
      'The team should have surveyed more users',
      'Checkout was already fast enough before',
    ],
    correctAnswer: 1,
    explanation:
        'Users observe symptoms and describe solutions. "Faster checkout" meant '
        '"this process feels annoying." Speed was one theory — but friction also '
        'comes from confusion, too many steps, and distrust. The real need was '
        '"effortless purchase." Always separate what users say from what they '
        'actually need.',
    thinkingPattern: 'Jobs-to-be-Done',
  ),

  // ── Unit 1: Breaking It Down ────────────────────────────────────────────────

  Problem(
    id: 'pd-u1-q0',
    trackId: 'problem-decomposition',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'BREAKING IT DOWN',
    type: ProblemType.choice,
    prompt:
        'You are asked to build "a notification system." Before writing any '
        'code, you need to break it down.\n\n'
        'Which first decomposition is most useful?',
    options: [
      'Frontend components, backend services, database schema',
      'Who gets notified, when, through what channel, and what happens if it fails',
      'Which programming language and framework to use',
      'How many notifications per second it needs to handle',
    ],
    correctAnswer: 1,
    explanation:
        'Technical decomposition is premature — you do not know what you are '
        'building yet. Scale is a constraint, not a structure. The right first '
        'split is behavioral: actors, triggers, channels, failure modes. These '
        'questions reveal what you actually need to build before touching '
        'anything technical.',
    thinkingPattern: 'Functional Decomposition',
  ),

  Problem(
    id: 'pd-u1-q1',
    trackId: 'problem-decomposition',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'BREAKING IT DOWN',
    type: ProblemType.choice,
    prompt:
        'You are launching a feature. Your tasks:\n'
        '1. Write the API\n'
        '2. Design the database schema\n'
        '3. Build the UI\n'
        '4. Write tests\n'
        '5. Get stakeholder approval on the design\n\n'
        'In what order should these actually happen?',
    options: [
      '1 → 2 → 3 → 4 → 5',
      '5 → 2 → 1 → 3 → 4',
      '3 → 5 → 2 → 1 → 4',
      '2 → 1 → 3 → 5 → 4',
    ],
    correctAnswer: 1,
    explanation:
        'Task 5 (approval) comes first — building without alignment wastes '
        'everything else. Schema (2) before API (1) because the API depends '
        'on the data model. UI (3) depends on the API contract. Tests (4) '
        'verify the final implementation. Spotting dependencies before starting '
        'prevents expensive rework.',
    thinkingPattern: 'Dependency Ordering',
  ),

  Problem(
    id: 'pd-u1-q2',
    trackId: 'problem-decomposition',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'BREAKING IT DOWN',
    type: ProblemType.choice,
    prompt:
        'Two engineers disagree:\n\n'
        'Engineer A: "Finish the entire database layer, then the entire API '
        'layer, then the entire UI."\n\n'
        'Engineer B: "Build one thin slice end-to-end — one screen, one API, '
        'one table — then expand."\n\n'
        'You have a demo in 2 weeks and requirements might change. Which wins?',
    options: [
      'Engineer A — clean separation, easier to test each layer',
      'Engineer B — something working sooner means you can validate assumptions early',
      'Depends entirely on team size',
      'Both are equivalent with enough discipline',
    ],
    correctAnswer: 1,
    explanation:
        'With uncertain requirements and a deadline, vertical slices beat '
        'horizontal layers. Layers deliver nothing until all are complete. '
        'A slice gives you something real to show, test, and learn from fast. '
        'This is the "walking skeleton" pattern — validate before building '
        'everything.',
    thinkingPattern: 'Vertical Slicing',
  ),

  // ── Unit 2: Knowing When to Stop ───────────────────────────────────────────

  Problem(
    id: 'pd-u2-q0',
    trackId: 'problem-decomposition',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'KNOWING WHEN TO STOP',
    type: ProblemType.choice,
    prompt:
        'You are building search. Option A: 1 day, basic keyword matching '
        '(works 80% of the time). Option B: 3 weeks, semantic search '
        '(works 95% of the time).\n\n'
        'You have 500 users and launch is next week. What do you build?',
    options: [
      'Semantic search — do it right the first time',
      'Basic keyword matching — ship it, improve based on real feedback',
      'Nothing — search can wait',
      'Basic search but document the technical debt carefully',
    ],
    correctAnswer: 1,
    explanation:
        'The 15% improvement costs 15x more time. With 500 pre-launch users, '
        'you do not even know if search matters to them yet. Ship the 80% '
        'solution, watch how people use it, then decide if the extra 15% is '
        'worth 3 weeks. "Good enough to learn" beats "perfect but late."',
    thinkingPattern: '80/20 Rule (Pareto)',
  ),

  Problem(
    id: 'pd-u2-q1',
    trackId: 'problem-decomposition',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'KNOWING WHEN TO STOP',
    type: ProblemType.choice,
    prompt:
        'A junior engineer builds a payment feature that only needs Stripe today. '
        'They spend a week building a "universal payment abstraction layer" '
        'to support any provider in the future.\n\n'
        'Three months later: the team still only uses Stripe. What went wrong?',
    options: [
      'Nothing — abstractions are always good engineering',
      'They solved a problem that did not exist yet, at the cost of current speed',
      'They should have used a different abstraction pattern',
      'The abstraction layer was probably poorly designed',
    ],
    correctAnswer: 1,
    explanation:
        "YAGNI — You Aren't Gonna Need It. Building for hypothetical futures "
        'delays real work and often produces the wrong abstraction anyway — '
        'you do not know the shape of future requirements until they arrive. '
        'The right time to abstract is when you have the second concrete use '
        'case, not before.',
    thinkingPattern: 'YAGNI',
  ),

  Problem(
    id: 'pd-u2-q2',
    trackId: 'problem-decomposition',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'KNOWING WHEN TO STOP',
    type: ProblemType.choice,
    prompt:
        'Planning a 3-month project. One engineer wants to spec every API '
        'endpoint, every database column, and every edge case before writing '
        'a line of code. Another wants to start Monday with just high-level goals.\n\n'
        'What is the right level of planning detail?',
    options: [
      'Full spec — ambiguity is the enemy of execution',
      'High-level goals only — details will emerge',
      'Enough detail to start confidently, with checkpoints to re-plan as you learn',
      'Depends on whether the team has worked together before',
    ],
    correctAnswer: 2,
    explanation:
        'Over-planning wastes time on details that will change. Under-planning '
        'causes thrash. The right answer is "just enough" — clear goals, rough '
        'task breakdown, known dependencies, explicit unknowns. Then re-plan '
        'at milestones as reality updates your map. Planning is valuable; '
        'the plan is not.',
    thinkingPattern: 'Adaptive Planning',
  ),

  // ── Unit 3: Constraints as Clarity ─────────────────────────────────────────

  Problem(
    id: 'pd-u3-q0',
    trackId: 'problem-decomposition',
    unitIndex: 3,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'CONSTRAINTS AS CLARITY',
    type: ProblemType.choice,
    prompt:
        'A client says: "Build us the best possible e-commerce site. '
        r'Budget: $10,000." You could build a full custom platform, or use '
        'Shopify and spend the budget on design and marketing.\n\n'
        'What should you do first?',
    options: [
      'Start building the custom platform — it will be more flexible',
      'Clarify what "best possible" means to the client',
      'Recommend Shopify immediately',
      'Ask for a bigger budget',
    ],
    correctAnswer: 1,
    explanation:
        '"Best possible" is undefined. Best at what — conversion rate, brand '
        'impression, ease of management? The budget is a constraint, and '
        'constraints are useful: they force you to clarify what actually '
        'matters. A constraint answered for the wrong question is still '
        'the wrong answer.',
    thinkingPattern: 'Constraint-Driven Clarity',
  ),

  Problem(
    id: 'pd-u3-q1',
    trackId: 'problem-decomposition',
    unitIndex: 3,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'CONSTRAINTS AS CLARITY',
    type: ProblemType.choice,
    prompt:
        'Your manager says: "We need this feature in 2 weeks." '
        'You estimate 4 weeks of work.\n\n'
        'What is the most useful response?',
    options: [
      'Say yes and work overtime',
      'Say no — it is impossible',
      'Ask what is driving the 2-week deadline, then show what is achievable in that time',
      'Reduce quality to fit the timeline',
    ],
    correctAnswer: 2,
    explanation:
        'Deadlines often have specific drivers — a conference, a client demo, '
        'a regulatory date. Understanding the driver tells you which parts '
        'truly need to ship in 2 weeks. Maybe 60% of the feature covers the '
        'demo. Negotiating scope rather than timeline is the professional '
        'response.',
    thinkingPattern: 'Constraint Source Analysis',
  ),

  Problem(
    id: 'pd-u3-q2',
    trackId: 'problem-decomposition',
    unitIndex: 3,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'CONSTRAINTS AS CLARITY',
    type: ProblemType.choice,
    prompt:
        'A team has built mobile-only for 2 years because "the CEO said we are '
        'mobile-first." A competitor launches a web app and takes market share.\n\n'
        'When you dig in, the original constraint came from a 2015 email about '
        'priorities — not a permanent decision. What is the lesson?',
    options: [
      'Always document decisions so they are not misinterpreted',
      'Constraints should be revisited regularly — they expire',
      'The CEO should communicate better',
      'Both A and B',
    ],
    correctAnswer: 3,
    explanation:
        'Constraints expire. Business context changes. What was true in 2015 '
        'may not be true now. Good teams document why a constraint exists '
        '(not just what it is) and revisit constraints at regular intervals. '
        '"We have always done it this way" is the most expensive constraint '
        'in any organisation.',
    thinkingPattern: 'Constraint Expiry',
  ),

// ─── Problems — Track 2: Systems Thinking ────────────────────────────────────

  // ── Unit 0: Feedback Loops ──────────────────────────────────────────────────

  Problem(
    id: 'st-u0-q0',
    trackId: 'systems-thinking',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'FEEDBACK LOOPS',
    type: ProblemType.choice,
    prompt:
        'A new social app launches. Users post, get likes, feel good, post more. '
        'The algorithm shows popular posts to more people, who like them, making '
        'those posts even more popular.\n\n'
        'Six months later: 10% of users generate 90% of the content.\n\n'
        'What is driving this?',
    options: [
      'The app has great retention features',
      'A reinforcing feedback loop — success breeds more success',
      'Most users are lazy',
      'The algorithm is broken',
    ],
    correctAnswer: 1,
    explanation:
        'This is a reinforcing feedback loop. Likes → more posting → more likes '
        '→ even more posting. Each cycle amplifies the last. These loops are '
        'everywhere: interest compounds in savings accounts, word-of-mouth grows '
        'products, bugs multiply in bad codebases. Recognising the loop is the '
        'first step to working with — or against — it.',
    thinkingPattern: 'Reinforcing Feedback Loop',
  ),

  Problem(
    id: 'st-u0-q1',
    trackId: 'systems-thinking',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'FEEDBACK LOOPS',
    type: ProblemType.choice,
    prompt:
        'A startup is growing fast. Every month the team doubles to keep up with '
        'demand. But as the team grows, coordination gets harder, velocity slows, '
        'and customers start complaining about quality.\n\n'
        'Which type of feedback loop is limiting growth?',
    options: [
      'A reinforcing loop — growth causes more growth',
      'A balancing loop — the system is self-correcting toward a limit',
      'There is no feedback loop — it is just bad management',
      'A time-delay loop — the effects have not shown up yet',
    ],
    correctAnswer: 1,
    explanation:
        'This is a balancing loop. Growth → coordination cost → slower delivery '
        '→ unhappy customers → pressure to fix quality → slower hiring → limited '
        'growth. Balancing loops pull systems toward equilibrium. The system is '
        'not broken — it is self-limiting. Understanding which loop you are in '
        'tells you what to do: reinforce it or find and address the constraint.',
    thinkingPattern: 'Balancing Feedback Loop',
  ),

  Problem(
    id: 'st-u0-q2',
    trackId: 'systems-thinking',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'FEEDBACK LOOPS',
    type: ProblemType.choice,
    prompt:
        'An e-commerce warehouse tripled its picking speed with better tooling. '
        'But overall order delivery time did not improve — it got slightly worse.\n\n'
        'What most likely happened?',
    options: [
      'The tooling was implemented incorrectly',
      'Picking was not the bottleneck — now a different stage is overwhelmed',
      'Workers slowed down elsewhere to compensate',
      'The improvement was measured incorrectly',
    ],
    correctAnswer: 1,
    explanation:
        'Optimising a non-bottleneck does not help the system. If packing or '
        'shipping was the constraint, tripling picking speed just creates a '
        'pile-up before the next stage. The system moves at the speed of its '
        'slowest part. Optimising anywhere else just moves inventory around. '
        'Always find the bottleneck before optimising anything.',
    thinkingPattern: 'Local vs Global Optimisation',
  ),

  // ── Unit 1: Second-Order Effects ────────────────────────────────────────────

  Problem(
    id: 'st-u1-q0',
    trackId: 'systems-thinking',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'SECOND-ORDER EFFECTS',
    type: ProblemType.choice,
    prompt:
        'In colonial India, the British government offered a bounty for every '
        'dead cobra to reduce the cobra population. The plan worked initially — '
        'thousands of cobras were turned in. Then the cobra population exploded.\n\n'
        'What happened?',
    options: [
      'Cobras developed resistance to traps',
      'Bounty hunters started breeding cobras to collect more rewards',
      'The government ran out of money for bounties',
      'Cobras migrated from other regions',
    ],
    correctAnswer: 1,
    explanation:
        'This is the Cobra Effect — a solution that makes the problem worse. '
        'Incentivise killing cobras, and rational actors breed cobras. When the '
        'bounty was cancelled, breeders released worthless cobras. The intervention '
        'created its own demand. Every incentive system has second-order effects. '
        'Ask: what behaviour does this actually reward?',
    thinkingPattern: 'Incentive Second-Order Effect',
  ),

  Problem(
    id: 'st-u1-q1',
    trackId: 'systems-thinking',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'SECOND-ORDER EFFECTS',
    type: ProblemType.choice,
    prompt:
        'A team launches a "Share your result" button. Engagement goes up 40%. '
        'Two months later: support tickets double, trust scores drop, and two '
        'enterprise clients threaten to cancel.\n\n'
        'What likely happened?',
    options: [
      'The feature had a technical bug',
      'Sharing surfaced results users did not anticipate being made public',
      'Competitors copied the feature and undercut them',
      'The engagement metrics were tracked incorrectly',
    ],
    correctAnswer: 1,
    explanation:
        'Engagement went up because sharing is engaging. But the second-order '
        'effect — what happens after things are shared — was not considered. '
        'Privacy violations, out-of-context results, or exposed data created '
        'downstream damage. Features often have great first-order effects and '
        'costly second-order ones. Ask "and then what?" before shipping.',
    thinkingPattern: 'Second-Order Consequence',
  ),

  Problem(
    id: 'st-u1-q2',
    trackId: 'systems-thinking',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'SECOND-ORDER EFFECTS',
    type: ProblemType.choice,
    prompt:
        'A company struggled with slow code reviews. Fix: hire 10 more engineers. '
        'After 6 months, reviews are still slow. Communication overhead has '
        'tripled. Their best engineers now spend half their time in meetings.\n\n'
        'What went wrong?',
    options: [
      'They hired the wrong engineers',
      'Adding people to a communication-heavy problem makes it worse, not better',
      'The engineering manager failed to delegate',
      'Remote work caused the coordination issues',
    ],
    correctAnswer: 1,
    explanation:
        "Adding people to a late software project makes it later — Brooks' Law. "
        'More people means more communication channels (grows as n squared). '
        'If the bottleneck is review quality or unclear standards, headcount '
        'does not fix it. The second-order effect of hiring is coordination cost. '
        'The right fix was to improve the process, not expand the team.',
    thinkingPattern: "Brooks' Law / Adding Resources",
  ),

  // ── Unit 2: Bottlenecks ─────────────────────────────────────────────────────

  Problem(
    id: 'st-u2-q0',
    trackId: 'systems-thinking',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'BOTTLENECKS',
    type: ProblemType.choice,
    prompt:
        "A team's software release takes 3 days:\n"
        '- Code to Review: 4 hours\n'
        '- Review to QA: 6 hours\n'
        '- QA to Staging: 2 hours\n'
        '- Staging to Production: 1 hour\n\n'
        'They want to cut release time in half. Which stage should they focus on first?',
    options: [
      'Code to Review — it is the first step',
      'Staging to Production — it is fully automatable',
      'Review to QA — it is the longest wait',
      'All stages equally',
    ],
    correctAnswer: 2,
    explanation:
        'The bottleneck is the longest wait: Review to QA at 6 hours. Cutting '
        'any other stage barely moves the total. Halving the 1-hour staging '
        'step saves 30 minutes. Halving the 6-hour QA wait saves 3 hours. '
        'Fix the biggest constraint first — everything else is noise until '
        'the bottleneck is addressed.',
    thinkingPattern: 'Theory of Constraints',
  ),

  Problem(
    id: 'st-u2-q1',
    trackId: 'systems-thinking',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'BOTTLENECKS',
    type: ProblemType.choice,
    prompt:
        'A checkout process has two steps: payment processing (1 second) and '
        'fraud detection (8 seconds). The team optimises payment processing '
        'down to 0.1 seconds.\n\n'
        'How much faster is the checkout experience?',
    options: [
      'About 10x faster — from 9s to 0.9s',
      'About 1 second faster — from 9s to 8.1s',
      'No change — fraud detection is still 8 seconds',
      'It depends on the server hardware',
    ],
    correctAnswer: 1,
    explanation:
        'Checkout was 9 seconds (1 + 8). Optimising payment to 0.1 seconds '
        'gives 8.1 seconds total — a 0.9-second saving, not 10x. The bottleneck '
        'is fraud detection. This is why optimising non-bottlenecks has '
        'near-zero impact on the system. Before celebrating an improvement, '
        'ask: does it actually improve the end-to-end result?',
    thinkingPattern: 'Bottleneck-Constrained Throughput',
  ),

  Problem(
    id: 'st-u2-q2',
    trackId: 'systems-thinking',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'BOTTLENECKS',
    type: ProblemType.choice,
    prompt:
        'A factory: cut (5 min/unit), assemble (10 min/unit), pack (3 min/unit).\n'
        'Hourly capacity: cut = 12 units, assemble = 6 units, pack = 20 units.\n\n'
        'They add a second assembly line, doubling assembly to 12 units/hour.\n\n'
        'What happens to total system output?',
    options: [
      'Output doubles — assembly was the bottleneck',
      'Output stays at 12 per hour — cut is now the binding constraint',
      'Output increases then plateaus as pack becomes the limit',
      'Output doubles then drops due to coordination overhead',
    ],
    correctAnswer: 1,
    explanation:
        'Assembly was the bottleneck at 6/hr. A second line raises it to 12/hr '
        '— now matching cut exactly. The system ceiling is 12/hr, but cut is '
        'the new constraint. The bottleneck shifted. Fixing one bottleneck '
        'always reveals the next. Systems thinking means planning for the '
        'cascade, not just the first fix.',
    thinkingPattern: 'Bottleneck Cascade',
  ),

  // ── Unit 3: Emergence ───────────────────────────────────────────────────────

  Problem(
    id: 'st-u3-q0',
    trackId: 'systems-thinking',
    unitIndex: 3,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'EMERGENCE',
    type: ProblemType.choice,
    prompt:
        'You hire two senior engineers who each produced 20 features per month '
        'individually. After joining your team, they produce 28 combined — not 40.\n\n'
        'What is most likely happening?',
    options: [
      'They are not working as hard',
      'Collaboration overhead — meetings, reviews, context-switching — reduces individual output',
      'Your codebase is too complex for them',
      'The features they are working on are harder than before',
    ],
    correctAnswer: 1,
    explanation:
        'Two people working together rarely produce 2x output. Collaboration '
        'has overhead: meetings, reviews, resolving conflicts, context-sharing. '
        'This is not failure — it is an emergent system property. Team output '
        'is not a sum of individuals. Good teams design for this: fewer '
        'unnecessary meetings, clear ownership, async communication.',
    thinkingPattern: 'Emergent System Property',
  ),

  Problem(
    id: 'st-u3-q1',
    trackId: 'systems-thinking',
    unitIndex: 3,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'EMERGENCE',
    type: ProblemType.choice,
    prompt:
        'A highway has no accidents, no construction, no bad weather. '
        'Yet traffic jams appear and disappear every day at the same spot.\n\n'
        'What causes them?',
    options: [
      'There is a hidden obstruction the data is not capturing',
      'Small variations in individual driver behaviour compound into system-wide slowdowns',
      'The road was poorly designed for that volume',
      'Rush hour demand exceeds the road capacity at that point',
    ],
    correctAnswer: 1,
    explanation:
        'Phantom traffic jams emerge from individual behaviour: one driver '
        'brakes slightly, the car behind overcompensates, the next brakes '
        'harder. This ripple amplifies backward into a jam with no single cause. '
        'This is emergence — complex system behaviour from simple local '
        'interactions. It explains why adding lanes often fails to fix '
        'congestion, and why small delays cascade in distributed systems.',
    thinkingPattern: 'Emergent Behaviour',
  ),

  Problem(
    id: 'st-u3-q2',
    trackId: 'systems-thinking',
    unitIndex: 3,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'EMERGENCE',
    type: ProblemType.choice,
    prompt:
        'Wikipedia has millions of high-quality articles maintained by volunteers '
        'with no salaries, no formal roles, and no direct oversight of most edits.\n\n'
        'What is the key to this working?',
    options: [
      'Volunteers are inherently more motivated than employees',
      'Simple rules were designed so that good behaviour emerges at scale',
      'Wikipedia got lucky with its early community',
      'Quality is enforced by a large hidden moderation team',
    ],
    correctAnswer: 1,
    explanation:
        'Wikipedia designed for emergence. Simple rules — anyone can edit, '
        'edits are logged and reversible, neutrality policy, talk pages for '
        'disputes — create conditions where good outcomes emerge without central '
        'enforcement. This is designed emergence: instead of policing behaviour '
        'directly, design the environment so good behaviour becomes the natural '
        'result. Open source, peer review, and free markets work the same way.',
    thinkingPattern: 'Designed Emergence',
  ),

// ─── Problems — Track 3: Mental Models ───────────────────────────────────────

  // ── Unit 0: First Principles Thinking ──────────────────────────────────────

  Problem(
    id: 'mm-u0-q0',
    trackId: 'mental-models',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'FIRST PRINCIPLES THINKING',
    type: ProblemType.choice,
    prompt:
        r'A restaurant owner buys tomato sauce from a supplier for $250/week. '
        r'The same sauce costs $4/jar at the supermarket — $200/week at his volume. '
        'He calls the supplier to negotiate. They will not budge.\n\n'
        'What is the first principles approach?',
    options: [
      r'Make the sauce from scratch — raw ingredients cost about $80 per week',
      'Find a different supplier who charges less',
      'Switch to menu items that do not need tomato sauce',
      'Accept the cost and raise menu prices',
    ],
    correctAnswer: 0,
    explanation:
        'First principles means breaking a problem down to its fundamental truths '
        r'and rebuilding from there. Instead of accepting "sauce costs $X from a '
        'supplier," ask: what is sauce actually made of, and what do those '
        r'ingredients cost? The gap between $80 (ingredients) and $250 (supplier) '
        'is integration and markup — both reducible. The question is not "who '
        'sells it cheapest?" but "what is it actually made of?"',
    thinkingPattern: 'First Principles Decomposition',
  ),

  Problem(
    id: 'mm-u0-q1',
    trackId: 'mental-models',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'FIRST PRINCIPLES THINKING',
    type: ProblemType.choice,
    prompt:
        r'In 2012, the received wisdom was that battery packs cost $600/kWh '
        'and always would. Everyone accepted this — car makers, analysts, investors.\n\n'
        'What is the first principles question that breaks this assumption?',
    options: [
      'Can we find a cheaper battery supplier?',
      'Can we design a vehicle that uses less battery?',
      'What are the raw materials in a battery and what do they cost on commodities markets?',
      'Can government subsidies offset the battery cost?',
    ],
    correctAnswer: 2,
    explanation:
        'The first principles question is not "who sells batteries cheapest?" — '
        'that still accepts the market structure as fixed. The real question: '
        'what is a battery, fundamentally? Carbon, nickel, aluminium, polymer. '
        r'What do those materials cost at commodity prices? About $80/kWh in 2012. '
        r'The gap between $80 and $600 was manufacturing overhead and market '
        'markup — both reducible. The constraint was assumption, not physics.',

    thinkingPattern: 'Assumption Stripping',
  ),

  Problem(
    id: 'mm-u0-q2',
    trackId: 'mental-models',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'FIRST PRINCIPLES THINKING',
    type: ProblemType.choice,
    prompt:
        'A junior engineer is asked to add a date picker to a form. Instead of '
        'using the standard library component, they build one from first '
        'principles to "really understand how dates work." It takes 3 weeks. '
        'The library component would have taken 1 hour.\n\n'
        'What went wrong?',
    options: [
      'The engineer lacked knowledge of the standard library',
      'First principles thinking was applied to a solved problem — it should be reserved for genuine constraints',
      'The manager should have specified the required approach upfront',
      'Building from scratch is always wrong in software',
    ],
    correctAnswer: 1,
    explanation:
        'First principles thinking has a real cost: time. It is powerful when '
        'facing a genuine constraint — an unacceptable price, a physical '
        'limitation, a broken market assumption. But when a good-enough solution '
        'already exists, rebuilding it creates no new value. The skill is knowing '
        'when to apply it: use first principles when the existing solution is '
        'wrong or unacceptably limited. Otherwise, stand on shoulders.',
    thinkingPattern: 'Judicious Use of First Principles',
  ),

  // ── Unit 1: Inversion ───────────────────────────────────────────────────────

  Problem(
    id: 'mm-u1-q0',
    trackId: 'mental-models',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'INVERSION',
    type: ProblemType.choice,
    prompt:
        'A startup wants to build a habit-forming app. The team asks: '
        '"How do we make users come back every day?"\n\n'
        'What question would inversion produce?',
    options: [
      'How do we make users come back every week instead of every day?',
      'What would guarantee that users never come back?',
      'What do our most retained users have in common?',
      'How did Duolingo solve this problem?',
    ],
    correctAnswer: 1,
    explanation:
        'Inversion flips the question. Instead of "how do we succeed?" ask '
        '"what would guarantee failure?" Users never return if: the app is slow, '
        'notifications are annoying, value is unclear on first use, they feel '
        'stupid, progress is invisible. Now you have a concrete list of things '
        'to avoid. Avoiding failure is often clearer and more actionable than '
        'chasing success — because failures are specific and success is vague.',
    thinkingPattern: 'Inversion',
  ),

  Problem(
    id: 'mm-u1-q1',
    trackId: 'mental-models',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'INVERSION',
    type: ProblemType.choice,
    prompt:
        'A team is about to launch a major feature. Their PM says: "Imagine it '
        'is 6 months from now and the feature completely failed. What happened?"\n\n'
        'Why is this more useful than asking "how do we make this succeed?"',
    options: [
      'It is a more engaging exercise for the team',
      'It prepares the team emotionally for the possibility of failure',
      'It surfaces specific failure modes that optimism bias would hide in normal planning',
      'It helps identify who to hold accountable if the launch fails',
    ],
    correctAnswer: 2,
    explanation:
        'Forward planning is contaminated by optimism bias — we imagine the path '
        'where things work. A pre-mortem inverts the question: assume it failed, '
        'now explain why. This forces the brain to generate specific, concrete '
        'problems rather than vague risks. Teams that run pre-mortems consistently '
        'find overlooked issues: a dependency nobody owns, an untested assumption, '
        'a competitor move nobody raised. Inversion bypasses the optimism filter.',
    thinkingPattern: 'Pre-Mortem / Inversion',
  ),

  Problem(
    id: 'mm-u1-q2',
    trackId: 'mental-models',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'INVERSION',
    type: ProblemType.choice,
    prompt:
        'A payments team is designing a new checkout flow. They could ask:\n'
        'X: "How do we make this excellent?"\n'
        'Y: "What would make this terrible?"\n\n'
        'Which leads to a better final design?',
    options: [
      'X — positive framing generates more creative ideas',
      'Both are equivalent — output depends on team quality, not the question',
      'Neither — study competitor checkouts instead',
      'Y — each failure mode becomes a concrete design requirement',
    ],
    correctAnswer: 3,
    explanation:
        '"Make it excellent" produces wish lists. "Make it terrible" produces '
        'constraints: it fails if it is slow, if error messages are confusing, '
        'if payment data feels insecure, if there are too many steps, if edge '
        'cases are unhandled. Avoiding each failure is a specific, testable '
        'design obligation. Inversion converts vague ambition into concrete '
        'requirements. The checklist is more actionable than a vision statement.',
    thinkingPattern: 'Inversion as Design Tool',
  ),

  // ── Unit 2: Occam's Razor ───────────────────────────────────────────────────

  Problem(
    id: 'mm-u2-q0',
    trackId: 'mental-models',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: "OCCAM'S RAZOR",
    type: ProblemType.choice,
    prompt:
        'A web app stops working for some users on Monday morning.\n'
        'Theory A: A deploy on Friday introduced a bug.\n'
        'Theory B: A cosmic ray flipped a bit in the server, causing memory '
        'corruption that only affects users on certain ISPs.\n\n'
        'Which should you investigate first?',
    options: [
      'Theory A — the Friday deploy is the simplest explanation consistent with the facts',
      'Theory B — it is more specific and accounts for all the details',
      'Both simultaneously — it is Monday morning and speed matters',
      'Neither — restart the server first and see if it resolves',
    ],
    correctAnswer: 0,
    explanation:
        "Occam's Razor: among competing explanations, prefer the simplest one "
        'consistent with the evidence. A Friday deploy is a common, high-probability '
        'cause of Monday bugs. Cosmic ray bit-flips do occur but are extremely '
        'rare. Start with the highest-probability, lowest-complexity explanation. '
        'Escalate to exotic theories only after the simple ones are eliminated. '
        'Most bugs are boring — and that is useful information.',
    thinkingPattern: "Occam's Razor",
  ),

  Problem(
    id: 'mm-u2-q1',
    trackId: 'mental-models',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: "OCCAM'S RAZOR",
    type: ProblemType.choice,
    prompt:
        'An analytics dashboard shows a 40% drop in daily active users over two days.\n'
        'Three theories:\n'
        '- Theory A: A recent UI change confused users\n'
        '- Theory B: A major competitor launched and users churned\n'
        '- Theory C: A tracking bug is under-counting users\n\n'
        'What should happen first?',
    options: [
      'Run a user survey to understand what changed for them',
      'Immediately roll back the UI change',
      'Investigate the competitor launch',
      'Check whether the tracking code is working correctly before concluding users actually left',
    ],
    correctAnswer: 3,
    explanation:
        'Before assuming a real change in user behaviour, verify the measurement '
        'itself. A 40% drop overnight is dramatic enough to suspect instrumentation '
        'first. If a tracking pixel broke, a database migration dropped events, '
        'or a deploy changed event naming, the drop is not real. The simplest '
        'explanation is broken tracking — not a mass user exodus or sudden '
        'competitive threat. Measure before you explain.',
    thinkingPattern: 'Measurement Before Explanation',
  ),

  Problem(
    id: 'mm-u2-q2',
    trackId: 'mental-models',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: "OCCAM'S RAZOR",
    type: ProblemType.choice,
    prompt:
        'A doctor sees a patient with fatigue, joint pain, and a rash.\n'
        'Simple diagnosis: flu with skin reaction (fits 80% of similar cases).\n'
        'Complex diagnosis: lupus (rare, but fits the same symptoms and '
        'requires urgent treatment if correct).\n\n'
        "When is Occam's Razor the wrong tool?",
    options: [
      "Occam's Razor is never the wrong tool — always start with the simplest explanation",
      'When the doctor has fewer than 10 years of experience',
      'When the patient insists on a thorough investigation',
      'When the stakes of a wrong diagnosis are high and the conditions have very different treatment paths',
    ],
    correctAnswer: 3,
    explanation:
        "Occam's Razor is a heuristic for directing effort, not a rule for "
        'stopping investigation. When the cost of a missed complex diagnosis '
        'is high — lupus untreated causes permanent organ damage — the stakes '
        'override the prior probability. In software, a "simple" root cause '
        'might satisfy a P1 review while leaving a latent architectural flaw '
        'undiscovered. Use it to decide where to look first; not when to stop.',
    thinkingPattern: "Limits of Occam's Razor",
  ),

  // ── Unit 3: Map vs Territory ────────────────────────────────────────────────

  Problem(
    id: 'mm-u3-q0',
    trackId: 'mental-models',
    unitIndex: 3,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'MAP VS TERRITORY',
    type: ProblemType.choice,
    prompt:
        'A new engineer joins a company. The org chart shows clear reporting lines. '
        'But when she needs an engineering tooling decision, she discovers it goes '
        'through a senior IC in a different team — they wrote the original '
        'infrastructure and everyone defers to them informally.\n\n'
        'What does this illustrate?',
    options: [
      'The org chart is wrong and should be updated immediately',
      'Informal authority is always more reliable than formal authority',
      'The org chart (map) does not reflect how decisions actually get made (territory)',
      'The company has poor governance structure',
    ],
    correctAnswer: 2,
    explanation:
        'The org chart is a map — a simplified model of reality. The territory '
        'is how the organisation actually functions: who has credibility, who '
        'controls key decisions, who gets consulted informally. Every organisation '
        'has both. Confusing the map for the territory leads to wasted time '
        'escalating through official channels that do not reflect real power. '
        'Learn the territory early; do not assume the map is accurate.',
    thinkingPattern: 'Map vs Territory',
  ),

  Problem(
    id: 'mm-u3-q1',
    trackId: 'mental-models',
    unitIndex: 3,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'MAP VS TERRITORY',
    type: ProblemType.choice,
    prompt:
        'A team measures velocity at 40 story points per sprint and uses this '
        'to plan the next 6 months. At month 3, they are 8 weeks behind.\n\n'
        'What most likely went wrong?',
    options: [
      'The team was not working hard enough',
      'Story point estimation is inherently unreliable and should be abandoned',
      'Six-month plans are always wrong regardless of measurement method',
      'Velocity is a lagging average that does not account for future complexity, new dependencies, or interruptions',
    ],
    correctAnswer: 3,
    explanation:
        'Velocity is a map of past performance — a lagging average. It measures '
        'what happened, not what will happen. The territory (future work) contains '
        'things the map cannot see: new dependencies, team changes, technical '
        'debt that slows future sprints, expanding requirements, incidents. '
        'Treating the velocity map as the territory produces precise-but-wrong '
        'plans. Maps are useful for navigation; they break down when mistaken '
        'for the thing they represent.',
    thinkingPattern: 'Map as Lagging Indicator',
  ),

  Problem(
    id: 'mm-u3-q2',
    trackId: 'mental-models',
    unitIndex: 3,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'MAP VS TERRITORY',
    type: ProblemType.choice,
    prompt:
        'A team designs a carefully normalised database schema that accurately '
        'models their domain. Six months later, their most common query takes '
        '4 seconds — because it requires 7 joins across normalised tables.\n\n'
        'What does this reveal?',
    options: [
      'The schema was poorly designed from the start',
      'The domain model (map) was correct in theory but the query access patterns (territory) demanded a different structure',
      'Normalisation is outdated — always use NoSQL for performance-critical applications',
      'The team should have used an ORM to hide the complexity of joins',
    ],
    correctAnswer: 1,
    explanation:
        'The schema was an accurate map of the domain — entities, relationships, '
        'constraints all correctly modelled. But the territory it needed to serve '
        'was query performance under real load. The map optimised for conceptual '
        'clarity; the territory required read performance. This is the core '
        'tension: the map most faithful to abstract reality is often least '
        'faithful to operational reality. Good engineers hold both and choose '
        'the trade-off explicitly.',
    thinkingPattern: 'Model-Reality Gap',
  ),

  // ── Unit 4: Second-Order Thinking ───────────────────────────────────────────

  Problem(
    id: 'mm-u4-q0',
    trackId: 'mental-models',
    unitIndex: 4,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'SECOND-ORDER THINKING',
    type: ProblemType.choice,
    prompt:
        'A city bans cars from the city centre to reduce pollution and congestion.\n'
        'First-order effect: less traffic and cleaner air in the centre.\n\n'
        'What is the most likely second-order effect?',
    options: [
      'People stop driving entirely and switch to public transport',
      'City centre businesses thrive due to the pedestrian-friendly environment',
      'Traffic shifts to surrounding roads, increasing congestion and pollution in residential areas',
      'Property values in the city centre fall due to reduced accessibility',
    ],
    correctAnswer: 2,
    explanation:
        'The first-order effect is what the policy intends. The second-order '
        'effect is what happens as the system adjusts. Drivers do not disappear '
        '— they reroute. The pollution and congestion move rather than decrease. '
        '"And then what?" is the key question after any intervention. What does '
        'the system do in response to the change? Tracing consequences one step '
        'beyond the intended outcome is the core of second-order thinking.',
    thinkingPattern: 'Second-Order Thinking',
  ),

  Problem(
    id: 'mm-u4-q1',
    trackId: 'mental-models',
    unitIndex: 4,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'SECOND-ORDER THINKING',
    type: ProblemType.choice,
    prompt:
        'A company gives everyone a 20% salary raise to improve retention.\n'
        'First-order effect: employees feel valued.\n'
        'Six months later: a competitor matches the raise, and the company '
        'freezes hiring to cover costs.\n\n'
        'What second-order effect was missed?',
    options: [
      'Competitors would match the raise, erasing the retention advantage, while the permanent cost increase would constrain hiring and other investments',
      'Employees would expect another raise the following year',
      'The company would need to raise product prices to cover payroll',
      'High performers would leave anyway because they wanted more than 20%',
    ],
    correctAnswer: 0,
    explanation:
        'The raise becomes a permanent cost. Competitors observe and respond, '
        'eroding the retention differential quickly. Meanwhile, increased payroll '
        'constrains hiring — which creates overwork, which drives the very '
        'attrition the raise was meant to prevent. Second-order thinking means '
        'asking: how does the system — competitors, costs, employee expectations '
        '— respond to this action over time? The first-order effect was real; '
        'the second-order effects undid it.',
    thinkingPattern: 'Competitive Second-Order Effect',
  ),

  Problem(
    id: 'mm-u4-q2',
    trackId: 'mental-models',
    unitIndex: 4,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'SECOND-ORDER THINKING',
    type: ProblemType.choice,
    prompt:
        'A SaaS company is behind on growth targets. Leadership offers 50% '
        'discounts to close deals quickly and hit Q4 numbers.\n\n'
        'What second-order effects should concern them most?',
    options: [
      'Customers might assume the product is worth less than its original price',
      'The sales team will expect high commission rates on discounted deals',
      'The product roadmap will need to slow to fund the discount programme',
      'Discounted customers churn at higher rates, have lower lifetime value, and establish a precedent that makes full-price deals harder in future',
    ],
    correctAnswer: 3,
    explanation:
        'Discounting to hit short-term numbers creates compounding second-order '
        'effects: price anchoring (customers expect discounts permanently), '
        'adverse selection (price-sensitive customers churn faster), sales '
        'process change (reps learn to offer discounts to close any deal), and '
        'competitive signalling (a struggling company discounting 50% is visible '
        'to rivals). The short-term revenue hit is real; the long-term structural '
        'damage is larger. Second-order thinking asks: what kind of customers '
        'and habits does this policy create 12 months from now?',
    thinkingPattern: 'Short-Term vs Long-Term Trade-off',
  ),

  // ────────────────────────────────────────────────────────────────────────────
  // TRACK 4: DECISION MAKING
  // ────────────────────────────────────────────────────────────────────────────

  // Unit 0: Reversible vs Irreversible

  Problem(
    id: 'dm-u0-q0',
    trackId: 'decision-making',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'REVERSIBLE VS IRREVERSIBLE',
    type: ProblemType.choice,
    prompt:
        'You are choosing where to host your app. Option A: AWS (easy to migrate away from). '
        'Option B: a custom datacenter (very expensive to move, tied to hardware contracts).\n\n'
        'Which framework should guide this decision?',
    options: [
      'Whichever is cheaper right now',
      'Whichever has the best features today',
      'Reversible decisions can be made with less analysis; irreversible ones need more',
      'They are equally important — just flip a coin',
    ],
    correctAnswer: 2,
    explanation:
        'Jeff Bezos calls this the two-way door vs one-way door decision. A reversible decision '
        '(AWS) can be revisited later if it is wrong. An irreversible one (custom datacenter contract) '
        'locks you in. Reversible decisions deserve 80% less analysis — make them fast. Irreversible '
        'ones deserve rigorous debate. Most teams reverse this and agonize over reversible choices.',
    thinkingPattern: 'Decision Reversibility Framework',
  ),

  Problem(
    id: 'dm-u0-q1',
    trackId: 'decision-making',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'REVERSIBLE VS IRREVERSIBLE',
    type: ProblemType.choice,
    prompt:
        'You are launching a feature, but you are not sure if users want it. You could:\n'
        'A) Run an A/B test (easy to kill the feature if it flops) — takes 2 weeks\n'
        'B) Spend a month refining it first, then launch to everyone\n'
        'C) Ask customers upfront (they do not know what they want until they try it)\n'
        'D) Launch to 10% of users, ready to kill it based on real usage\n\n'
        'What is the best decision-making approach here?',
    options: [
      'A',
      'B',
      'C',
      'D',
    ],
    correctAnswer: 3,
    explanation:
        'You can launch to 10% fast (reversible), learn whether the feature works, then decide to expand or kill it. '
        'This is cheaper than either refining without evidence or running a formal test. The key insight: if a decision is reversible, '
        'you have an option to "gather data by doing it," which is often better than planning alone.',
    thinkingPattern: 'Reversible Decision (Two-Way Door)',
  ),

  Problem(
    id: 'dm-u0-q2',
    trackId: 'decision-making',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'REVERSIBLE VS IRREVERSIBLE',
    type: ProblemType.choice,
    prompt:
        'You are about to acquire another company. This looks irreversible: once you merge cultures, systems, and teams, '
        'you cannot "unmerge."\n\n'
        'But your CEO proposes: "Keep them operating as a separate unit for 12 months. Prove integration works before fully merging."\n\n'
        'What is she doing?',
    options: [
      'Wasting time with extra process',
      'Converting an irreversible decision into a reversible one via staged commitment',
      'Just delaying the inevitable',
      'Being too cautious',
    ],
    correctAnswer: 1,
    explanation:
        'By treating the merger as a reversible "trial period," she lowers the stakes of the big decision. '
        'Full integration is irreversible; trial integration is reversible. If it fails, you can still separate. '
        'This staged-commitment approach turns high-stakes decisions into low-stakes experiments.',
    thinkingPattern: 'Staged Commitment',
  ),

  // Unit 1: Deciding with Incomplete Information

  Problem(
    id: 'dm-u1-q0',
    trackId: 'decision-making',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'DECIDING WITH INCOMPLETE INFORMATION',
    type: ProblemType.choice,
    prompt:
        'You are hiring a senior engineer. You could interview this candidate now (decision in 1 week) '
        'or wait for 5 more candidates to interview (decision in 1 month).\n\n'
        'The role will be open for 3 more weeks either way.\n\n'
        'If you wait, what are you really trying to do?',
    options: [
      'Make a better decision',
      'Gather more information before deciding',
      'Reduce the risk of hiring the wrong person',
      'If the first candidate was great, they have taken another job by then',
    ],
    correctAnswer: 3,
    explanation:
        'The cost of waiting is not zero. Information has diminishing returns. The first candidate might be in the top 2%, '
        'and waiting costs you them. Ask: "How much better does my decision need to be to justify the delay?" If the added information '
        'only improves the decision by 5%, and you are giving up a 95th-percentile candidate, you are paying the wrong price.',
    thinkingPattern: 'Information Value vs Decision Cost',
  ),

  Problem(
    id: 'dm-u1-q1',
    trackId: 'decision-making',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'DECIDING WITH INCOMPLETE INFORMATION',
    type: ProblemType.choice,
    prompt:
        'Your product team wants to know: "Should we build for mobile or desktop first?"\n\n'
        'They propose a 4-week research project: surveys, focus groups, analytics deep-dives.\n\n'
        'You push back: "What is the minimum we need to know to decide?"\n\n'
        'What is the right answer?',
    options: [
      'At least 50% of our users are on mobile (or not)',
      'Mobile users are more engaged than desktop users',
      'One metric: which device produces more revenue right now?',
      'Just launch on both platforms and A/B test',
    ],
    correctAnswer: 2,
    explanation:
        'You do not need perfect information, just enough to decide better than a coin flip. "Which device made more money last month?" '
        'is a single number that beats 4 weeks of research. If the answer is ambiguous (45% mobile, 55% desktop), then you add more data. '
        'But start with the simplest question that could change your mind.',
    thinkingPattern: 'Minimum Viable Information',
  ),

  Problem(
    id: 'dm-u1-q2',
    trackId: 'decision-making',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'DECIDING WITH INCOMPLETE INFORMATION',
    type: ProblemType.choice,
    prompt:
        'Scenario A: You are deploying new code. There is a 0.1% chance it breaks production, but you have stress-tested it thoroughly '
        '— you know the odds.\n\n'
        'Scenario B: You are entering a new market. You do not know the demand, the competition, the regulatory environment, or whether customers will adopt. '
        'These are not probabilities you can estimate.\n\n'
        'Which is riskier?',
    options: [
      'Scenario A — 0.1% is still a failure',
      'Scenario B — because you do not even know the odds',
      'They are equally risky',
      'Neither — risk and uncertainty are the same thing',
    ],
    correctAnswer: 1,
    explanation:
        'Risk has known odds (0.1% chance of breaking prod). Uncertainty has unknown odds (you do not know if the market exists). '
        'Uncertainty is scarier because you cannot compute expected value or plan for all failure modes. You handle them differently: '
        'risk you can insure/test; uncertainty you mitigate through small experiments and options.',
    thinkingPattern: 'Uncertainty vs Risk',
  ),

  // Unit 2: Trade-offs

  Problem(
    id: 'dm-u2-q0',
    trackId: 'decision-making',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'TRADE-OFFS',
    type: ProblemType.choice,
    prompt:
        'Two teams building the same feature.\n'
        'Team A: ships in 2 weeks with 10% bug rate\n'
        'Team B: ships in 6 weeks with 1% bug rate\n\n'
        'You have 100k users. In 6 months, which approach loses more money?',
    options: [
      'Team A — 10% bug rate is intolerable',
      'Team B — they lost 4 weeks of user growth and revenue',
      'It depends on the severity of the bugs',
      'Cannot compare without knowing what the feature is',
    ],
    correctAnswer: 2,
    explanation:
        'If the bugs are "search returns wrong results," Team A loses more (users go elsewhere). If the bugs are "button colour is wrong," '
        'Team B loses more (4 weeks of revenue > minor visual issues). Trade-offs are not universal. The context determines the answer: severity, '
        'user impact, and time value of the feature.',
    thinkingPattern: 'Context-Dependent Trade-offs',
  ),

  Problem(
    id: 'dm-u2-q1',
    trackId: 'decision-making',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'TRADE-OFFS',
    type: ProblemType.choice,
    prompt:
        'You are building a payment system. Option A: monolithic, simple to deploy, but one payment bug breaks everything. '
        'Option B: microservices, isolated payment logic, but complex to debug and 3× the DevOps overhead.\n\n'
        'What is the hidden cost you must account for?',
    options: [
      'Microservices are always better',
      'Monoliths are simpler, so always prefer them',
      'The cost of your mistakes in each architecture (one coin-flip error costs very different amounts in each)',
      'Deployment speed',
    ],
    correctAnswer: 2,
    explanation:
        'Every architecture choice has a cost function. In a monolith, a simple mistake cascades. In microservices, the same mistake is isolated, '
        'but debugging takes longer. You are not choosing "simple vs reliable" — you are choosing "which types of failures can you afford?" '
        'Choose based on your error tolerance and the cost of recovery, not on abstract principles.',
    thinkingPattern: 'Cost Function in Architecture',
  ),

  Problem(
    id: 'dm-u2-q2',
    trackId: 'decision-making',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'TRADE-OFFS',
    type: ProblemType.choice,
    prompt:
        'Two engineers argue about caching strategy.\n'
        'Engineer A: "Always cache, it is faster"\n'
        'Engineer B: "Caching adds complexity; only cache if we hit scale limits"\n\n'
        'The conversation is going nowhere. What is missing?',
    options: [
      'More data on performance',
      'The trade-off is not being made explicit — neither engineer is saying "I am choosing simplicity over speed" or vice versa',
      'A code review',
      'A customer survey',
    ],
    correctAnswer: 1,
    explanation:
        'Most arguments hide a trade-off. Engineer A is implicitly saying "speed > simplicity." Engineer B is saying "simplicity > speed." '
        'Until those trade-offs are explicit — and until you agree on the priority — you are arguing in different languages. The fix: '
        '"We are prioritizing easy debugging over raw speed until we hit 10k requests/sec. Then we cache."',
    thinkingPattern: 'Making Trade-offs Explicit',
  ),

  // Unit 3: Cognitive Bias in Technical Decisions

  Problem(
    id: 'dm-u3-q0',
    trackId: 'decision-making',
    unitIndex: 3,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'COGNITIVE BIAS IN TECHNICAL DECISIONS',
    type: ProblemType.choice,
    prompt:
        'Your team spent 3 weeks building a feature using Technology X. It is slower than expected. '
        'A colleague suggests: "Let us switch to Technology Y — it is clearly better."\n\n'
        'Your manager says: "We have already spent 3 weeks. Cannot waste that."\n\n'
        'Who is right?',
    options: [
      'Your manager — sunk costs matter',
      'Your colleague — those 3 weeks do not matter anymore',
      'Both — it is a tough call',
      'Neither — the decision should be based only on future costs',
    ],
    correctAnswer: 1,
    explanation:
        'The 3 weeks are gone. Whether to continue is a choice between "spend 2 more weeks on X" vs "spend 3 weeks on Y." '
        'The past investment is irrelevant. Clinging to it (sunk cost fallacy) means you keep investing in bad decisions. '
        'The moment you realize a path is wrong, the sunk cost becomes a reason to change, not a reason to continue.',
    thinkingPattern: 'Ignoring Sunk Costs',
  ),

  Problem(
    id: 'dm-u3-q1',
    trackId: 'decision-making',
    unitIndex: 3,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'COGNITIVE BIAS IN TECHNICAL DECISIONS',
    type: ProblemType.choice,
    prompt:
        'Engineer A proposes a new caching layer. Engineer B reviews the PR.\n\n'
        'Engineer B initially had doubts about caching, but during the review, she notices Engineer A found solutions to every concern '
        'she was going to raise.\n\n'
        'She approves the PR quickly.\n\n'
        'Six months later, the caching layer becomes the bottleneck.\n\n'
        'What bias happened?',
    options: [
      'Engineer A was just better at implementation',
      'Engineer B did her job correctly',
      'Engineer B fell into confirmation bias — Engineer A answered her concerns so thoroughly that she stopped critically evaluating the trade-off',
      'Caching is never the answer',
    ],
    correctAnswer: 2,
    explanation:
        'When each of your concerns is answered, it is easy to slip into "okay, they have thought of everything." '
        'But answering technical concerns ≠ proving the trade-off is worth it. Engineer B should have asked: "Is this caching layer necessary at this scale?" '
        'instead of just "Is it implemented correctly?" Confirmation bias in code reviews is the risk of being so impressed with competence that you skip the bigger question.',
    thinkingPattern: 'Distinguishing Technical Correctness from Strategic Wisdom',
  ),

  Problem(
    id: 'dm-u3-q2',
    trackId: 'decision-making',
    unitIndex: 3,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'COGNITIVE BIAS IN TECHNICAL DECISIONS',
    type: ProblemType.choice,
    prompt:
        'Project Alpha: First estimate was "3 months." Months later, still ongoing. Team estimates: "5 more weeks." Final time: 6 months total.\n\n'
        'Project Beta: First estimate was "8 months." It finished in 7 months.\n\n'
        'The estimates came from different teams, different problems.\n\n'
        'What is the anchor effect in play?',
    options: [
      'The first estimate in Project Alpha was too optimistic',
      'The first estimate in Project Beta was pessimistic, allowing for buffer',
      'Team Beta is better at estimation',
      'Once an estimate is public, all future estimates "orbit" it, even if wrong',
    ],
    correctAnswer: 3,
    explanation:
        'In Project Alpha, the initial "3 months" became an anchor. Every revised estimate (4 months, then 5 more weeks) tried to stay close to it '
        'rather than starting from first principles. In Project Beta, the "8 months" was pessimistic enough that the final estimate could land close to it. '
        'The first number said in a room shapes all subsequent ones. To break the anchor, re-estimate from scratch without referencing the old number.',
    thinkingPattern: 'Recognizing Anchoring',
  ),

  // ────────────────────────────────────────────────────────────────────────────
  // TRACK 5: ESTIMATION & SCALE
  // ────────────────────────────────────────────────────────────────────────────

  // Unit 0: Fermi Estimation

  Problem(
    id: 'es-u0-q0',
    trackId: 'estimation-scale',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'FERMI ESTIMATION',
    type: ProblemType.choice,
    prompt:
        'How many gas stations are in your country?\n\n'
        'To estimate this, what is the first question you should ask?',
    options: [
      'How many cars are registered?',
      'How much gasoline does the country use per year?',
      'What is the population?',
      'How many gas stations did the government build?',
    ],
    correctAnswer: 0,
    explanation:
        'Fermi estimation works backwards from consumption. Population × cars per capita = total cars. Cars × miles per year = total miles. '
        'Miles × gallons per mile = total gallons. Gallons per station per year = number of stations. You are decomposing the big question into smaller answerable ones. '
        'The method matters more than the final number.',
    thinkingPattern: 'Fermi Decomposition',
  ),

  Problem(
    id: 'es-u0-q1',
    trackId: 'estimation-scale',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'FERMI ESTIMATION',
    type: ProblemType.choice,
    prompt:
        'Your app normally handles 1,000 requests/second. At 3 AM you send a notification to 1 million users.\n\n'
        'If 5% open it immediately, that is 50,000 simultaneous requests.\n\n'
        'Your servers can handle 1,000 req/s peak. What goes wrong?',
    options: [
      '50 servers are needed (50,000 ÷ 1,000)',
      'The servers will queue requests and handle them slowly',
      'The system cascades: slow response times → users retry → more load → collapse',
      'Nothing — just add 50 servers',
    ],
    correctAnswer: 2,
    explanation:
        'At 50× normal load, your system does not gracefully degrade. Slow responses trigger user retries. Retries add load. Load causes more slowness. '
        'This cascade collapses the system faster than linear overload would. The Fermi estimate (50× normal) is your signal to either rate-limit, queue to a background job, or provision for the spike.',
    thinkingPattern: 'Capacity Planning with Cascading Failure',
  ),

  Problem(
    id: 'es-u0-q2',
    trackId: 'estimation-scale',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'FERMI ESTIMATION',
    type: ProblemType.choice,
    prompt:
        r'Your CEO says: "We are capturing 0.5% market share in a $50 billion market. That is $250 million in revenue."' '\n\n'
        r'Run a quick Fermi check. The company has 100 employees. Average software salary is $200k. Your burn rate is ~$30 million/year.' '\n\n'
        r'At current growth, will you hit $250M in 5 years?',
    options: [
      'Yes, definitely',
      'No, that is impossibly fast',
      'Maybe — need more data',
      'Cannot estimate revenue from burn rate',
    ],
    correctAnswer: 1,
    explanation:
        r'You are spending $30M/year on a 100-person team. $200k × 100 = $20M in salary alone. Even at 90% gross margin, you would need ~$333M in revenue to break even. '
        r'To reach $250M in 5 years means going from $0 to $50M/year revenue growth. At your burn rate and team size, that is an impossibly fast hockey stick. '
        'The claim needs much better justification.',
    thinkingPattern: 'Sanity-Checking with Fermi Estimates',
  ),

  // Unit 1: Orders of Magnitude

  Problem(
    id: 'es-u1-q0',
    trackId: 'estimation-scale',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'ORDERS OF MAGNITUDE',
    type: ProblemType.choice,
    prompt:
        'Response time: 10ms vs 100ms.\n\n'
        'To a user, what is the difference?',
    options: [
      'Both feel instant',
      '10ms feels instant; 100ms feels slow',
      'They are both just milliseconds; no practical difference',
      '10ms is 10× faster so 10× better',
    ],
    correctAnswer: 1,
    explanation:
        'Below ~100ms, humans perceive action as instant. Above ~500ms, they perceive lag. So 10ms and 100ms are both "instant" to users. '
        'But 10ms vs 1 second is a huge difference. You should know these bounds: 10ms instant, 100ms slow, 1s user attention lost. '
        'These bounds change how you design systems.',
    thinkingPattern: 'Perceptual Thresholds in Performance',
  ),

  Problem(
    id: 'es-u1-q1',
    trackId: 'estimation-scale',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'ORDERS OF MAGNITUDE',
    type: ProblemType.choice,
    prompt:
        'Your database handles 1,000 concurrent users perfectly. You grow to 10,000 concurrent users.\n\n'
        'Do you need 10x more database server resources?',
    options: [
      'Yes, obviously',
      'No, often you need only 2-3x more',
      'It depends on the query patterns',
      'Database scaling does not work that way',
    ],
    correctAnswer: 2,
    explanation:
        'If your bottleneck is CPU (queries), you might need 10x. But if your bottleneck was just "number of connections," adding connection pooling solves it at 1x cost. '
        'Or if 90% of traffic is reads, you add read replicas, not more write capacity. The lesson: 10x users ≠ 10x resources. Understand your bottleneck first. '
        'Most systems can 3-5x before needing radical redesign.',
    thinkingPattern: 'Bottleneck Analysis',
  ),

  Problem(
    id: 'es-u1-q2',
    trackId: 'estimation-scale',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'ORDERS OF MAGNITUDE',
    type: ProblemType.choice,
    prompt:
        'A startup claims: "We are growing 10% per week and will have 1 billion users in 3 years."\n\n'
        'Do the math: 1 billion ÷ (1.1^156 weeks) = starting from ~80 users. Is this plausible?\n\n'
        'What is the real issue?',
    options: [
      'The growth rate will drop as they scale (which it always does)',
      'The math checks out, so it is possible',
      'They are not accounting for market size (only ~5 billion internet users exist)',
      'Both A and C',
    ],
    correctAnswer: 3,
    explanation:
        'The claim fails on two fronts. First, 10% weekly growth is possible for 18 months; after that, it crashes as the market saturates. '
        'Second, 1B users exceeds the global internet population. Sanity-check large numbers against: market size, historical precedent (did any company grow this fast?), '
        'and diminishing returns. If a number seems implausible, the claim probably is.',
    thinkingPattern: 'Questioning Implausible Growth Claims',
  ),

  // Unit 2: Cost Estimation

  Problem(
    id: 'es-u2-q0',
    trackId: 'estimation-scale',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'COST ESTIMATION',
    type: ProblemType.choice,
    prompt:
        'You are asked: "How long to implement user authentication?"\n\n'
        'A junior engineer says: "15 hours."\n'
        'A senior engineer says: "3 weeks."\n\n'
        'Who is more accurate and why?',
    options: [
      'The junior engineer — 15 hours is 2 days of work',
      'The senior engineer — auth is complex, needs testing',
      'The junior engineer for the code; the senior engineer for the project',
      'It depends on the specific requirements',
    ],
    correctAnswer: 2,
    explanation:
        'The junior is estimating code time (15 hours of typing). The senior is estimating project time (design, testing, documentation, deployment, rollback plan, monitoring, on-call support). '
        'Real cost = code time + overhead. For a small feature, overhead might be 3x. For auth, it is higher because the stakes are security. '
        'Estimate in "weeks" for project scope, not "hours" for code.',
    thinkingPattern: 'Project Cost vs Code Time',
  ),

  Problem(
    id: 'es-u2-q1',
    trackId: 'estimation-scale',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'COST ESTIMATION',
    type: ProblemType.choice,
    prompt:
        'A feature is estimated at "40 hours of development." You ship it. But then:\n'
        '- Testing finds 2 days of bugs\n'
        '- Documentation takes 1 day\n'
        '- Deployment and monitoring setup takes 1 day\n'
        '- 1 week of on-call support (paying engineers to monitor it)\n'
        '- 2 days of follow-up fixes\n\n'
        'What is the true cost?',
    options: [
      '40 hours',
      '40 + (2+1+1+5+2) = 51 hours (30% overhead)',
      '40 × 2.5 = 100 hours (true project cost)',
      'Infinity — ongoing support is never "done"',
    ],
    correctAnswer: 2,
    explanation:
        'The original 40 hours was just coding. Add testing (60% of code time), deployment (20%), and support (50%). Total is often 2-3x the initial estimate. '
        'If you quote a client "40 hours," they will be shocked when the true bill is 100. Always quote project cost, not code time. '
        'Experienced teams use a multiplier: 2.5-3x for well-defined features.',
    thinkingPattern: 'Full Cost Accounting',
  ),

  Problem(
    id: 'es-u2-q2',
    trackId: 'estimation-scale',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'COST ESTIMATION',
    type: ProblemType.choice,
    prompt:
        'You estimate a feature at 4 weeks. 6 months later, it is still being tweaked.\n\n'
        'Three things went wrong:\n'
        '1. Initial estimate assumed no blockers\n'
        '2. Stakeholders kept adding requirements\n'
        '3. The team hit unexpected technical debt halfway through\n\n'
        'Which is hardest to predict upfront?',
    options: [
      'Blockers — you should expect 20% of time spent unblocked',
      'Scope creep — ask stakeholders to freeze requirements',
      'Technical debt — you do not know what you do not know',
      'All three are equally unpredictable',
    ],
    correctAnswer: 2,
    explanation:
        'Blockers are foreseeable (add 20% buffer). Scope creep is avoidable (scope lock). But technical debt hits you mid-sprint when you realize '
        '"this codebase is a mess" or "the API is not what we need." You cannot estimate what you do not know. The fix: time-box, iterate, and plan for the unknown unknowns. '
        'Never quote a single estimate for something you have not started.',
    thinkingPattern: 'Estimating Under Uncertainty',
  ),

  // Unit 3: Capacity Thinking

  Problem(
    id: 'es-u3-q0',
    trackId: 'estimation-scale',
    unitIndex: 3,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'CAPACITY THINKING',
    type: ProblemType.choice,
    prompt:
        'Your database can handle 10,000 simultaneous connections. Today you have 8,000.\n\n'
        'Do you have headroom or are you in danger?',
    options: [
      'You have 20% headroom, so you are safe for 2 more weeks',
      '80% utilisation is dangerously high — you are one spike away from crashing',
      'It depends on your peak load vs average load',
      'You should start planning to scale immediately',
    ],
    correctAnswer: 2,
    explanation:
        'If those 8,000 are average, and your peak is 9,000, you are fine. If 8,000 is your baseline and you spike to 10,000 during lunch, you will hit the limit. '
        'Capacity planning is not about the number — it is about peak load vs capacity. If average is 8k and peak is 9.5k, you have 500 connections of headroom. '
        'If peak is 10k, you are at the cliff and need to scale now.',
    thinkingPattern: 'Peak Load vs Average Load',
  ),

  Problem(
    id: 'es-u3-q1',
    trackId: 'estimation-scale',
    unitIndex: 3,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'CAPACITY THINKING',
    type: ProblemType.choice,
    prompt:
        'Your app normally handles 1,000 requests/second. During a marketing campaign or viral moment, it might hit 10,000 req/s for 30 minutes.\n\n'
        'Should you:',
    options: [
      'Build capacity for 10k req/s permanently (expensive, unused 99% of the time)',
      'Build capacity for 2k req/s and rate-limit spikes',
      'Build capacity for 5k req/s and queue overflow traffic',
      'Hope it does not happen',
    ],
    correctAnswer: 2,
    explanation:
        'Option A is wasteful (9k req/s idle capacity costs 10× more). Option B ruins user experience (they see "service unavailable"). '
        'Option C balances cost and experience: you handle 5x traffic, queue the rest, and burn through the queue over 5 minutes. '
        'Cost is reasonable, experience is acceptable. This is why queues exist: to decouple traffic spikes from backend capacity.',
    thinkingPattern: 'Handling Load Spikes with Queues',
  ),

  Problem(
    id: 'es-u3-q2',
    trackId: 'estimation-scale',
    unitIndex: 3,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'CAPACITY THINKING',
    type: ProblemType.choice,
    prompt:
        'Your database server can handle 100 transactions per second. You are running at 80 transactions/sec.\n\n'
        'Your infrastructure team says: "We need to upgrade now, before it gets worse."\n'
        'Operations says: "We are at 80%. We still have 20% headroom. It is fine."\n\n'
        'Who should win this decision?',
    options: [
      'Operations — 20% headroom is safe',
      'Infrastructure — 80% utilization means unpredictable performance',
      'They need more context',
      'Just scale to 90% and check again later',
    ],
    correctAnswer: 1,
    explanation:
        'Above 80% utilization, system behaviour becomes unpredictable. Contention increases, latency becomes variable, and small traffic spikes cause cascading failures. '
        'At 80%, you have headroom, but you are in the danger zone. The rule of thumb: keep systems at ≤70% utilization for predictable performance. '
        'At 80%, you are one bad day away from an outage. Start planning the upgrade now.',
    thinkingPattern: 'Utilization Headroom',
  ),

  // ────────────────────────────────────────────────────────────────────────────
  // TRACK 6: CRITICAL EVALUATION
  // ────────────────────────────────────────────────────────────────────────────

  // Unit 0: Spotting Flawed Assumptions

  Problem(
    id: 'ce-u0-q0',
    trackId: 'critical-evaluation',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'SPOTTING FLAWED ASSUMPTIONS',
    type: ProblemType.choice,
    prompt:
        'Requirement: "Users want to see their purchase history sorted by date."\n\n'
        'What assumption is hidden in this requirement?',
    options: [
      'Users have purchase history',
      'Users want to view history at all',
      'Date sorting is more useful than sorting by category, price, or status',
      'All of the above',
    ],
    correctAnswer: 3,
    explanation:
        'The requirement assumes users exist, they have made purchases, they want to see them, and date is the right sort order. '
        'Any of these could be wrong. Before building, ask: "Do users actually view history? What do they do with it? Is date the most useful sort?" '
        'Never trust a requirement at face value. Excavate the assumptions buried in it.',
    thinkingPattern: 'Assumption Excavation',
  ),

  Problem(
    id: 'ce-u0-q1',
    trackId: 'critical-evaluation',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'SPOTTING FLAWED ASSUMPTIONS',
    type: ProblemType.choice,
    prompt:
        'A stakeholder says: "The app should be simple for new users and powerful for experts."\n\n'
        'Later, they add: "Every screen must fit on a mobile phone with no scrolling."\n\n'
        'These cannot both be true. Simple-yet-powerful requires options. Mobile-no-scroll requires minimalism.\n\n'
        'What is the right move?',
    options: [
      'Build both and let the user choose',
      'Ask which is more important and make the trade-off explicit',
      'Build it simple first, add power later',
      'It is possible with the right UX design',
    ],
    correctAnswer: 1,
    explanation:
        'The requirements contradict. You must choose: optimize for simplicity (and sacrifice power) or optimize for power (and sacrifice simplicity). '
        'Or find a different constraint to negotiate (maybe scrolling is okay, or maybe mobile is not the priority platform). '
        'Make the trade-off explicit and owned. Never build a contradiction hoping it magically resolves.',
    thinkingPattern: 'Contradiction Detection',
  ),

  Problem(
    id: 'ce-u0-q2',
    trackId: 'critical-evaluation',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'SPOTTING FLAWED ASSUMPTIONS',
    type: ProblemType.choice,
    prompt:
        'You analyze your user survey: "92% of customers are satisfied."\n\n'
        'But you surveyed only users who opened your in-app feedback form.\n\n'
        'What is wrong with this conclusion?',
    options: [
      '92% is too high; real satisfaction is lower',
      'You have sampled the easy-to-reach users, not the whole population',
      'Users who open feedback forms might be different from those who do not (selection bias)',
      'All of the above',
    ],
    correctAnswer: 3,
    explanation:
        'By surveying only in-app feedback openers, you miss silent dissenters who have left. You have selected for users engaged enough to give feedback, '
        'who might be more satisfied than the average. This selection bias inflates satisfaction. '
        'The fix: sample randomly, or acknowledge the bias in reporting ("of engaged users").',
    thinkingPattern: 'Selection Bias Recognition',
  ),

  // Unit 1: Edge Cases

  Problem(
    id: 'ce-u1-q0',
    trackId: 'critical-evaluation',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'EDGE CASES',
    type: ProblemType.choice,
    prompt:
        'You are building a shopping list. You need to test edge cases.\n\n'
        'Which are critical?',
    options: [
      '0 items (empty list), 1 item (minimum), 100 items (scale)',
      '0 items, 1000 items, 1 million items',
      'Just 1 item (normal case)',
      'Only the case with many items (that is where bugs hide)',
    ],
    correctAnswer: 0,
    explanation:
        'The zero, one, many rule catches most bugs. Zero items: does the UI crash or show an empty state? One item: do arrays work correctly? '
        'Many items: does pagination work? You do not need to test 100 and 1000 — both reveal the same patterns. '
        'Most bugs hide at the boundaries (0) or the transitions (one → many).',
    thinkingPattern: 'Zero-One-Many Testing',
  ),

  Problem(
    id: 'ce-u1-q1',
    trackId: 'critical-evaluation',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'EDGE CASES',
    type: ProblemType.choice,
    prompt:
        'You are shipping a notification feature. What is the edge case most engineers miss?',
    options: [
      'No notifications (empty state)',
      'The notification arrives in a different timezone than the user',
      'Two notifications arrive at the same millisecond',
      'A user deletes their account while viewing notifications',
    ],
    correctAnswer: 1,
    explanation:
        'Timezone issues hide in plain sight. If you store notification times in UTC but display them locally, a user in Tokyo sees different times than NYC. '
        'This breaks sorting and UX. Other sneaky edge cases: concurrent actions (what if the user clicks twice?), state transitions (what if the notification is deleted mid-render?), '
        'and time-dependent logic (does this work at midnight on a leap second?). Build a habit of thinking through time, concurrency, and state transitions.',
    thinkingPattern: 'Edge Case Categories',
  ),

  Problem(
    id: 'ce-u1-q2',
    trackId: 'critical-evaluation',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'EDGE CASES',
    type: ProblemType.choice,
    prompt:
        'Your payment system works perfectly with 1,000 concurrent users. At 10,000 users, a subtle bug emerges:\n\n'
        'Race condition: two charges go through instead of one.\n\n'
        'This bug existed at 1,000 users but never triggered. At 10,000, it triggers regularly.\n\n'
        'Why did not testing catch it?',
    options: [
      'The tests were insufficiently thorough',
      'Concurrency bugs only manifest under high load; you cannot predict them in advance',
      'The system was never stress-tested',
      'The edge case (concurrent identical requests) is statistically rare at small scale',
    ],
    correctAnswer: 3,
    explanation:
        'The race condition existed at 1,000 users, but the odds of two identical requests arriving in the same millisecond were tiny. '
        'At 10,000 users, the collision probability jumps. This is the edge case that becomes the common case at scale. '
        'The lesson: stress-test early and often. What is statistically impossible at 1k might be common at 100k.',
    thinkingPattern: 'Scale-Dependent Edge Cases',
  ),

  // Unit 2: Failure Modes

  Problem(
    id: 'ce-u2-q0',
    trackId: 'critical-evaluation',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'FAILURE MODES',
    type: ProblemType.choice,
    prompt:
        'Your app architecture:\n'
        '- Frontend talks to one API server\n'
        '- API server talks to one database\n'
        '- Database writes to one backup disk\n\n'
        'Where will the system fail first?',
    options: [
      'The API server (single point of failure)',
      'The database (single point of failure)',
      'The backup disk (least critical)',
      'The frontend (user-side failure)',
    ],
    correctAnswer: 0,
    explanation:
        'If the API server goes down, users cannot reach the service. The database is backed up (redundancy), but the API is a bottleneck. '
        'Single points of failure are architectural weaknesses. The fix: run multiple API servers behind a load balancer. '
        'Identify every service that, if it fails, breaks the whole system. Those are your priorities for redundancy.',
    thinkingPattern: 'Identifying Single Points of Failure',
  ),

  Problem(
    id: 'ce-u2-q1',
    trackId: 'critical-evaluation',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'FAILURE MODES',
    type: ProblemType.choice,
    prompt:
        'Your recommendation system calls an ML service. If the ML service times out, should you:',
    options: [
      'Return an error page ("Recommendations unavailable")',
      'Return the last cached recommendation (best-effort)',
      'Return a random selection (reasonable fallback)',
      'Retry infinitely until the service responds',
    ],
    correctAnswer: 1,
    explanation:
        'Hard failure (A) = bad UX. Infinite retry (D) = cascading failure. Graceful degradation means offering something useful when the primary system fails. '
        'Stale recommendations (B) or random picks (C) are better than "service unavailable." '
        'This is how robust systems work: every dependency has a fallback. If you cannot degrade gracefully, the dependency is critical — make it resilient instead.',
    thinkingPattern: 'Fault Tolerance Design',
  ),

  Problem(
    id: 'ce-u2-q2',
    trackId: 'critical-evaluation',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'FAILURE MODES',
    type: ProblemType.choice,
    prompt:
        'Event sequence:\n'
        '1. The payment service is slow (5-second responses)\n'
        '2. The web server has a 10-second timeout\n'
        '3. So web requests wait 10s, then timeout\n'
        '4. Users retry, generating more load\n'
        '5. More load makes the payment service slower\n'
        '6. More slow requests → more timeouts → more retries → more load → collapse\n\n'
        'This is a cascading failure. How do you break the cycle?',
    options: [
      'Increase the 10-second timeout to 30 seconds',
      'Add a circuit breaker to stop calling the payment service when it is slow',
      'Scale up the payment service',
      'Both B and C',
    ],
    correctAnswer: 3,
    explanation:
        'A makes it worse (timeouts just come later). B is critical (stop calling a failing service; let it recover). C addresses root cause. '
        'The real lesson: cascading failures require circuit breakers. When a service is slow, fail fast and queue the request instead of blocking. '
        'Give the service time to recover. If you do not, a single slow service will bring down your entire platform.',
    thinkingPattern: 'Circuit Breaker Pattern',
  ),

  // Unit 3: Evaluating AI Output

  Problem(
    id: 'ce-u3-q0',
    trackId: 'critical-evaluation',
    unitIndex: 3,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'EVALUATING AI OUTPUT',
    type: ProblemType.choice,
    prompt:
        'Claude gives you this code to count unique items in a list:\n\n'
        'result = len(set([1, 1, 2, 2, 2, 3]))\n\n'
        'The explanation says: "Sets automatically remove duplicates, so the length of the set is the count of unique items."\n\n'
        'Is this correct?',
    options: [
      'Yes, perfectly correct',
      'No, sets require sorting first',
      'No, the logic is correct but the explanation implies the code also removes duplicates from the original list (it does not)',
      'No, this does not work in Python',
    ],
    correctAnswer: 0,
    explanation:
        'The code and explanation are both correct. But this illustrates the risk: AI can sound confident while being subtly wrong. '
        'For instance, if the answer were "lists automatically remove duplicates," that would sound equally confident but be false. '
        'Always verify AI output by testing, thinking through the logic, and checking against authoritative sources. Confidence and correctness are not correlated.',
    thinkingPattern: 'Verifying AI Output',
  ),

  Problem(
    id: 'ce-u3-q1',
    trackId: 'critical-evaluation',
    unitIndex: 3,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'EVALUATING AI OUTPUT',
    type: ProblemType.choice,
    prompt:
        'You ask Claude to write a password hashing function. The code uses bcrypt and includes salt generation.\n\n'
        'Should you:',
    options: [
      'Use it as-is; AI knows security',
      'Review it carefully and verify it matches bcrypt best practices',
      'Test it before using it',
      'Both B and C',
    ],
    correctAnswer: 3,
    explanation:
        'Security code needs verification. Bcrypt is a standard library, so correct usage is likely. '
        'But verify: Is the salt length correct? Are the rounds appropriate? Does error handling prevent timing attacks? '
        'AI can generate plausible code, but security requires scrutiny. Never deploy AI-generated security code without review by a security expert '
        'or reference against official documentation.',
    thinkingPattern: 'Trust but Verify (Especially for Security)',
  ),

  Problem(
    id: 'ce-u3-q2',
    trackId: 'critical-evaluation',
    unitIndex: 3,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'EVALUATING AI OUTPUT',
    type: ProblemType.choice,
    prompt:
        'You ask Claude to write a date parser. It handles common formats: "2025-03-13", "2025/03/13", "March 13, 2025".\n\n'
        'What edge case should you ask Claude about?',
    options: [
      'Leap years',
      'Timezones',
      'Ambiguous dates (03-04-2025 is March 4 or April 3?)',
      'All of the above',
    ],
    correctAnswer: 3,
    explanation:
        'The generated code handles the happy path but misses subtle cases. The fix: before accepting AI-generated code, ask: '
        '"What happens with leap years? Timezones? Ambiguous formats?" This makes the AI second-guess itself and often reveals bugs it missed. '
        'The best prompt is one that says: "What edge cases does this code not handle?" AI will often find them if explicitly asked.',
    thinkingPattern: 'Defensive Prompting',
  ),

  // ────────────────────────────────────────────────────────────────────────────
  // TRACK 7: SYSTEM DESIGN THINKING
  // ────────────────────────────────────────────────────────────────────────────

  // Unit 0: Trade-offs in Architecture

  Problem(
    id: 'sd-u0-q0',
    trackId: 'system-design',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'TRADE-OFFS IN ARCHITECTURE',
    type: ProblemType.choice,
    prompt:
        'You are designing a banking system. A network partition (two datacenters lose connection) happens.\n\n'
        'You can:\n'
        'A) Keep accepting deposits on both sides; reconcile later (risk: double-counting)\n'
        'B) Stop accepting deposits on one side until they reconnect (users see outage)\n\n'
        'Which is the trade-off you are making?',
    options: [
      'Performance vs security',
      'Availability vs consistency',
      'Cost vs reliability',
      'Simplicity vs scalability',
    ],
    correctAnswer: 1,
    explanation:
        'CAP theorem says: in a network split, you choose consistency (A safe, but B side is down) or availability (both sides work, but data might diverge). '
        'Most systems choose consistency for money. Social networks choose availability (a like might appear twice, who cares?). '
        'The point is not the jargon — it is recognizing that no system has all three: consistency, availability, partition tolerance. You must sacrifice one.',
    thinkingPattern: 'CAP Trade-offs',
  ),

  Problem(
    id: 'sd-u0-q1',
    trackId: 'system-design',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'TRADE-OFFS IN ARCHITECTURE',
    type: ProblemType.choice,
    prompt:
        'A startup has 10 engineers building a social app. Monolith or microservices?\n\n'
        'Five years later, 100 engineers. Monolith or microservices?\n\n'
        'Why is the answer different?',
    options: [
      'Microservices is always better — start with it',
      'Monolith is always better — simpler to build',
      'At 10 people, you move slower with microservices (org overhead). At 100, monoliths collapse (too many features competing)',
      'The choice depends on tech stack, not team size',
    ],
    correctAnswer: 2,
    explanation:
        'Conway Law: architecture mirrors organization. 10 people sharing one monolith = fast, no coordination overhead. 100 people on one monolith = chaos, '
        'constant merge conflicts, deployments risk everything. At 100 people, split the system so teams own their services independently. But do not start there — '
        'the overhead of microservices coordination is not worth it when you are small.',
    thinkingPattern: 'Architecture as an Organization Problem',
  ),

  Problem(
    id: 'sd-u0-q2',
    trackId: 'system-design',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'TRADE-OFFS IN ARCHITECTURE',
    type: ProblemType.choice,
    prompt:
        'You are building a payments platform. You could:\n'
        'A) Buy Stripe (pay per transaction, no control)\n'
        'B) Build payment processing yourself (control, but 6-month effort, compliance nightmare)\n\n'
        'When should you build instead of buy?',
    options: [
      'When you want full control',
      'When the bought solution does not fit your use case',
      'When the cost of buying is higher than the cost of building',
      'When you are certain the product will not change and you will maintain it forever',
    ],
    correctAnswer: 2,
    explanation:
        r'"Build vs buy" is a cost-benefit analysis. Stripe costs ~2.9% per transaction. For $1M annual volume, that is $29k/year. '
        r'Building costs 6 months of two engineers = $300k + ongoing maintenance. Buy Stripe. But if your volume is $100M/year, that is $2.9M/year, '
        'and building might be cheaper over 5 years. The hidden factor: build requires perfect execution and forever maintenance. '
        'Buy shifts that burden to the vendor.',
    thinkingPattern: 'Total Cost of Ownership',
  ),

  // Unit 1: Scalability Patterns

  Problem(
    id: 'sd-u1-q0',
    trackId: 'system-design',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'SCALABILITY PATTERNS',
    type: ProblemType.choice,
    prompt:
        'Your database is slow. Response times: 500ms.\n\n'
        'The ops team suggests:\n'
        'A) Add caching in front (result: 5ms)\n'
        'B) Scale the database (cost: 10× more machines)\n'
        'C) Optimize the queries (3-month effort)\n\n'
        'What is the right first move?',
    options: [
      'A — it is the fastest, cheapest fix',
      'B — databases are the source of truth',
      'C — optimize first, then cache',
      'None; the problem is elsewhere',
    ],
    correctAnswer: 0,
    explanation:
        'Caching is the highest-ROI scaling tactic. If your data does not change every second, cache it for 5-60 minutes. '
        'This reduces database load exponentially and drops latency from 500ms to 5ms. You should always cache before scaling infrastructure. '
        'Only scale when you have exhausted caching, query optimization, and indexing.',
    thinkingPattern: 'Caching as Primary Scaling Strategy',
  ),

  Problem(
    id: 'sd-u1-q1',
    trackId: 'system-design',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'SCALABILITY PATTERNS',
    type: ProblemType.choice,
    prompt:
        'Your single database server is at 90% CPU. You could:\n'
        'A) Vertical: buy a 10× more powerful server (\$100k)\n'
        'B) Horizontal: split data across 3 servers (\$30k) but now you need distributed transactions\n\n'
        'What is the real trade-off?',
    options: [
      'Cost vs simplicity',
      'Vertical is always better',
      'Horizontal is always better',
      'Depends on the workload',
    ],
    correctAnswer: 3,
    explanation:
        'Vertical scales easily (just upgrade) but has a ceiling (no server is infinitely powerful). '
        'Horizontal scales forever but introduces complexity (distributed systems are hard). '
        'If your workload is read-heavy, horizontal (sharding reads) is cheap. If you need atomic transactions across all data, vertical is simpler until you hit the ceiling.',
    thinkingPattern: 'Recognizing When Each Scaling Strategy Wins',
  ),

  Problem(
    id: 'sd-u1-q2',
    trackId: 'system-design',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'SCALABILITY PATTERNS',
    type: ProblemType.choice,
    prompt:
        'You have a database of 500 million users. It is slow.\n\n'
        'Your options:\n'
        'A) Shard by user ID (user 1-100M on shard 1, etc.)\n'
        'B) Shard by geography (US users on server 1, EU on server 2)\n'
        'C) Add read replicas instead of sharding\n\n'
        'When is (A) the right choice?',
    options: [
      'When you have more data than one server can handle',
      'When queries are distributed evenly across all rows',
      'When you are certain the sharding key will not change',
      'When you have exhausted caching and vertical scaling',
    ],
    correctAnswer: 3,
    explanation:
        'Sharding is complex and requires the key (user ID) to be used in every query. If you shard by user ID but then run queries like "all users in California," '
        'you need to query all shards. Bad sharding is worse than no sharding. Only shard when: single-machine limits are hit, your queries naturally use the shard key, '
        'and you can distribute evenly. Otherwise, read replicas are simpler.',
    thinkingPattern: 'Sharding as a Last Resort',
  ),

  // Unit 2: Reliability

  Problem(
    id: 'sd-u2-q0',
    trackId: 'system-design',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'RELIABILITY',
    type: ProblemType.choice,
    prompt:
        'Your SLA promises "99.9% uptime."\n\n'
        'In one year, how much downtime is that?',
    options: [
      '10 minutes',
      '1 hour',
      '9 hours',
      '1 day',
    ],
    correctAnswer: 2,
    explanation:
        '99.9% of 365 days = 0.999 × 365 × 24 hours = 8.76 hours/year. That is one unexpected outage per quarter. '
        'Most teams think "99.9% is great," but it means you cannot afford more than one significant incident per year. '
        '99.99% (4 nines) = 52 minutes/year. 99.999% (5 nines) = 5 minutes/year. Know what you are promising.',
    thinkingPattern: 'Interpreting SLA Numbers',
  ),

  Problem(
    id: 'sd-u2-q1',
    trackId: 'system-design',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'RELIABILITY',
    type: ProblemType.choice,
    prompt:
        'A company runs two database servers for redundancy. But both are in the same datacenter.\n\n'
        'A power outage hits. Both go down.\n\n'
        'What is the lesson?',
    options: [
      'Two servers are useless',
      'Redundancy only matters if the redundant systems can fail independently',
      'You need three servers, not two',
      'Redundancy is too expensive',
    ],
    correctAnswer: 1,
    explanation:
        'Redundancy protects against component failure, not shared-failure modes. Two servers in the same datacenter fail together in a power outage, fire, or network cut. '
        'True redundancy means geographic distribution (different datacenters), different power supplies, or both. '
        'The rule: redundancy is useful only if the failures are independent.',
    thinkingPattern: 'Independent Failure Modes',
  ),

  Problem(
    id: 'sd-u2-q2',
    trackId: 'system-design',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'RELIABILITY',
    type: ProblemType.choice,
    prompt:
        'You are building a critical system. You design every component with redundancy: dual servers, dual databases, dual networks.\n\n'
        'But one day, a cascading failure takes down the whole system.\n\n'
        'What went wrong?',
    options: [
      'You did not have enough redundancy',
      'You designed each component for failure but not the system as a whole',
      'The failure was unforeseeable',
      'Redundancy does not prevent cascading failures',
    ],
    correctAnswer: 1,
    explanation:
        'Designing for failure means: every component fails independently, but the system degrades gracefully. A cascading failure happens when component A fails → timeouts '
        '→ component B fails → load spike → component C fails. The fix: circuit breakers, timeouts, and fallbacks at every boundary. One component failing should not cascade. '
        'This is system-level design, not component-level.',
    thinkingPattern: 'System-Level Fault Tolerance',
  ),

  // Unit 3: Bottleneck Thinking in Systems

  Problem(
    id: 'sd-u3-q0',
    trackId: 'system-design',
    unitIndex: 3,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'BOTTLENECK THINKING IN SYSTEMS',
    type: ProblemType.choice,
    prompt:
        'Your request pipeline: Client → Proxy → API → Cache → Database.\n\n'
        'Each component can handle:\n'
        '- Proxy: 10k req/s\n'
        '- API: 5k req/s\n'
        '- Cache: 50k req/s\n'
        '- Database: 3k req/s\n\n'
        'What is the bottleneck?',
    options: [
      'The proxy (first thing the request hits)',
      'The API (in the middle)',
      'The database (lowest number: 3k req/s)',
      'It depends on the request pattern',
    ],
    correctAnswer: 2,
    explanation:
        'The bottleneck is the weakest link: the database at 3k req/s. No amount of caching, proxy scaling, or API replicas fixes this. You need more database capacity. '
        'The bottleneck is not always obvious; it is wherever the constraint is tightest. Find it with profiling, not guessing.',
    thinkingPattern: 'Constraint Identification',
  ),

  Problem(
    id: 'sd-u3-q1',
    trackId: 'system-design',
    unitIndex: 3,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'BOTTLENECK THINKING IN SYSTEMS',
    type: ProblemType.choice,
    prompt:
        'Your app is slow. You add more servers. Still slow.\n\n'
        'Three possible reasons:\n'
        'A) You are not actually scaling the bottleneck (maybe it is the database)\n'
        'B) The new servers are not being used (load balancer misconfiguration)\n'
        'C) The problem is elsewhere entirely (network, cache miss, lock contention)\n\n'
        'How do you diagnose which?',
    options: [
      'Look at CPU/memory on the new servers — if it is low, they are not being used',
      'Profile the request pipeline to find where time is spent',
      'Measure database query time and API response time',
      'All of the above',
    ],
    correctAnswer: 3,
    explanation:
        'Scaling is useless if you are not scaling the bottleneck. To find it: profile (where is time spent?), measure components (API 10ms, DB 400ms), '
        'and check that new resources are actually being used. Throwing hardware at the problem without diagnosis is wasteful.',
    thinkingPattern: 'Systematic Bottleneck Diagnosis',
  ),

  Problem(
    id: 'sd-u3-q2',
    trackId: 'system-design',
    unitIndex: 3,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'BOTTLENECK THINKING IN SYSTEMS',
    type: ProblemType.choice,
    prompt:
        'Your API can process 1k requests/sec. Traffic spikes to 5k requests/sec for 5 minutes.\n\n'
        'Option A: Users see "service busy" (drop requests)\n'
        'Option B: Queue requests, process 1k/sec, accumulate 4k backlog\n'
        'Option C: Add more API servers instantly (impossible)\n\n'
        'Should you add a queue?',
    options: [
      'Yes — buffer the spike, process later',
      'No — users will see slow responses (5 min wait)',
      'Only if the requests are idempotent',
      'Queues are a last resort',
    ],
    correctAnswer: 0,
    explanation:
        'Queues decouple traffic spikes from processing capacity. Users wait 5 minutes instead of seeing "busy." This is better for many use cases '
        '(background jobs, email) but worse for latency-critical ones (real-time trading). The rule: use a queue when you can tolerate the delay. '
        'If a 5-minute wait is unacceptable, you need more API capacity, not a queue.',
    thinkingPattern: 'Queue Trade-offs (Throughput vs Latency)',
  ),

  // ────────────────────────────────────────────────────────────────────────────
  // TRACK 8: COMMUNICATION THINKING
  // ────────────────────────────────────────────────────────────────────────────

  // Unit 0: Audience Awareness

  Problem(
    id: 'ct-u0-q0',
    trackId: 'communication',
    unitIndex: 0,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'AUDIENCE AWARENESS',
    type: ProblemType.choice,
    prompt:
        'You are explaining why a deployment failed to the CFO. Which approach is better?\n\n'
        'A) "The microservices architecture experienced a cascading failure in the event-driven message queue, causing timeouts in the distributed transaction handler."\n\n'
        'B) "We pushed an update to production. A bug made one of our systems slow, which caused other systems to pile up with work they could not process fast enough. The whole thing got stuck."\n\n'
        'What is the difference?',
    options: [
      'B is simpler but less accurate',
      'A is more impressive technically',
      'B is correct; A uses jargon that obscures meaning',
      'Both are equally good for different audiences',
    ],
    correctAnswer: 2,
    explanation:
        'The CFO does not need jargon. They need to understand: what broke, why, and how much it cost. B answers that. A uses technical terms that do not convey meaning to non-engineers. '
        'Good communication adapts to the audience. Jargon makes you sound smart; clarity makes you effective.',
    thinkingPattern: 'Audience-Adapted Explanation',
  ),

  Problem(
    id: 'ct-u0-q1',
    trackId: 'communication',
    unitIndex: 0,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'AUDIENCE AWARENESS',
    type: ProblemType.choice,
    prompt:
        'Your manager asks for a status update on a feature.\n\n'
        'Option A (5 minutes): "We are 60% done. Should ship Friday."\n'
        'Option B (20 minutes): "Unit tests for auth: done. Integration tests: 80% done. API endpoints: 3 of 4 complete. Blocked on database schema review by the DBA. Risk: Friday might slip to Monday if schema review takes >1 day."\n\n'
        'Manager asks: "Which would you prefer?"',
    options: [
      'Just the 5-minute version; they do not have time for details',
      'Just the 20-minute version; it shows you have thought it through',
      'It depends on what the manager needs to know',
      'Always provide both',
    ],
    correctAnswer: 2,
    explanation:
        'If the manager is checking progress (1-on-1), option A is enough. If they are determining whether to commit to Friday (planning), option B is critical. '
        'Match detail to decision. The principle: provide the minimum information needed to make the decision, plus visible uncertainty.',
    thinkingPattern: 'Audience-Appropriate Detail',
  ),

  Problem(
    id: 'ct-u0-q2',
    trackId: 'communication',
    unitIndex: 0,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'AUDIENCE AWARENESS',
    type: ProblemType.choice,
    prompt:
        'You are in a meeting presenting a technical proposal. Halfway through, you notice:\n'
        '- The CEO has stopped taking notes\n'
        '- The CFO is checking email\n'
        '- One engineer is leaning forward, engaged\n\n'
        'What should you do?',
    options: [
      'Keep going — finish your prepared slides',
      'Ask: "Should I go deeper or move to the recommendation?"',
      'Stop and ask what they want to know',
      'Adjust on the fly, shift to high-level summary',
    ],
    correctAnswer: 1,
    explanation:
        'The room is telling you something. The executive audience is losing interest; the engineer wants depth. Do not plow through. Instead: '
        '"Should I dive into the technical details or jump to why this matters?" This re-engages them and shows you respect their time. '
        'Reading the room means being flexible, not following a script.',
    thinkingPattern: 'Real-Time Audience Feedback',
  ),

  // Unit 1: Making Complexity Clear

  Problem(
    id: 'ct-u1-q0',
    trackId: 'communication',
    unitIndex: 1,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'MAKING COMPLEXITY CLEAR',
    type: ProblemType.choice,
    prompt:
        'Your system uses a distributed cache with eventual consistency. This is complex: data might be stale, conflicts require resolution, etc.\n\n'
        'How would you explain it in one sentence to a non-engineer?',
    options: [
      'We use a distributed cache with eventual consistency to handle CAP theorem trade-offs.',
      'We keep copies of data on multiple servers. They are not perfectly in sync, but that is okay because the delay is tiny.',
      'It is a caching layer.',
      'Cannot explain this in one sentence',
    ],
    correctAnswer: 1,
    explanation:
        'B is clear. A uses jargon. The test: if you cannot explain it simply, you do not understand it yet. Forcing yourself to write one sentence clarifies your own thinking. '
        'If it is truly too complex for one sentence, the system might be unnecessarily complex.',
    thinkingPattern: 'Simplification Through Constraint',
  ),

  Problem(
    id: 'ct-u1-q1',
    trackId: 'communication',
    unitIndex: 1,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'MAKING COMPLEXITY CLEAR',
    type: ProblemType.choice,
    prompt:
        'You are explaining blockchain to a non-technical person.\n\n'
        'Analogy A: "Blockchain is like a ledger that everyone has a copy of."\n'
        'Analogy B: "Blockchain is like a notebook where you write down transactions, and once written, the ink cannot be erased."\n\n'
        'Which analogy breaks down first?',
    options: [
      'A — does not explain immutability',
      'B — does not explain the "chain" part or consensus',
      'Both, but B breaks down faster in a detailed technical discussion',
      'Analogies always break down; never use them',
    ],
    correctAnswer: 2,
    explanation:
        'Analogy A clarifies decentralization but misses immutability. Analogy B clarifies immutability but misses hashing. No analogy survives detailed scrutiny. '
        'Use analogies to convey one core idea clearly, then acknowledge where they break. Do not force an analogy to do too much work.',
    thinkingPattern: 'Knowing When Analogies End',
  ),

  Problem(
    id: 'ct-u1-q2',
    trackId: 'communication',
    unitIndex: 1,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'MAKING COMPLEXITY CLEAR',
    type: ProblemType.choice,
    prompt:
        'You are proposing to migrate from PostgreSQL to MongoDB. You structure your argument:\n\n'
        '1. Claim: "MongoDB is faster."\n'
        '2. Evidence: "Our queries are 50% slower in PG than in the benchmark."\n'
        '3. Implication: "So we should migrate."\n\n'
        'What is wrong with this structure?',
    options: [
      'Claim is too strong',
      'Evidence does not support the claim (benchmark ≠ your actual workload)',
      'Missing the counter-argument and trade-offs (MongoDB loses transactions, gains flexibility)',
      'All of the above',
    ],
    correctAnswer: 3,
    explanation:
        'Good arguments: make a precise claim (not "faster" but "reduce query latency from 200ms to 100ms"), back it with evidence from your system (not a benchmark), '
        'acknowledge trade-offs explicitly ("we lose ACID transactions but gain flexibility"), and explain the decision ("the speed gain justifies the trade-off given our access patterns"). '
        'Weak arguments ignore context, trade-offs, and counter-evidence.',
    thinkingPattern: 'Logically Sound Arguments',
  ),

  // Unit 2: Writing for Decisions

  Problem(
    id: 'ct-u2-q0',
    trackId: 'communication',
    unitIndex: 2,
    questionIndex: 0,
    difficulty: Difficulty.easy,
    unitTitle: 'WRITING FOR DECISIONS',
    type: ProblemType.choice,
    prompt:
        'You are proposing a new logging system. What must the proposal include for stakeholders to decide?',
    options: [
      'Problem (current logging is slow), solution (new system), cost',
      'Problem, solution, cost, timeline, risk, trade-offs, and the recommended choice',
      'Just the recommended solution; the rest is noise',
      'Technical architecture; business people do not need it',
    ],
    correctAnswer: 1,
    explanation:
        'A good proposal answers: What is broken? What is the fix? What does it cost? When? What could go wrong? What do we lose (trade-offs)? What do I recommend and why? '
        'Without all of these, stakeholders make uninformed decisions or ask 10 follow-up questions. Do the thinking upfront.',
    thinkingPattern: 'Proposal Completeness',
  ),

  Problem(
    id: 'ct-u2-q1',
    trackId: 'communication',
    unitIndex: 2,
    questionIndex: 1,
    difficulty: Difficulty.medium,
    unitTitle: 'WRITING FOR DECISIONS',
    type: ProblemType.choice,
    prompt:
        'Your team debates whether to use PostgreSQL or MySQL for a new service.\n\n'
        'Option A: "Call a 1-hour meeting, debate in real-time, decide."\n'
        'Option B: "Write a 2-page decision doc: problem, options, pros/cons, recommendation. Circulate. Gather feedback async. Decide."\n\n'
        'When is B better?',
    options: [
      'Never — meetings are more efficient',
      'When the decision affects multiple teams or has long-term impact',
      'When people have thought-through views to contribute',
      'All of the above',
    ],
    correctAnswer: 3,
    explanation:
        'Async docs are slower to write but faster to decide. They force clarity (you must write your thinking), allow thinking time (people read and think before responding), '
        'and create a record (future teams know why you chose PostgreSQL). Use docs for decisions that: affect many people, have trade-offs, or need buy-in.',
    thinkingPattern: 'Async Decision-Making',
  ),

  Problem(
    id: 'ct-u2-q2',
    trackId: 'communication',
    unitIndex: 2,
    questionIndex: 2,
    difficulty: Difficulty.hard,
    unitTitle: 'WRITING FOR DECISIONS',
    type: ProblemType.choice,
    prompt:
        'You ship a feature with a workaround: the UI polls the server every 5 seconds instead of using proper WebSockets.\n\n'
        'Option A (comment): "Polling every 5s — low effort, good enough for now."\n'
        'Option B (comment): "Polling every 5s until WebSocket support is added (Task #1234). Using polling because we launched with limited backend time; '
        'WebSockets require database refactor (Task #2345) and frontend auth changes (Task #1122). Revisit in Q3 when bandwidth is available."\n\n'
        'Which comment will still be useful in 6 months?',
    options: [
      'A — concise, does not clutter the code',
      'B — too verbose, clutters the code',
      'B — because it captures the "why" and links to the real work',
      'Neither matters; code speaks for itself',
    ],
    correctAnswer: 2,
    explanation:
        'In 6 months, a new engineer reads the code and wonders: "Why polling?" Option A gives no hint. Option B explains the decision and the path to fix it, plus links to related work. '
        'Good comments capture the "why" and the context ("we chose X because Y, plan to fix with Z"). This is how knowledge survives team turnover.',
    thinkingPattern: 'Future-Proof Documentation',
  ),
];
