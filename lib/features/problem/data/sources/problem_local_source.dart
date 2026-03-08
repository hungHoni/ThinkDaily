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
];
