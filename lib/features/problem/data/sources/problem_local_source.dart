import 'package:think_daily/features/problem/data/models/problem.dart';

class ProblemLocalSource {
  // Returns the problem for a given date string (YYYY-MM-DD).
  // Returns null if no problem is scheduled for that date.
  Problem? getProblemByDate(String date) {
    try {
      return _problems.firstWhere((p) => p.date == date);
    } catch (_) {
      return null;
    }
  }

  List<Problem> getAllProblems() => List.unmodifiable(_problems);
}

// 90 problems — 13 weeks of content.
// Day pattern: Mon=Logic, Tue=Pattern, Wed=Algorithm(ordering),
//              Thu=Decomposition, Fri=EdgeCases, Sat=Estimation, Sun=DataStructure
final _problems = <Problem>[

  // ── WEEK 1 (March 7–15, 2026) ──────────────────────────────────────────────

  // Saturday — Estimation
  const Problem(
    id: 'estimation-001',
    date: '2026-03-07',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'A social app sends a push notification to all 10 million active users '
        'at exactly 9:00 AM. Each notification requires one database read. '
        'Your database handles 50,000 reads per second.\n\n'
        'Roughly how long will it take to process all the reads?',
    options: [
      'About 3 seconds',
      'About 3 minutes',
      'About 30 minutes',
      'About 3 hours',
    ],
    correctAnswer: 1,
    explanation:
        '10,000,000 reads ÷ 50,000 reads/second = 200 seconds ≈ 3.3 minutes. '
        'This is Fermi estimation: break the problem into known quantities, '
        'divide, and get an order-of-magnitude answer. The real insight is that '
        '"instant" notifications at scale are never truly instant.',
    thinkingPattern: 'Fermi Estimation',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-001',
    date: '2026-03-08',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'You need to implement an autocomplete system that suggests completions '
        'as a user types. Which data structure is specifically optimized for '
        'prefix lookups?',
    options: [
      'Hash map',
      'Trie (prefix tree)',
      'Binary search tree',
      'Linked list',
    ],
    correctAnswer: 1,
    explanation:
        'A trie organizes strings by their characters — each node represents a '
        'prefix. To find all words starting with "pre", you traverse to the "pre" '
        'node and collect all descendants. A hash map requires checking every key. '
        'A BST can prefix-search but requires O(log n) traversal per comparison. '
        "The trie's prefix lookup is O(m) where m is the prefix length, regardless "
        'of total word count.',
    thinkingPattern: 'Trie / Prefix Tree',
  ),

  // Monday — Logic & Deduction
  const Problem(
    id: 'logic-001',
    date: '2026-03-09',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'Five people are sitting in a row. Alice is to the left of Bob. '
        'Carol is to the right of Bob. Dave is between Alice and Bob. '
        'Eve is at one end.\n\nWho must be at the other end?',
    options: ['Alice', 'Bob', 'Carol', 'Dave'],
    correctAnswer: 2,
    explanation:
        'Dave is between Alice and Bob, so the order so far is: Alice, Dave, Bob. '
        'Carol is to the right of Bob, so Carol comes after Bob. '
        'Eve is at one end — the only open end is the far left, so Eve is leftmost '
        'and Carol must be at the far right.',
    thinkingPattern: 'Constraint Propagation',
  ),

  // Tuesday — Pattern Recognition
  const Problem(
    id: 'pattern-001',
    date: '2026-03-10',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'Look at this sequence:\n\n1, 1, 2, 3, 5, 8, 13, __\n\nWhat comes next?',
    options: ['18', '20', '21', '24'],
    correctAnswer: 2,
    explanation:
        'Each number is the sum of the two numbers before it. '
        '8 + 13 = 21. This is the Fibonacci sequence — a pattern that appears '
        'everywhere from nature to algorithm design.',
    thinkingPattern: 'Fibonacci / Recurrence Relation',
  ),

  // Wednesday — Algorithm Thinking
  const Problem(
    id: 'algorithm-001',
    date: '2026-03-11',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'You want to find a specific name in a sorted list of 1,000 names. '
        'Arrange these search strategies from fastest to slowest (on average):',
    options: [
      'Binary search',
      'Linear scan from the beginning',
      'Jump to a random position and scan outward',
      'Hash lookup (if a hash table exists)',
    ],
    correctAnswer: [3, 0, 2, 1],
    explanation:
        'A hash lookup is O(1) — instant. Binary search is O(log n) — '
        'halves the problem each step. Random jump with outward scan is '
        'unpredictable but beats linear on average. Linear scan is O(n) — '
        'it must check every element in the worst case.',
    thinkingPattern: 'Algorithmic Complexity',
  ),

  // Thursday — System Decomposition
  const Problem(
    id: 'decomposition-001',
    date: '2026-03-12',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'A food delivery app is slow during lunch rush. '
        'You have data showing the database is idle, the servers are at 20% CPU, '
        'and the network is at 15% capacity.\n\nWhere is the bottleneck most likely?',
    options: [
      'The database query layer',
      'The API server processing',
      'An external service or third-party API call',
      'The network bandwidth',
    ],
    correctAnswer: 2,
    explanation:
        'When internal resources (database, server, network) all show low utilization '
        'but the system is still slow, the bottleneck is almost always an external '
        'dependency — a payment processor, map service, or SMS provider with high '
        'latency. Internal bottlenecks would show high resource utilization.',
    thinkingPattern: 'Bottleneck Analysis',
  ),

  // Friday — Edge Cases & Debugging
  const Problem(
    id: 'edge-001',
    date: '2026-03-13',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A function divides a list into two halves and processes each half. '
        'It works perfectly for lists of 10, 100, and 1,000 items. '
        'Which input is most likely to break it?',
    options: [
      'A list with 999 items',
      'A list with 1 item',
      'A list with duplicate values',
      'A list already in sorted order',
    ],
    correctAnswer: 1,
    explanation:
        'A list with a single item cannot be meaningfully divided into two halves — '
        'one half would be empty. Most "divide and process" bugs appear at the boundary '
        'between zero and one items. Testing with single-element inputs catches '
        'the majority of off-by-one errors.',
    thinkingPattern: 'Boundary Testing',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-002',
    date: '2026-03-14',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'Your API stores one log entry per request. The service handles '
        '500 requests per second. Each log entry is 1 KB.\n\n'
        'How much storage do logs consume per day?',
    options: [
      'About 40 GB',
      'About 4 GB',
      'About 400 MB',
      'About 40 MB',
    ],
    correctAnswer: 0,
    explanation:
        '500 requests/sec × 86,400 seconds/day = 43,200,000 entries/day. '
        "43,200,000 × 1 KB ≈ 43 GB ≈ about 40 GB. At this rate you'd need "
        '~14 TB per year. This is why log rotation, sampling, and structured '
        'logging compression matter at scale.',
    thinkingPattern: 'Throughput × Time × Size',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-old-001',
    date: '2026-03-15',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        "You're building a browser's back/forward navigation. "
        'The user visits pages A → B → C → D. '
        'They press back twice (now on B), then visit page E.\n\n'
        'What data structure models this most naturally?',
    options: [
      'Two stacks (back stack and forward stack)',
      'A queue',
      'A circular buffer',
      'A sorted set',
    ],
    correctAnswer: 0,
    explanation:
        'Use two stacks: a back stack and a forward stack. Visiting a page pushes '
        'to the back stack and clears the forward stack. Pressing back pops from '
        'the back stack and pushes to the forward stack. When the user visits E '
        'after going back, the forward stack (C, D) is discarded — exactly how '
        'real browser history works.',
    thinkingPattern: 'Stack / Navigation State',
  ),

  // ── WEEK 2 (March 16–22, 2026) ─────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-002',
    date: '2026-03-16',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'Three packages arrive in order: Red, then Green, then Blue. '
        'Each contains a different item: a book, a lamp, or a mug. '
        'The book did not arrive first. The lamp arrived after the book.\n\n'
        'Which package contains the mug?',
    options: ['Red', 'Green', 'Blue', 'Cannot be determined'],
    correctAnswer: 0,
    explanation:
        "The book didn't arrive first (not Red). The lamp arrived after the book — "
        'so the book must be in Green (second) and the lamp in Blue (third). '
        'Red gets the mug by elimination. Working backwards from constraints '
        'is faster than trying all combinations.',
    thinkingPattern: 'Constraint Elimination',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-002',
    date: '2026-03-17',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'Look at this sequence:\n\n2, 6, 12, 20, 30, 42, __\n\nWhat comes next?',
    options: ['52', '54', '56', '60'],
    correctAnswer: 2,
    explanation:
        'The differences between terms are: 4, 6, 8, 10, 12 — each increases by 2. '
        'The next difference is 14, so 42 + 14 = 56. '
        'The pattern is n(n+1): 1×2, 2×3, 3×4 … 7×8 = 56. '
        'When the first differences follow a pattern, check the second differences.',
    thinkingPattern: 'Second-Order Differences',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-002',
    date: '2026-03-18',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        "You're handling a user's password reset request. "
        'Arrange these steps in the correct security-conscious order:',
    options: [
      'Verify the reset token is valid and unexpired',
      'Receive the reset request with new password',
      'Hash the new password',
      'Send confirmation email and invalidate the token',
    ],
    correctAnswer: [1, 0, 2, 3],
    explanation:
        'Receive first, then verify the token before doing anything — fail fast '
        'on invalid tokens. Then hash the password — never store plaintext. '
        'Then confirm and invalidate the token — single-use tokens prevent '
        'replay attacks. Security checks always come before business logic.',
    thinkingPattern: 'Security-First Ordering',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-002',
    date: '2026-03-19',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        "Users report that your app's login page loads slowly only on mobile, "
        'not desktop. Desktop and mobile hit the same server and the same '
        'database. The mobile network is also fine.\n\n'
        'What is the most likely cause?',
    options: [
      'The server processes mobile requests more slowly',
      'Mobile browsers load unnecessarily large resources (images, fonts, JS)',
      'The database queries are slower for mobile users',
      "The CDN doesn't cache mobile content",
    ],
    correctAnswer: 1,
    explanation:
        'Same server and database eliminates backend differences. '
        'The most common mobile-only slowness is front-end: large images not '
        'resized for small screens, web fonts, or JavaScript bundles not '
        'optimized for slower mobile CPUs. '
        'The fix is usually image optimization and code splitting.',
    thinkingPattern: 'Platform-Specific Debugging',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-002',
    date: '2026-03-20',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A function converts a decimal number to binary by repeatedly dividing '
        'by 2 and collecting remainders.\n\n'
        'Which input is most likely to cause unexpected behavior?',
    options: ['0', '128', '-5', '255'],
    correctAnswer: 2,
    explanation:
        'Positive integers and zero convert straightforwardly. Negative numbers '
        'require special handling — most naive implementations loop infinitely, '
        'produce wrong results, or rely on language-specific behavior for negative '
        "modulo. -5 in two's complement is completely different from just negating "
        "5's binary representation.",
    thinkingPattern: 'Sign Handling / Negative Number Edge Cases',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-003',
    date: '2026-03-21',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        "A user's profile photo is 4 MB. Your social app has 10 million users, "
        'and 80% have uploaded a photo.\n\n'
        'How much storage do you need for profile photos alone?',
    options: [
      'About 32 TB',
      'About 3.2 TB',
      'About 320 GB',
      'About 32 GB',
    ],
    correctAnswer: 0,
    explanation:
        '10,000,000 × 80% = 8,000,000 photos × 4 MB = 32,000,000 MB = 32 TB. '
        'This is before thumbnails, multiple resolutions, or redundancy. '
        'Real apps serve compressed versions (~100 KB for display) but store '
        'the original. Storage cost is typically the first scaling concern '
        'for media-heavy apps.',
    thinkingPattern: 'User-Scale Storage',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-002',
    date: '2026-03-22',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        "You're designing a system that must process tasks in the order they "
        'arrive, but high-priority tasks (like CRITICAL alerts) must jump '
        'ahead of normal tasks.\n\n'
        'Which data structure fits best?',
    options: [
      'Queue (FIFO)',
      'Stack (LIFO)',
      'Priority queue (min-heap)',
      'Circular buffer',
    ],
    correctAnswer: 2,
    explanation:
        'A plain queue is FIFO — tasks process in arrival order with no priority. '
        'A stack is LIFO — wrong order entirely. A circular buffer is a bounded '
        'queue with overwriting. A priority queue (typically implemented as a heap) '
        'dequeues by priority, not arrival order — perfect for job schedulers, '
        'OS process scheduling, and alert systems.',
    thinkingPattern: 'Priority Queue / Heap',
  ),

  // ── WEEK 3 (March 23–29, 2026) ─────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-003',
    date: '2026-03-23',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'In a team, everyone who writes tests also reviews code. '
        'Three people write tests: Ana, Ben, and Cal. '
        'Ben and Cal also deploy.\n\n'
        'Which of the following must be true?',
    options: [
      'Ana reviews code',
      'Ana deploys',
      'All code reviewers write tests',
      'Only Ben and Cal review code',
    ],
    correctAnswer: 0,
    explanation:
        '"Everyone who writes tests also reviews code." Ana writes tests, '
        'so Ana reviews code — direct modus ponens. Whether Ana deploys is unknown. '
        'Whether all code reviewers write tests is the converse and cannot be '
        'assumed. The rule runs one way only.',
    thinkingPattern: 'Modus Ponens / Logical Implication',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-003',
    date: '2026-03-24',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'A → Z, B → Y, C → X, D → ?\n\nWhat does D map to?',
    options: ['V', 'W', 'U', 'T'],
    correctAnswer: 1,
    explanation:
        'Each letter maps to its mirror in the alphabet: A(1)→Z(26), B(2)→Y(25), '
        'C(3)→X(24), D(4)→W(23). The rule is: position n maps to position (27 − n). '
        'This is a reflection — the alphabet folded in half.',
    thinkingPattern: 'Mirror / Complementary Mapping',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-003',
    date: '2026-03-25',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'You need to deploy a database schema migration in production with '
        'zero downtime. Arrange these steps from first to last:',
    options: [
      'Deploy new application code that reads both old and new schema',
      'Remove old columns and revert compatibility code',
      'Add new columns (nullable, with defaults)',
      'Backfill data in the new columns',
    ],
    correctAnswer: [2, 0, 3, 1],
    explanation:
        'The expand-contract pattern: add nullable columns first (no data loss), '
        'then deploy code that works with both schemas, then backfill existing '
        'data, finally remove old columns once all code uses the new schema. '
        'Skipping any step risks downtime or data loss.',
    thinkingPattern: 'Expand-Contract Migration',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-003',
    date: '2026-03-26',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'Your microservices system shows intermittent 500 errors occurring '
        "at exactly twice per hour. The errors don't correlate with "
        'traffic spikes.\n\n'
        'What does the pattern suggest?',
    options: [
      'A memory leak causing periodic crashes',
      'A scheduled job or cron task causing resource contention',
      'A network partition between data centers',
      'An external API rate limiting your requests',
    ],
    correctAnswer: 1,
    explanation:
        'Random errors correlate with load; memory leaks grow over time; '
        'network partitions are sustained. Errors at a fixed interval '
        '(twice per hour = every 30 minutes) strongly suggest a scheduled job — '
        'a cron task, cache flush, or report generation that competes for '
        'database locks at a predictable time.',
    thinkingPattern: 'Periodic Pattern Recognition',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-003',
    date: '2026-03-27',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A date parsing function works for all dates in 2024 but fails '
        'for one specific date when run in 2025.\n\n'
        'Which date is most likely to cause the bug?',
    options: [
      'January 1',
      'February 29',
      'December 31',
      'March 15',
    ],
    correctAnswer: 1,
    explanation:
        'February 29 only exists in leap years. A function tested in 2024 '
        '(a leap year) will fail in 2025 or 2026 (non-leap years) if it '
        'hardcodes February 29 as valid. Leap year calculations — divisible '
        'by 4, except centuries, except 400-year multiples — are a classic '
        'source of date bugs.',
    thinkingPattern: 'Leap Year / Calendar Edge Cases',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-004',
    date: '2026-03-28',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'A video streaming service has 1 million concurrent viewers, '
        'each watching at 5 Mbps.\n\n'
        'What is the total outbound bandwidth required?',
    options: ['5 Gbps', '50 Gbps', '500 Gbps', '5 Tbps'],
    correctAnswer: 3,
    explanation:
        '1,000,000 viewers × 5 Mbps = 5,000,000 Mbps = 5,000 Gbps = 5 Tbps. '
        'Delivering video at this scale requires CDNs with edge nodes in hundreds '
        'of locations — you cannot serve this from a single data center. '
        'Netflix reportedly uses ~15% of all internet traffic during peak hours.',
    thinkingPattern: 'Bandwidth at Scale',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-003',
    date: '2026-03-29',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A chat application needs to check, for 500 users at once, '
        'whether each user is currently online or offline.\n\n'
        'Which lookup structure gives the best performance?',
    options: [
      'A sorted array (binary search)',
      'A hash set',
      'A linked list',
      'A balanced binary search tree',
    ],
    correctAnswer: 1,
    explanation:
        'Online status is a membership query: "is user X online?" '
        'A hash set answers this in O(1) average time. '
        'A sorted array with binary search gives O(log n). '
        'A linked list is O(n). A BST is O(log n). '
        'For 500 simultaneous lookups, O(1) per lookup vs O(log 500) ≈ 9 '
        'comparisons each makes the hash set significantly faster.',
    thinkingPattern: 'Membership Testing / Hash Set',
  ),

  // ── WEEK 4 (March 30 – April 5, 2026) ──────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-004',
    date: '2026-03-30',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'You have 9 coins, one of which is heavier than the others. '
        'You have a balance scale that shows which side is heavier.\n\n'
        'What is the minimum number of weighings needed to guarantee finding '
        'the heavy coin?',
    options: ['1', '2', '3', '4'],
    correctAnswer: 1,
    explanation:
        'Split into 3 groups of 3. Weigh group 1 vs group 2. '
        "If balanced, the heavy coin is in group 3. If not, it's in the heavier "
        "group. You've narrowed it to 3 coins in 1 weighing. Now weigh 2 of those "
        '3 — if balanced, the third is heavy; if not, the heavier one is the answer. '
        'Total: 2 weighings.',
    thinkingPattern: 'Divide and Conquer',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-004',
    date: '2026-03-31',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'Look at this sequence:\n\n1, 2, 4, 7, 11, 16, 22, __\n\nWhat comes next?',
    options: ['28', '29', '30', '32'],
    correctAnswer: 1,
    explanation:
        'The differences between terms are: 1, 2, 3, 4, 5, 6 — each increases by 1. '
        'The next difference is 7, so 22 + 7 = 29. '
        'These are triangular numbers offset by 1: each term adds one more '
        'than the previous step.',
    thinkingPattern: 'Triangular Number Differences',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-004',
    date: '2026-04-01',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'Arrange these cache eviction policies from most to least aggressive '
        'about preserving recently-used items:',
    options: [
      'LRU — Least Recently Used',
      'FIFO — First In, First Out',
      'LFU — Least Frequently Used',
      'Random eviction',
    ],
    correctAnswer: [0, 2, 1, 3],
    explanation:
        'LRU directly prioritizes recency — the most recently used items survive '
        'longest. LFU keeps frequently used items but might evict a recent item '
        "that isn't frequent yet. FIFO only cares about insertion order, ignoring "
        'recency entirely. Random has no preference at all. '
        'LRU is the standard choice for web caches.',
    thinkingPattern: 'Cache Eviction Policy Comparison',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-004',
    date: '2026-04-02',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'A web app has 10 ms response time in staging and 400 ms in production. '
        'The code, database schema, and queries are identical.\n\n'
        "What's the most likely explanation?",
    options: [
      'Production has buggy code not present in staging',
      'The production database has significantly more data',
      'Staging uses faster hardware',
      'Production has a different programming language runtime',
    ],
    correctAnswer: 1,
    explanation:
        'Same code, same schema, same queries — but different data volume. '
        'Queries that perform well on 1,000 rows (staging) can be 40× slower '
        'on 1,000,000 rows (production) without an index or with a full table scan. '
        'This is one of the most common causes of "works in staging, slow in prod."',
    thinkingPattern: 'Environment Difference Analysis',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-004',
    date: '2026-04-03',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A string contains bytes that may be ASCII or multi-byte UTF-8 '
        'characters. A function calculates "length" using byte count.\n\n'
        'Which input reveals this bug?',
    options: ['"Hello"', '"Héllo"', '"Hello World"', '"12345"'],
    correctAnswer: 1,
    explanation:
        '"Héllo" contains \'é\' which is 2 bytes in UTF-8. A byte-counting '
        'length function returns 6 for "Héllo" (5 characters), while a '
        'character-counting function returns 5. This matters for truncation '
        '(truncating mid-character corrupts the string), display width, and '
        'array indexing. Pure ASCII inputs always produce matching byte and '
        'character counts.',
    thinkingPattern: 'String Encoding / Byte vs. Character',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-005',
    date: '2026-04-04',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        "You're building a hash table for 1 million keys. The table is kept "
        '70% full to maintain performance. Each entry stores an 8-byte key '
        'and an 8-byte value.\n\n'
        'How much memory does the table use?',
    options: ['About 11 MB', 'About 22 MB', 'About 110 MB', 'About 220 MB'],
    correctAnswer: 1,
    explanation:
        '1M entries at 70% load → table has 1M ÷ 0.7 ≈ 1.43M slots. '
        'Each slot: 8 + 8 = 16 bytes. 1.43M × 16 bytes ≈ 22.8 MB. '
        'Hash tables trade memory for O(1) lookup — the 30% empty slots '
        'are the cost of that constant-time access.',
    thinkingPattern: 'Memory Estimation / Load Factor',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-004',
    date: '2026-04-05',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A web server receives HTTP requests and must match each URL path to a '
        'handler function. Paths include wildcards like "/users/:id/posts".\n\n'
        'Which structure is most suitable?',
    options: [
      'A hash map from path string to handler',
      'A radix tree (compressed trie)',
      'A sorted list of paths',
      'A regular expression list scanned linearly',
    ],
    correctAnswer: 1,
    explanation:
        "A plain hash map can't handle wildcards or dynamic segments. "
        'A regex list is O(n) per request — too slow for high-traffic servers. '
        'A sorted list requires exact matches. A radix tree (used by routers '
        'like httprouter and Gin) stores path segments as tree nodes, supporting '
        'parameter extraction and wildcard matching in O(k) time where k is '
        'the segment count.',
    thinkingPattern: 'Radix Tree / Router Design',
  ),

  // ── WEEK 5 (April 6–12, 2026) ──────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-005',
    date: '2026-04-06',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'Five tasks must run in a pipeline. Task C cannot run until both A '
        'and B complete. Task D cannot run until C completes. Task E can run '
        'at any time but must finish before D starts.\n\n'
        'What is the minimum number of sequential stages needed?',
    options: ['2', '3', '4', '5'],
    correctAnswer: 1,
    explanation:
        'Stage 1: A, B, and E can all run in parallel. '
        'Stage 2: C runs (A and B are done; E must also be done by now). '
        'Stage 3: D runs (C and E are both complete). '
        'Three stages total — any fewer would violate a dependency.',
    thinkingPattern: 'Dependency Graph / Critical Path',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-005',
    date: '2026-04-07',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt:
        'A function f is applied repeatedly, starting with 2:\n\n'
        'f(x) = multiply by 3, then subtract 1\n\n'
        '2 → 5 → 14 → 41 → ?\n\nWhat comes next?',
    options: ['82', '122', '161', '242'],
    correctAnswer: 1,
    explanation:
        '41 × 3 = 123; 123 − 1 = 122. '
        'Each application: multiply by 3, then subtract 1. '
        'This is a linear recurrence f(n) = 3×f(n−1) − 1. '
        'Recognizing the rule from a few examples is the key skill.',
    thinkingPattern: 'Recurrence Relation',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-005',
    date: '2026-04-08',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'Arrange these array operations by their average time complexity, '
        'from fastest to slowest (for an array of n elements):',
    options: [
      'Finding the minimum value in an unsorted array',
      'Accessing an element by index',
      'Sorting the array with merge sort',
      'Finding all pairs that sum to a target value',
    ],
    correctAnswer: [1, 0, 2, 3],
    explanation:
        'Index access is O(1) — instant regardless of size. '
        'Finding minimum requires scanning all elements: O(n). '
        'Merge sort divides and conquers: O(n log n). '
        'Finding all pairs requires comparing every pair: O(n²) naively. '
        'Understanding these tiers helps predict where performance will hurt.',
    thinkingPattern: 'Algorithmic Complexity Ordering',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-005',
    date: '2026-04-09',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'A mobile app crashes only when the device is in low-memory mode. '
        'The crash occurs in a function that reads a large JSON file.\n\n'
        'What is the best architectural fix?',
    options: [
      "Increase the app's memory limit in the manifest",
      'Stream and parse the JSON file in chunks rather than loading it all at once',
      'Compress the JSON file to reduce its size',
      'Cache the parsed result permanently in local storage',
    ],
    correctAnswer: 1,
    explanation:
        "Increasing memory limits doesn't solve the root problem and harms "
        'battery performance. Compression reduces disk size but still requires '
        'full decompression in memory. Caching helps on subsequent reads but not '
        'the first. Streaming is the correct fix: process data incrementally, '
        'never holding the entire file in memory at once.',
    thinkingPattern: 'Resource-Constrained Design',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-005',
    date: '2026-04-10',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A function returns the second-largest number in a list.\n\n'
        'Which input is most likely to reveal a bug?',
    options: [
      '[5, 3, 8, 1, 9]',
      '[7, 7, 7, 7]',
      '[1, 2]',
      '[100, -50, 0]',
    ],
    correctAnswer: 1,
    explanation:
        'When all elements are equal, what is the "second largest"? '
        'Is it the same as the largest, or undefined? A common buggy implementation '
        'removes the maximum and returns the new maximum — returning 7 even though '
        'there\'s no meaningful "second" value. The behavior for all-equal inputs '
        'is often unspecified, making it the most revealing edge case.',
    thinkingPattern: 'Duplicate Values / Ambiguous Specification',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-006',
    date: '2026-04-11',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'A city has 1 million people. On average, each person sends 50 texts '
        'per day. Each text is 160 bytes.\n\n'
        'What is the daily data volume for all texts combined?',
    options: ['About 8 GB', 'About 80 GB', 'About 800 GB', 'About 8 TB'],
    correctAnswer: 0,
    explanation:
        '1,000,000 × 50 × 160 bytes = 8,000,000,000 bytes = 8 GB. '
        'Text is surprisingly compact — the same city streaming 1080p video '
        'for an hour would generate orders of magnitude more data. '
        'This is why SMS infrastructure handles enormous message volumes '
        'on relatively modest hardware.',
    thinkingPattern: 'Text vs. Media Volume',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-005',
    date: '2026-04-12',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        "You're implementing an undo system for a text editor. Each action "
        'can be undone in reverse order. The most recent action is undone first.\n\n'
        'Which data structure is the natural fit?',
    options: ['Queue', 'Stack', 'Doubly linked list', 'Circular buffer'],
    correctAnswer: 1,
    explanation:
        'Undo is Last In, First Out: the most recently performed action is the '
        "first to undo. A stack is exactly this — push actions as they're "
        'performed, pop to undo. For undo+redo, two stacks are used: one for '
        'undo history and one for redo history.',
    thinkingPattern: 'Stack / LIFO Applications',
  ),

  // ── WEEK 6 (April 13–19, 2026) ─────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-006',
    date: '2026-04-13',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'A logic gate outputs 1 only when its two inputs differ — this is an '
        'XOR gate. You have two XOR gates and one NOT gate.\n\n'
        'Which of these can you build from those components?',
    options: [
      'AND gate',
      'OR gate',
      'XNOR gate (outputs 1 when inputs are equal)',
      'NAND gate',
    ],
    correctAnswer: 2,
    explanation:
        "NOT(XOR(A, B)) gives 1 when A and B are equal — that's XNOR. "
        'XOR outputs 1 when inputs differ; NOT inverts this to give 1 when '
        "they're the same. An AND or OR gate requires different combinations "
        'of gates. This is the key insight: inversion turns XOR into XNOR.',
    thinkingPattern: 'Logical Composition',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-006',
    date: '2026-04-14',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt:
        'Monday → 6, Tuesday → 7, Wednesday → 9, Thursday → 8, Friday → 6\n\n'
        'What does Saturday map to?',
    options: ['6', '7', '8', '9'],
    correctAnswer: 2,
    explanation:
        'Count the letters in each day name: '
        'Monday(6), Tuesday(7), Wednesday(9), Thursday(8), Friday(6), Saturday(8). '
        'The rule is hidden: each day maps to the number of letters in its name. '
        'Pattern recognition often requires looking past the obvious numbers '
        'to find what they represent.',
    thinkingPattern: 'Hidden Rule Discovery',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-006',
    date: '2026-04-15',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'A critical bug is found in production. '
        'Arrange these incident response steps in the correct order:',
    options: [
      'Identify the root cause in the code',
      'Restore service (rollback or hotfix)',
      'Write a post-mortem document',
      'Alert the on-call team',
    ],
    correctAnswer: [3, 1, 0, 2],
    explanation:
        'In an incident, priority is: (1) Alert people who can help, '
        '(2) Restore service — users first, (3) Find root cause once stable, '
        '(4) Document learnings. Trying to find the root cause before restoring '
        'service extends the outage. Post-mortems happen after the fire is out.',
    thinkingPattern: 'Incident Response Priority',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-006',
    date: '2026-04-16',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'Your team has 5 developers and ships 3 features per week. '
        'You double the team to 10 developers. After one month, '
        'you still ship only 3 features per week.\n\n'
        'What is the most likely bottleneck?',
    options: [
      'The developers are not working efficiently',
      'Code review, testing, or deployment pipeline capacity',
      'Feature requirements are not clear enough',
      'The codebase is too large for the team to navigate',
    ],
    correctAnswer: 1,
    explanation:
        "This is Brooks' Law: adding people doesn't linearly increase output. "
        'The constraint shifted from writing code to everything else — code review '
        'queue, CI/CD pipeline capacity, deployment frequency, or QA cycles. '
        'The fix is process automation, not more headcount.',
    thinkingPattern: "Amdahl's Law / Bottleneck Shift",
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-006',
    date: '2026-04-17',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A recursive function computes the sum of a nested list: '
        '[[1, [2, 3]], [4, 5]].\n\n'
        'Which input is most likely to cause a stack overflow?',
    options: [
      'A list 10,000 levels deep: [[[...[1]...]]]',
      'A flat list with 1,000,000 elements',
      'A list containing the same element 1,000 times',
      'A list with mixed types: [1, "a", [2]]',
    ],
    correctAnswer: 0,
    explanation:
        'Recursion depth is limited by the call stack size (typically 1,000–10,000 '
        'frames). A flat list with a million elements uses a loop — O(n) memory, '
        'no deep stack. A deeply nested structure requires one stack frame per '
        'nesting level. A list 10,000 levels deep will crash most runtimes. '
        'The fix is an iterative approach with an explicit stack.',
    thinkingPattern: 'Recursion Depth / Stack Overflow',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-007',
    date: '2026-04-18',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'A server handles 1,000 concurrent connections. Each request takes '
        '200 ms on average to process.\n\n'
        "What is the server's maximum throughput in requests per second?",
    options: ['200 req/s', '1,000 req/s', '5,000 req/s', '200,000 req/s'],
    correctAnswer: 2,
    explanation:
        "By Little's Law: throughput = concurrency ÷ latency = "
        '1,000 ÷ 0.2 seconds = 5,000 req/s. '
        'This is one of the most useful equations in systems engineering. '
        'Doubling throughput requires either doubling concurrency or halving '
        'latency — and latency is usually the harder variable to change.',
    thinkingPattern: "Little's Law",
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-006',
    date: '2026-04-19',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A social network stores friendship connections. You need to find '
        'if two users are connected within 3 degrees (friend, '
        'friend-of-friend, or friend-of-friend-of-friend).\n\n'
        'Which algorithm on which structure solves this?',
    options: [
      'Binary search on a sorted friend list',
      'BFS up to depth 3 on a graph',
      'DFS on a tree of connections',
      'Linear scan of all user pairs',
    ],
    correctAnswer: 1,
    explanation:
        'Friendships form a graph (not a tree — cycles exist). BFS explores '
        'nodes level by level: depth 1 (friends), depth 2, depth 3. Stopping '
        'at depth 3 bounds the search. DFS would dive deep on one path and '
        'miss nearby connections. Binary search handles sorted data, not graph '
        'traversal. Linear scan is O(n²) — too slow.',
    thinkingPattern: 'BFS / Graph Traversal',
  ),

  // ── WEEK 7 (April 20–26, 2026) ─────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-007',
    date: '2026-04-20',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'Sherlock notices three clues: (1) The window was broken from outside. '
        "(2) The suspect's shoes are dry. (3) It rained all night.\n\n"
        'What can Sherlock most reliably deduce?',
    options: [
      'The suspect did not come through the window',
      'The suspect was inside before it started raining',
      'The suspect is innocent',
      'The window was broken by someone else entirely',
    ],
    correctAnswer: 0,
    explanation:
        "The window was broken from outside; it rained all night; the suspect's "
        'shoes are dry. Anyone walking outside would have wet shoes. '
        "Dry shoes → didn't walk through rain → didn't approach from outside → "
        "didn't break the window via this path. "
        'Deduction is narrow: we can only conclude what the evidence directly supports.',
    thinkingPattern: 'Abductive Reasoning',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-007',
    date: '2026-04-21',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'Look at this sequence:\n\n3, 6, 11, 18, 27, 38, __\n\nWhat comes next?',
    options: ['47', '51', '53', '55'],
    correctAnswer: 1,
    explanation:
        'The differences between terms are: 3, 5, 7, 9, 11 — consecutive odd numbers. '
        'The next difference is 13, so 38 + 13 = 51. '
        'When differences form a simple arithmetic progression, '
        'the second-order analysis reveals the pattern.',
    thinkingPattern: 'Odd-Number Differences',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-007',
    date: '2026-04-22',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        "You're implementing authentication middleware. "
        'Arrange these checks from first (done on every request) to last '
        '(most specific, done least often):',
    options: [
      'Validate the JWT signature and expiry',
      'Check the user has permission for the specific resource',
      'Rate-limit the request by IP address',
      'Log the access for audit purposes',
    ],
    correctAnswer: [2, 0, 1, 3],
    explanation:
        "Rate limiting first — it's cheapest and blocks brute force before "
        'any expensive work. JWT validation next (rejects invalid tokens early). '
        'Permission check after (may need a DB lookup). '
        'Logging last — after the request succeeds, or always non-blocking. '
        'Order minimizes wasted work on invalid requests.',
    thinkingPattern: 'Security Middleware Ordering',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-007',
    date: '2026-04-23',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'An e-commerce site handles 1,000 orders per day normally. '
        'On a sale day it receives 50,000 orders — a 50× spike — and crashes.\n\n'
        'Which component is most likely the first to fail?',
    options: [
      'The frontend web server',
      'The database',
      'The payment processing service',
      'The CDN (Content Delivery Network)',
    ],
    correctAnswer: 1,
    explanation:
        'CDNs scale horizontally by design. Web servers replicate easily behind '
        'a load balancer. Payment processors (Stripe, etc.) handle volume '
        "independently. The database is almost always the bottleneck — it's "
        'stateful. You cannot spin up more replicas without careful coordination. '
        'Database connection pools, write throughput, and lock contention hit '
        'limits first.',
    thinkingPattern: 'Scalability Bottleneck Identification',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-007',
    date: '2026-04-24',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A rate limiter allows 100 requests per minute. A client sends 100 '
        'requests in the last second of minute 1, then 100 more in the first '
        'second of minute 2.\n\n'
        'How many requests does a fixed-window rate limiter allow through?',
    options: ['100', '150', '200', '0'],
    correctAnswer: 2,
    explanation:
        'A fixed-window rate limiter resets its counter at minute boundaries. '
        '100 requests in the last second of minute 1 (under the limit) + '
        '100 requests in the first second of minute 2 (fresh window) = '
        '200 requests in 2 seconds, despite a "100 per minute" limit. '
        'This boundary burst exploit is why sliding-window rate limiters exist.',
    thinkingPattern: 'Window Boundary / Rate Limiting',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-008',
    date: '2026-04-25',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'Your team of 8 engineers ships features averaging 500 lines of code '
        'each. The team ships 10 features per sprint over 26 sprints per year.\n\n'
        'How many lines does the codebase grow per year?',
    options: [
      'About 13,000 lines',
      'About 130,000 lines',
      'About 1.3 million lines',
      'About 13 million lines',
    ],
    correctAnswer: 1,
    explanation:
        '10 features × 500 lines × 26 sprints = 130,000 lines per year. '
        "Large companies' codebases grow by millions of lines annually. "
        'But good teams also delete code — net lines added is often negative '
        'in mature systems as refactoring simplifies complexity.',
    thinkingPattern: 'Codebase Growth Rate',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-007',
    date: '2026-04-26',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A log processing system receives millions of events per second and needs '
        'to count unique IP addresses seen in the last hour. '
        'Exact precision is not required — 1% error is acceptable.\n\n'
        "What's the most memory-efficient solution?",
    options: [
      'A hash set of all IP addresses seen',
      'A HyperLogLog probabilistic counter',
      'A sorted array of all IPs',
      'A Bloom filter',
    ],
    correctAnswer: 1,
    explanation:
        'A hash set of millions of IPs uses gigabytes. A sorted array is worse. '
        'A Bloom filter tests membership but does not count distinct items. '
        'HyperLogLog uses a fixed ~12 KB of memory to count billions of distinct '
        'elements with ~1% error — exactly this use case. '
        "Redis's PFCOUNT command uses HyperLogLog for precisely this purpose.",
    thinkingPattern: 'Probabilistic Data Structures / HyperLogLog',
  ),

  // ── WEEK 8 (April 27 – May 3, 2026) ────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-008',
    date: '2026-04-27',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'Four lights are in a row, all starting OFF. You can toggle any two '
        'adjacent lights at once.\n\n'
        'Which state is impossible to reach?',
    options: [
      '[ON, ON, OFF, OFF]',
      '[OFF, ON, ON, ON]',
      '[ON, OFF, OFF, ON]',
      '[ON, ON, ON, ON]',
    ],
    correctAnswer: 1,
    explanation:
        'Each toggle flips exactly 2 lights — changing the total ON count by '
        '0 or ±2. Starting from 0 ON lights (even), you can only ever have an '
        'even number of ON lights. [OFF, ON, ON, ON] has 3 — an odd number — '
        'so it can never be reached. This is an invariant: parity of ON count '
        'is always even.',
    thinkingPattern: 'Invariant Analysis',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-008',
    date: '2026-04-28',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'RED → 27, BLUE → 40, GREEN → ?\n\nWhat does GREEN map to?',
    options: ['42', '47', '49', '52'],
    correctAnswer: 2,
    explanation:
        'Sum the alphabetical positions of each letter: '
        'R(18)+E(5)+D(4)=27; B(2)+L(12)+U(21)+E(5)=40; '
        'G(7)+R(18)+E(5)+E(5)+N(14)=49. '
        'The rule encodes each word as the sum of its letter values — '
        'a common cipher used in puzzles and interview questions.',
    thinkingPattern: 'Letter-to-Number Encoding',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-008',
    date: '2026-04-29',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        "You're reviewing a pull request. "
        'Arrange these review steps in a logical order:',
    options: [
      'Check that tests exist and pass',
      'Read the PR description and understand the goal',
      'Look for security vulnerabilities',
      'Verify the code style and naming conventions',
    ],
    correctAnswer: [1, 0, 2, 3],
    explanation:
        'Start with understanding what the change does (context first). '
        'Then check tests — if there are none, the review is incomplete. '
        'Security issues trump style. Style and naming matters but comes last — '
        'never block a PR for style if security or correctness are the issue.',
    thinkingPattern: 'Review Priority Ordering',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-008',
    date: '2026-04-30',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'Users report that search results are always one day behind — items '
        "added today don't appear until tomorrow.\n\n"
        "What's the most likely architecture?",
    options: [
      'The search index is rebuilt by a nightly batch job',
      'The search database has a 24-hour replication lag',
      'The CDN caches search results for 24 hours',
      'The application has a 24-hour search result cache',
    ],
    correctAnswer: 0,
    explanation:
        'The "exactly one day behind" pattern is the signature of a scheduled ETL '
        'or indexing job that runs at midnight, rebuilding the search index from '
        'scratch. CDN caches and application caches are usually shorter-lived. '
        'Real-time search requires event-driven indexing instead of batch rebuilds.',
    thinkingPattern: 'Batch vs. Real-time Architecture',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-008',
    date: '2026-05-01',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'In most languages, 0.1 + 0.2 evaluates to 0.30000000000000004 '
        'due to floating-point representation.\n\n'
        'Which approach correctly handles money calculations?',
    options: [
      'Use integer arithmetic (store amounts in cents)',
      'Round the result before every operation: round(0.1 + 0.2, 2)',
      'Use string comparison instead of numeric comparison',
      'Multiply all values by 1,000 before doing arithmetic',
    ],
    correctAnswer: 0,
    explanation:
        'Floating-point cannot exactly express 0.1 or 0.2 in binary. '
        'Rounding fixes display but not computation — errors compound across '
        'multiple operations. Multiplying by 1,000 has the same floating-point '
        'issue. The correct solution: store monetary values in the smallest unit '
        '(cents), do all arithmetic as integers, and only format as decimal '
        'for display.',
    thinkingPattern: 'Floating-Point Precision',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-009',
    date: '2026-05-02',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'A service makes 3 network calls to downstream APIs per request. '
        'Each call has 20 ms average latency. The service adds 5 ms of '
        'processing overhead.\n\n'
        'What is the total response time if calls are made sequentially?',
    options: ['25 ms', '45 ms', '65 ms', '85 ms'],
    correctAnswer: 2,
    explanation:
        'Sequential: 3 × 20 ms + 5 ms = 65 ms. '
        'If calls were parallelized (made concurrently), it would be 20 ms + 5 ms '
        '= 25 ms. This is why parallel I/O matters — sequential API calls are '
        'one of the most common causes of unexpectedly high latency. '
        'Libraries like Promise.all() and asyncio.gather() exist for exactly this.',
    thinkingPattern: 'Sequential vs. Parallel I/O Latency',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-008',
    date: '2026-05-03',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A calendar app stores events and must quickly find all events '
        'in a given date range (e.g., "show me all of July").\n\n'
        'Which data structure best supports range queries?',
    options: [
      'Hash map keyed by event ID',
      'Array sorted by start date',
      'B-tree or balanced BST keyed by date',
      'Linked list in insertion order',
    ],
    correctAnswer: 2,
    explanation:
        'A hash map has no concept of order — range queries require a full scan. '
        'A linked list is O(n). A sorted array allows binary search but '
        'insertions are O(n). A B-tree maintains sorted order with O(log n) '
        'inserts and O(log n + k) range queries, where k is the result count. '
        'This is why virtually every database date index is a B-tree.',
    thinkingPattern: 'Range Queries / B-tree',
  ),

  // ── WEEK 9 (May 4–10, 2026) ────────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-009',
    date: '2026-05-04',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'An API returns success for requests under 100 ms and times out '
        'otherwise. Under load, 70% of requests succeed and 30% time out. '
        'You add one retry for timed-out requests, with independent probability.\n\n'
        'What is the new overall failure rate?',
    options: ['9%', '21%', '30%', '0.3%'],
    correctAnswer: 0,
    explanation:
        '30% fail initially. Of those 30% that retry, 30% fail again. '
        'Total failure = 30% × 30% = 9%. Each retry multiplies the failure rate '
        'by the original probability. One retry reduces failures by ~3.3×. '
        'Two retries would give 0.9% — but also triple your traffic.',
    thinkingPattern: 'Probability Chains / Retry Logic',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-009',
    date: '2026-05-05',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt:
        'A function f is defined for powers of 2:\n\n'
        'f(1) = 1, f(2) = 3, f(4) = 7, f(8) = 15\n\n'
        'What is f(16)?',
    options: ['24', '28', '31', '32'],
    correctAnswer: 2,
    explanation:
        'f(1) = 2¹−1 = 1, f(2) = 2²−1 = 3, f(4) = 2³−1 = 7, f(8) = 2⁴−1 = 15, '
        'f(16) = 2⁵−1 = 31. '
        'The pattern: f(2^k) = 2^(k+1) − 1. '
        'This function counts the total nodes in a full binary tree of depth k.',
    thinkingPattern: 'Powers of 2 / Full Binary Tree',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-009',
    date: '2026-05-06',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'A database query runs slowly. Rank these optimization approaches '
        'from quickest win (lowest effort, highest impact) to most effort:',
    options: [
      'Add a database index on the most-queried column',
      'Rewrite the service in a faster programming language',
      'Add an in-memory cache for repeated identical queries',
      'Refactor the data model to eliminate the query entirely',
    ],
    correctAnswer: [0, 2, 3, 1],
    explanation:
        'A database index is a single command and immediately speeds up queries. '
        'Caching requires code changes but is still fast to implement. '
        'Refactoring the data model requires design work but can eliminate the '
        'problem entirely. Rewriting in another language is almost never the '
        'right fix — the bottleneck is rarely the language.',
    thinkingPattern: 'Effort / Impact Prioritization',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-009',
    date: '2026-05-07',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'A payment API returns "success" but money is sometimes not transferred. '
        'The issue happens about 0.1% of the time.\n\n'
        "What's the most likely root cause?",
    options: [
      'The API has a bug in its success response code',
      'A network timeout causes the response to be lost after the transaction completes',
      'The payment processor rejects some transactions silently',
      'A race condition in your database transaction',
    ],
    correctAnswer: 1,
    explanation:
        'This is the classic distributed systems problem: the transaction succeeds '
        'on the payment processor, but the network drops the response before your '
        'server receives it. Your server retries or returns an error, unaware the '
        'money already moved. The fix is idempotency keys — a unique ID with each '
        "payment request so retries don't double-charge.",
    thinkingPattern: 'Distributed Systems / Idempotency',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-009',
    date: '2026-05-08',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A URL shortener generates IDs by incrementing a counter: '
        '/abc1, /abc2, /abc3... The redirect function looks up the ID '
        'in a database.\n\n'
        'Which input to the redirect function is most dangerous to handle naively?',
    options: [
      'A valid short URL that has expired',
      'A very long input string (10,000 characters)',
      "An ID with SQL characters: /abc'; DROP TABLE urls;--",
      'A non-existent ID like /zzz9',
    ],
    correctAnswer: 2,
    explanation:
        'Expired or non-existent IDs just return 404. Very long inputs may cause '
        'performance issues. But naively interpolating user input into a SQL query '
        'opens SQL injection — an attacker can read, modify, or delete your database. '
        'Even for a "simple" URL lookup, always use parameterized queries.',
    thinkingPattern: 'Input Sanitization / SQL Injection',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-010',
    date: '2026-05-09',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'A Redis cache stores session data for 500,000 active users. '
        'Each session is 2 KB. Redis uses approximately 4× the raw data '
        'size due to its data structure overhead.\n\n'
        'How much RAM does Redis need?',
    options: ['1 GB', '2 GB', '4 GB', '8 GB'],
    correctAnswer: 2,
    explanation:
        '500,000 × 2 KB = 1 GB raw. × 4 overhead ≈ 4 GB. '
        'Redis stores everything in RAM, so memory planning is critical. '
        'Real overhead varies (2–10×) depending on data type and key count. '
        'This is why Redis Cluster exists — distributing memory across nodes.',
    thinkingPattern: 'Memory Overhead / Cache Sizing',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-009',
    date: '2026-05-10',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A spell checker needs to suggest corrections for misspelled words. '
        'It must find all dictionary words within edit distance 1 '
        '(one insertion, deletion, or substitution).\n\n'
        'Which data structure allows efficient fuzzy matching?',
    options: [
      'Hash map (exact match only)',
      'BK-tree (Burkhard-Keller tree)',
      'Binary search tree sorted alphabetically',
      'Array scanned with Levenshtein distance',
    ],
    correctAnswer: 1,
    explanation:
        'A hash map requires exact matches. A BST sorts alphabetically, not by '
        'similarity. An array with Levenshtein distance works but is O(n × word '
        'length) — scanning all words. A BK-tree organizes words by their pairwise '
        'edit distances, allowing pruning: branches where stored distance is '
        'outside d±1 of your target are skipped entirely.',
    thinkingPattern: 'Metric Space / BK-tree',
  ),

  // ── WEEK 10 (May 11–17, 2026) ──────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-010',
    date: '2026-05-11',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        "You're debugging a production issue. A change was deployed 3 hours ago. "
        'CPU usage spiked 2 hours ago. Users started complaining 1 hour ago.\n\n'
        'What does the timeline most strongly suggest?',
    options: [
      'The deployment caused the issue immediately',
      'The deployment likely caused the issue, but with a delay',
      'The deployment is probably unrelated to the issue',
      'The CPU spike is unrelated to user complaints',
    ],
    correctAnswer: 1,
    explanation:
        'The sequence — deploy → CPU spike → user impact — is a classic cascade. '
        'Deployments that cause memory leaks, inefficient queries, or cache '
        'invalidation often show delayed symptoms. The 1-hour gap between CPU '
        'spike and user complaints is typical of gradual resource exhaustion. '
        'Ruling out the deployment requires actively eliminating it.',
    thinkingPattern: 'Causal Reasoning / Timeline Analysis',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-010',
    date: '2026-05-12',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'Look at this sequence:\n\n1, 11, 21, 1211, 111221, __\n\nWhat comes next?',
    options: ['312211', '312221', '211211', '1211221'],
    correctAnswer: 0,
    explanation:
        'Each term describes the previous one aloud. "1" = one 1. '
        '"11" = two 1s. "21" = one 2, one 1. "1211" = one 1, one 2, two 1s. '
        '"111221" = three 1s, two 2s, one 1. "312211" = one 3, one 1, two 2s, '
        'two 1s. This is the Look-and-Say sequence — a self-describing pattern.',
    thinkingPattern: 'Look-and-Say / Self-describing Sequences',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-010',
    date: '2026-05-13',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        "You're implementing a feature using TDD (Test-Driven Development). "
        'Arrange these steps in the correct TDD order:',
    options: [
      'Write the implementation code to make the test pass',
      'Write a failing test for the desired behavior',
      'Refactor the code while keeping tests green',
      'Run the full test suite to confirm nothing broke',
    ],
    correctAnswer: [1, 0, 3, 2],
    explanation:
        'Red → Green → Refactor: write a test that fails (confirms the test '
        'actually tests something), write minimal code to make it pass, run the '
        'full suite to confirm nothing broke, then refactor for quality while '
        "keeping tests green. TDD's discipline prevents tests written after-the-fact "
        'where confirmation bias might make them pass trivially.',
    thinkingPattern: 'TDD / Red-Green-Refactor',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-010',
    date: '2026-05-14',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        "Your app's p99 latency (slowest 1% of requests) is 8 seconds, "
        'while p50 (median) is 80 ms and p95 is 200 ms.\n\n'
        "What's the most likely explanation for the p99 spike?",
    options: [
      'The server is generally slow and needs more CPU',
      'A small set of requests hits a slow code path or missing index',
      'The CDN is misconfigured for 1% of users',
      'Network congestion affects 1% of geographic regions',
    ],
    correctAnswer: 1,
    explanation:
        'P50 = 80 ms is healthy. P95 = 200 ms is slightly elevated. '
        'P99 = 8 seconds is 100× the median — a dramatic tail spike. '
        'This "long tail" pattern is almost always a specific slow code path: '
        'a missing index on a rarely-used filter, a synchronous external call, '
        'or a lock that occasionally blocks. Geographic and CDN issues would '
        'show sustained latency for affected users, not a tail spike.',
    thinkingPattern: 'Latency Distribution Analysis',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-010',
    date: '2026-05-15',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A function sends a welcome email when a user registers. '
        'Which scenario reveals a missing idempotency check?',
    options: [
      'The user registers with an invalid email address',
      'The registration request is sent twice due to a network retry',
      'The user registers with an already-existing email address',
      'The email server is temporarily unavailable',
    ],
    correctAnswer: 1,
    explanation:
        'A non-idempotent registration flow will send two welcome emails if '
        'the client retries after a network timeout. The registration may have '
        "succeeded, but the client didn't receive the response. Without an "
        'idempotency key or unique constraint check, the second request triggers '
        'a duplicate. Always design writes to be safe to retry.',
    thinkingPattern: 'Idempotency / Network Retry',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-011',
    date: '2026-05-16',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'A mobile app makes a background sync every 5 minutes. '
        'Each sync transmits 10 KB of data.\n\n'
        'How much background data does the app consume in one year?',
    options: ['About 1 GB', 'About 1.5 GB', 'About 100 MB', 'About 10 MB'],
    correctAnswer: 0,
    explanation:
        '60 min ÷ 5 min = 12 syncs/hour × 24 h × 365 days = 105,120 syncs/year '
        '× 10 KB ≈ 1 GB. This is why iOS and Android have background app refresh '
        'controls — frequent background sync is a major contributor to data plan '
        'usage and battery drain.',
    thinkingPattern: 'Periodic Task Accumulation',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-010',
    date: '2026-05-17',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A recommendation engine needs to frequently find the top 10 '
        'most-viewed items out of 10 million. Views are updated constantly.\n\n'
        'Which approach is most efficient?',
    options: [
      'Sort all 10 million items after every update',
      'Maintain a min-heap of size 10',
      'Scan all items on each query to find the top 10',
      'Store all items in a sorted array',
    ],
    correctAnswer: 1,
    explanation:
        'Sorting 10M items after every update is O(n log n) per update — too slow. '
        'Full scan per query is O(n) per read. A min-heap of size 10 tracks the '
        'top-k in O(log 10) = O(1) per update: when a new view count exceeds the '
        "heap's minimum, swap it in. This is the standard top-k algorithm.",
    thinkingPattern: 'Top-K Problem / Min-Heap',
  ),

  // ── WEEK 11 (May 18–24, 2026) ──────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-011',
    date: '2026-05-18',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'A and B are booleans. The expression (A && !B) || (!A && B) is true.\n\n'
        'Which additional fact lets you conclude that A is true?',
    options: ['B is false', 'B is true', 'A || B is true', 'A && B is false'],
    correctAnswer: 0,
    explanation:
        'The expression is XOR: true when exactly one of A or B is true. '
        'If B is false, XOR(A, false) = A — so A must be true for XOR to hold. '
        'If B is true, XOR(A, true) means A must be false. '
        'Knowing B is false is the additional fact that pins A to true.',
    thinkingPattern: 'Boolean Algebra / XOR',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-011',
    date: '2026-05-19',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'O, T, T, F, F, S, S, E, N, T, __\n\nWhat comes next?',
    options: ['E', 'N', 'T', 'O'],
    correctAnswer: 0,
    explanation:
        'These are the first letters of the counting words: One, Two, Three, Four, '
        'Five, Six, Seven, Eight, Nine, Ten, Eleven. The 11th term is E (Eleven). '
        'The pattern is hidden in language, not math — a reminder that '
        'sequences can encode information in unexpected ways.',
    thinkingPattern: 'Alphabetical Encoding / Ordinal Words',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-011',
    date: '2026-05-20',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt: 'Arrange these steps for publishing an npm package in the correct order:',
    options: [
      'Tag the git commit with the version number',
      'Update the version in package.json',
      'Run the test suite',
      'Run npm publish',
    ],
    correctAnswer: [2, 1, 0, 3],
    explanation:
        "Tests first (don't publish broken code). Bump the version (establishes "
        "what you're releasing). Tag the commit (links code to version permanently). "
        'Publish last — once published, a version cannot be retracted or overwritten '
        'on npm. The tag ensures the published code is recoverable forever.',
    thinkingPattern: 'Release Process Ordering',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-011',
    date: '2026-05-21',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        "You're designing a URL shortener that must be highly available. "
        'The service creates short URLs that redirect to long ones.\n\n'
        'Which operation should you optimize for first?',
    options: [
      'Reads (redirecting short URLs to long URLs)',
      'Writes (creating new short URLs)',
      'The ID generation algorithm for new short URLs',
      'Long-term archival storage of URL mappings',
    ],
    correctAnswer: 0,
    explanation:
        'URL shorteners have extremely asymmetric traffic: millions of people '
        'click a short link (reads) for every one person who creates it (write). '
        'Optimizing read throughput — with caching at every layer — has the '
        'highest impact. Reads should be served from memory, not disk. '
        'Writes can tolerate higher latency.',
    thinkingPattern: 'Read-Heavy vs. Write-Heavy Systems',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-011',
    date: '2026-05-22',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A function parses a config file and caches the result. '
        'A developer updates the config file while the app is running.\n\n'
        'Which approach handles this correctly?',
    options: [
      'Restart the application after every config change',
      'Re-read and re-parse the file on every request',
      'Watch for file system changes and invalidate the cache when the file is modified',
      'Store config in an environment variable instead',
    ],
    correctAnswer: 2,
    explanation:
        'Restarting on every change causes downtime. Re-reading on every request '
        'defeats caching and causes I/O overhead. Environment variables require '
        'restarts too. File system watching (inotify on Linux, FSEvents on macOS) '
        'allows the cache to be invalidated precisely when the file changes — '
        'no manual restarts, no unnecessary re-reads.',
    thinkingPattern: 'Cache Invalidation / File Watching',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-012',
    date: '2026-05-23',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'Your API returns a list of products — on average 200 items, '
        'each with 15 fields averaging 20 bytes each. '
        'The API receives 100,000 requests per hour.\n\n'
        'How much outbound data does the API transfer per day?',
    options: ['About 144 GB', 'About 14.4 GB', 'About 1.44 GB', 'About 144 MB'],
    correctAnswer: 0,
    explanation:
        '200 items × 15 fields × 20 bytes = 60,000 bytes = 60 KB per response. '
        '100,000 req/hr × 24 hr = 2,400,000 req/day × 60 KB = 144 GB. '
        'Even "small" payloads accumulate at scale — this is why pagination, '
        'sparse fieldsets, and response compression are standard practice.',
    thinkingPattern: 'Payload × Volume Estimation',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-011',
    date: '2026-05-24',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A transaction processing system must process each payment exactly once, '
        'even if the same request arrives multiple times.\n\n'
        'Which data structure best supports this guarantee?',
    options: [
      'A queue of incoming requests',
      'A hash set of processed transaction IDs',
      'A stack of recent transactions',
      'A sorted array of transaction timestamps',
    ],
    correctAnswer: 1,
    explanation:
        'To guarantee exactly-once processing, check if an incoming transaction '
        'was already processed. A hash set gives O(1) lookup: "have I seen this '
        'ID before?" If yes, skip. If no, process and add to the set. '
        'This is the idempotency key pattern — the transaction ID (UUID or '
        "client-generated key) is the hash set's element.",
    thinkingPattern: 'Idempotency / Membership Testing',
  ),

  // ── WEEK 12 (May 25–31, 2026) ──────────────────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-012',
    date: '2026-05-25',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'A distributed database has 3 replicas. A write succeeds when at least '
        '2 replicas confirm. A read succeeds when at least 2 replicas respond.\n\n'
        'Can a read always see the latest write?',
    options: [
      'No — reads may miss the latest write',
      'Yes — because the write quorum and read quorum must overlap',
      'Only if all 3 nodes are online',
      'Only if the write completed before the read started',
    ],
    correctAnswer: 1,
    explanation:
        'Write quorum (W=2) + Read quorum (R=2) = 4 > N=3 nodes. '
        'By the pigeonhole principle, at least one node that confirmed the write '
        'must be in the read quorum. This quorum intersection property guarantees '
        "consistency. It's the foundation of Dynamo-style databases.",
    thinkingPattern: 'Quorum / Distributed Consistency',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-012',
    date: '2026-05-26',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt:
        'A full binary tree of depth d has at most 2^(d+1) − 1 nodes. '
        'A full tree has exactly 31 nodes.\n\nWhat is its depth?',
    options: ['3', '4', '5', '6'],
    correctAnswer: 1,
    explanation:
        '2^(d+1) − 1 = 31 → 2^(d+1) = 32 → d+1 = 5 → d = 4. '
        'A full binary tree of depth 4 has 1+2+4+8+16 = 31 nodes. '
        'Each level doubles the node count — the total is always one less '
        'than the next power of 2.',
    thinkingPattern: 'Geometric Series / Binary Tree',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-012',
    date: '2026-05-27',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'Arrange these Git operations in the order that creates a clean '
        'feature branch workflow:',
    options: [
      'Merge or rebase the feature branch into main',
      'Create a new branch from main',
      'Open a pull request for review',
      'Commit your changes to the feature branch',
    ],
    correctAnswer: [1, 3, 2, 0],
    explanation:
        'Branch from main (isolated workspace), commit changes (build the feature), '
        'open PR (collaborate and review before merging), merge after approval. '
        'This pattern keeps main stable and provides a review checkpoint before '
        'any code reaches production.',
    thinkingPattern: 'Version Control Workflow',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-012',
    date: '2026-05-28',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'A service running on Kubernetes shows CPU spikes during garbage '
        'collection pauses, causing health checks to fail and the pod to '
        'restart repeatedly.\n\n'
        'What is the best fix?',
    options: [
      'Increase CPU limits on the pod',
      'Tune GC settings or switch to a lower-pause GC algorithm',
      'Reduce the health check frequency',
      'Disable garbage collection',
    ],
    correctAnswer: 1,
    explanation:
        "Increasing CPU limits helps but doesn't fix the root cause — GC pauses "
        'block the application thread, causing health checks to time out. '
        'Reducing health check frequency buys time but still restarts under '
        'long pauses. Disabling GC causes memory exhaustion. The correct fix: '
        'reduce pause times by tuning heap size, GC thresholds, or switching '
        'to a concurrent GC (like ZGC or Shenandoah on JVM).',
    thinkingPattern: 'Runtime Tuning / GC Behavior',
  ),

  // Friday — Edge Cases
  const Problem(
    id: 'edge-012',
    date: '2026-05-29',
    type: ProblemType.choice,
    category: ProblemCategory.edgeCases,
    prompt:
        'A function converts Celsius to Fahrenheit in an integer-only language:\n\n'
        'F = (C * 9 / 5) + 32\n\n'
        'For C = 3, the result is 37 instead of 37.4. What is the bug?',
    options: [
      'The formula is mathematically wrong',
      'Integer division truncates 27 / 5 = 5 instead of 5.4',
      'The multiplication overflows for large C values',
      'The operator precedence evaluates incorrectly',
    ],
    correctAnswer: 1,
    explanation:
        '3 × 9 = 27. In integer division, 27 ÷ 5 = 5 (not 5.4). '
        'Then 5 + 32 = 37. In floating-point, 27 ÷ 5 = 5.4, giving 37.4°F. '
        'This is integer division truncation — a classic bug. '
        'The fix: ensure at least one operand is a float, or reorder to '
        'minimize intermediate truncation.',
    thinkingPattern: 'Integer Division Truncation',
  ),

  // Saturday — Estimation
  const Problem(
    id: 'estimation-013',
    date: '2026-05-30',
    type: ProblemType.choice,
    category: ProblemCategory.estimation,
    prompt:
        'Three services A, B, C have uptime guarantees of 99.9%, 99.5%, and '
        '99.9%. A user request requires all three to succeed.\n\n'
        'What is the combined availability?',
    options: ['99.9%', '99.5%', 'About 99.3%', 'About 97%'],
    correctAnswer: 2,
    explanation:
        'Multiply the probabilities: 0.999 × 0.995 × 0.999 ≈ 0.993 = 99.3%. '
        'Three "high-availability" services chained together produce a result '
        'worse than any individual service. This is why architects minimize '
        'serial dependencies — each added service in the critical path '
        'degrades overall availability.',
    thinkingPattern: 'Reliability / Probability Multiplication',
  ),

  // Sunday — Data Structure
  const Problem(
    id: 'datastructure-012',
    date: '2026-05-31',
    type: ProblemType.choice,
    category: ProblemCategory.dataStructure,
    prompt:
        'A text editor stores a document as a sequence of characters. '
        'You need fast insertion and deletion at any cursor position.\n\n'
        'Which data structure is most suitable?',
    options: [
      'A simple string (immutable)',
      'An array of characters',
      'A gap buffer or rope',
      'A doubly linked list of characters',
    ],
    correctAnswer: 2,
    explanation:
        'Strings and arrays require shifting O(n) characters on every insertion. '
        'A doubly linked list gives O(1) insertion but O(n) cursor movement '
        '(no random access). A gap buffer (used in Emacs) keeps the "gap" at '
        'the cursor, making nearby insertions O(1). A rope (used in large editors) '
        'is a tree of substrings with O(log n) for all operations.',
    thinkingPattern: 'Gap Buffer / Rope / Editor Data Structures',
  ),

  // ── WEEK 13 (June 1–4, 2026) — partial week ────────────────────────────────

  // Monday — Logic
  const Problem(
    id: 'logic-013',
    date: '2026-06-01',
    type: ProblemType.choice,
    category: ProblemCategory.logic,
    prompt:
        'A team uses feature flags. The rule is: flag F must be off in production '
        'until it has been on in staging for at least 24 hours.\n\n'
        'F was turned on in staging at 2 PM Monday. '
        'What is the earliest F can be enabled in production?',
    options: ['2 PM Monday', '2 PM Tuesday', 'Midnight Tuesday', '2 PM Wednesday'],
    correctAnswer: 1,
    explanation:
        '"At least 24 hours" means 24 full hours must elapse. '
        '2 PM Monday + 24 hours = 2 PM Tuesday. '
        'Midnight Tuesday is only ~10 hours later. '
        'The staging enable time is the reference point — staging and production '
        'timers are independent.',
    thinkingPattern: 'Temporal Constraint Reasoning',
  ),

  // Tuesday — Pattern
  const Problem(
    id: 'pattern-013',
    date: '2026-06-02',
    type: ProblemType.choice,
    category: ProblemCategory.pattern,
    prompt: 'Look at this sequence:\n\n4, 6, 8, 9, 10, 12, 14, 15, 16, __\n\nWhat comes next?',
    options: ['17', '18', '19', '20'],
    correctAnswer: 1,
    explanation:
        'This is the sequence of composite numbers — integers greater than 1 '
        'that are not prime. 17 is prime (skipped). 18 = 2 × 9 (composite). '
        'Primes are the gaps: 5, 7, 11, 13, 17 are all absent. '
        'Recognizing what is missing from a sequence is as important as '
        'recognizing what is present.',
    thinkingPattern: 'Composite Number Sequence',
  ),

  // Wednesday — Algorithm
  const Problem(
    id: 'algorithm-013',
    date: '2026-06-03',
    type: ProblemType.ordering,
    category: ProblemCategory.algorithm,
    prompt:
        'Arrange these database query operations in the order a query optimizer '
        'ideally executes them for best performance:',
    options: [
      'Apply GROUP BY and aggregate functions',
      'Filter rows with WHERE clause',
      'Join tables together',
      'Return the SELECT columns',
    ],
    correctAnswer: [1, 2, 0, 3],
    explanation:
        'Filter first (WHERE reduces rows before expensive operations), '
        'join next (with fewer rows from the filter), '
        'group/aggregate then (on the joined result), '
        'finally project only the needed columns (SELECT). '
        'Most query optimizers follow this logical order even when SQL '
        'is written differently.',
    thinkingPattern: 'Query Optimization Order',
  ),

  // Thursday — Decomposition
  const Problem(
    id: 'decomposition-013',
    date: '2026-06-04',
    type: ProblemType.choice,
    category: ProblemCategory.decomposition,
    prompt:
        'After a major refactor, code coverage drops from 85% to 60%. '
        'The number of tests in the test suite did not change.\n\n'
        'What most likely happened?',
    options: [
      'Some tests now fail and are being skipped',
      'New code was added without adding new tests',
      'The coverage tool changed its counting method',
      'Tests became less efficient and cover less code',
    ],
    correctAnswer: 1,
    explanation:
        "If the test count didn't change, the tests themselves didn't change. "
        'Coverage = lines tested ÷ total lines. If it dropped, total lines '
        'increased — new code was added. The old tests still cover the same '
        'old code, but that code is now a smaller percentage of the total. '
        'Adding features without tests is the primary cause of coverage decline.',
    thinkingPattern: 'Metric Analysis / Code Health',
  ),
];
