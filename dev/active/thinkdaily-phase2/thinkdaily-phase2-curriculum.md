# ThinkDaily — Curriculum Design
Last Updated: 2026-03-07

## Philosophy
AI writes code. What AI cannot replace is **how you think**.
ThinkDaily trains the thinking skills that matter most in the AI era:
framing problems, navigating uncertainty, seeing systems, making decisions.

Questions are scenario-based, not definition-based.
They feel like a smart friend asking you to think — not a textbook exam.
Difficulty ramps per unit: Q1 = "aha", Q2 = "apply it", Q3 = "what breaks it?"

---

## Tracks Overview

| # | Track | Core Question | Units |
|---|-------|--------------|-------|
| 1 | Problem Decomposition | "Am I solving the right thing?" | 4 |
| 2 | Systems Thinking | "What happens next, and then what?" | 4 |
| 3 | Mental Models | "What frame should I use here?" | 5 |
| 4 | Decision Making | "How do I choose under uncertainty?" | 4 |
| 5 | Estimation & Scale | "Is this number reasonable?" | 4 |
| 6 | Critical Evaluation | "What could go wrong?" | 4 |
| 7 | System Design Thinking | "How do the pieces fit?" | 4 |
| 8 | Communication Thinking | "How do I make this understood?" | 3 |

Total: ~32 units × 3 questions = ~96 questions = ~3 months of daily content per track.

---

## Track 1: Problem Decomposition

### Unit 1: Framing the Right Problem

**Q1 — Easy — "The XY Problem"**
Prompt:
A user emails support: "How do I delete a row from my spreadsheet?" You fix it.
Next day: "How do I remove the blank line it leaves?" You fix that.
A week later: "How do I stop duplicates appearing?"

What's the real problem they've been trying to solve all along?

Options:
A) They don't know how to use spreadsheets
B) Their underlying data process is generating duplicates
C) The UI is too confusing
D) They need better documentation

Answer: B
Explanation: This is the XY Problem — people ask about their attempted solution, not their actual problem. Each question was a symptom. The real problem is upstream: something is creating duplicates in the first place. Good problem solvers ask "why are you trying to do that?" before answering the surface question.
Thinking Pattern: Root Cause vs Symptom

---

**Q2 — Medium — "The Bridge or the Road?"**
Prompt:
A city hires you to fix traffic congestion on a bridge.
After studying it, you find 60% of cars cross the bridge only to reach a shopping mall — which also has a direct entrance from the highway bypass nearby.

What's the right problem to solve?

Options:
A) Widen the bridge to add more lanes
B) Add tolls to reduce bridge usage
C) Improve signage so mall traffic uses the highway bypass instead
D) Build a second bridge nearby

Answer: C
Explanation: The problem wasn't "the bridge is too small" — it was "cars are using the wrong route." Widening (A) solves the symptom and costs millions. Redirecting traffic (C) removes the cause cheaply. Before solving anything, ask: why is this happening? You might find the solution already exists.
Thinking Pattern: Reframing

---

**Q3 — Hard — "The Fastest Horse"**
Prompt:
A product team interviews 50 users. They all say they want "a faster checkout."
The team spends 3 months optimising checkout speed. Usage drops anyway.

What most likely went wrong?

Options:
A) The optimisation wasn't fast enough
B) Users described a symptom — they wanted less friction, not raw speed
C) The team should have surveyed more users
D) Checkout was already fast enough before

Answer: B
Explanation: Users observe symptoms and describe solutions. "Faster checkout" meant "this process feels annoying." Speed was one theory — but friction comes from confusion, too many steps, and distrust too. The real need was "effortless purchase." Always separate what users say from what they actually need.
Thinking Pattern: Jobs-to-be-Done

---

### Unit 2: Breaking It Down

**Q1 — Easy — "The Recipe Test"**
Prompt:
You're asked to build "a notification system."
Before writing any code, you need to break it down.

Which first decomposition is most useful?

Options:
A) Frontend components, backend services, database schema
B) Who gets notified, when, through what channel, and what happens if it fails
C) Which programming language and framework to use
D) How many notifications per second it needs to handle

Answer: B
Explanation: Technical decomposition (A) is premature — you don't know what you're building yet. Scale (D) is a constraint, not a structure. The right first split is behavioral: actors, triggers, channels, failure modes. These questions reveal what you actually need to build before touching anything technical.
Thinking Pattern: Functional Decomposition

---

**Q2 — Medium — "The Dependency Trap"**
Prompt:
You're launching a feature. Your tasks:
1. Write the API
2. Design the database schema
3. Build the UI
4. Write tests
5. Get stakeholder approval on the design

In what order should these actually happen?

Options:
A) 1 → 2 → 3 → 4 → 5
B) 5 → 2 → 1 → 3 → 4
C) 3 → 5 → 2 → 1 → 4
D) 2 → 1 → 3 → 5 → 4

Answer: B
Explanation: Task 5 (approval) should come first — building without alignment wastes everything else. Schema (2) before API (1) because the API depends on the data model. UI (3) depends on the API contract. Tests (4) verify the final implementation. Spotting dependencies before starting prevents expensive rework.
Thinking Pattern: Dependency Ordering

---

**Q3 — Hard — "The Slice vs Layer"**
Prompt:
Two engineers disagree:

Engineer A: "Let's finish the entire database layer, then the entire API layer, then the entire UI."
Engineer B: "Let's build one complete thin slice end-to-end — one screen, one API, one table — then expand."

You have a demo in 2 weeks and requirements might change. Which wins?

Options:
A) Engineer A — clean separation, easier to test each layer
B) Engineer B — something working sooner means you can validate assumptions early
C) Depends entirely on team size
D) Both are equivalent with enough discipline

Answer: B
Explanation: With uncertain requirements and a deadline, vertical slices beat horizontal layers. Layers deliver nothing until all are complete. A slice gives you something real to show, test, and learn from fast. This is why "walking skeleton" is a core agile pattern — validate before building everything.
Thinking Pattern: Vertical Slicing

---

### Unit 3: Knowing When to Stop

**Q1 — Easy — "Good Enough"**
Prompt:
You're building search. You could spend 1 day on basic keyword matching (works 80% of the time) or 3 weeks on semantic search (works 95% of the time).
You have 500 users and launch is next week.

What should you build?

Options:
A) Semantic search — do it right the first time
B) Basic keyword matching — ship it, improve based on real feedback
C) Nothing — search can wait
D) Basic search but document the technical debt carefully

Answer: B
Explanation: The 15% improvement costs 15× more time. With 500 pre-launch users, you don't even know if search matters to them yet. Ship the 80% solution, watch how people use it, then decide if the extra 15% is worth 3 weeks. "Good enough to learn" beats "perfect but late."
Thinking Pattern: 80/20 Rule (Pareto)

---

**Q2 — Medium — "The Abstraction Trap"**
Prompt:
A junior engineer is building a payment feature. It needs to support Stripe today.
They spend a week building a "universal payment abstraction layer" to support any provider in the future.

Three months later: the team still only uses Stripe. What went wrong?

Options:
A) Nothing — abstractions are always good engineering
B) They solved a problem that didn't exist yet, at the cost of current speed
C) They should have used a different abstraction pattern
D) The abstraction layer was probably poorly designed

Answer: B
Explanation: YAGNI — You Aren't Gonna Need It. Building for hypothetical futures delays real work and often produces the wrong abstraction anyway (you don't know the shape of future requirements until they arrive). The right time to abstract is when you have the second concrete use case — not before.
Thinking Pattern: YAGNI

---

**Q3 — Hard — "Enough Detail"**
Prompt:
Your team is planning a 3-month project. In the planning meeting, one engineer wants to spec every API endpoint, every database column, and every edge case before writing a line of code. Another wants to start coding Monday with just the high-level goals.

What's the right level of planning detail for a 3-month project?

Options:
A) Full spec — ambiguity is the enemy of execution
B) High-level goals only — details will emerge
C) Enough detail to start confidently, with checkpoints to re-plan as you learn
D) It depends on whether the team has worked together before

Answer: C
Explanation: Over-planning wastes time on details that will change. Under-planning causes thrash. The right answer is "just enough" — clear goals, rough task breakdown, known dependencies, explicit unknowns. Then re-plan at milestones as reality updates your map. Planning is valuable; the plan is not.
Thinking Pattern: Adaptive Planning

---

### Unit 4: Constraints as Clarity

**Q1 — Easy — "The Budget Is a Feature"**
Prompt:
A client says: "Build us the best possible e-commerce site. Budget: $10,000."
You could build a full custom platform, or use Shopify and spend the budget on design and marketing.

What should you do first?

Options:
A) Start building the custom platform — it'll be more flexible
B) Clarify what "best possible" means to the client
C) Recommend Shopify immediately
D) Ask for a bigger budget

Answer: B
Explanation: "Best possible" is undefined. Best at what? Conversion rate? Brand impression? Ease of management? The budget is a constraint, and constraints are useful — they force you to clarify what actually matters. A constraint answered the wrong question is still the wrong answer.
Thinking Pattern: Constraint-Driven Clarity

---

**Q2 — Medium — "The Deadline Reveal"**
Prompt:
Your manager says: "We need this feature in 2 weeks."
You estimate 4 weeks of work. What's the most useful response?

Options:
A) Say yes and work overtime
B) Say no — it's impossible
C) Ask what's driving the 2-week deadline, then show what's achievable in that time
D) Reduce quality to fit the timeline

Answer: C
Explanation: Deadlines often have specific drivers — a conference, a client demo, a regulatory date. Understanding the driver tells you which parts truly need to ship in 2 weeks. Maybe 60% of the feature covers the demo. Negotiating scope, not timeline, is the professional response.
Thinking Pattern: Constraint Source Analysis

---

**Q3 — Hard — "The Constraint That Isn't"**
Prompt:
A team has been building mobile-only for 2 years because "the CEO said we're mobile-first." A competitor launches a web app and starts taking market share.

When you dig in, the original constraint came from a 2015 email about priorities — not a permanent product decision.

What's the lesson?

Options:
A) Always document decisions so they don't get misinterpreted
B) Constraints should be revisited regularly — they expire
C) The CEO should communicate better
D) A and B

Answer: D
Explanation: Constraints expire. Business context changes. What was true in 2015 may not be true now. Good teams document why a constraint exists (not just what it is), and revisit constraints at regular intervals. "We've always done it this way" is the most expensive constraint in any organisation.
Thinking Pattern: Constraint Expiry

---

## Track 2: Systems Thinking

### Unit 1: Inputs, Outputs, Feedback Loops

**Q1 — Easy — "The Like Loop"**
Prompt:
A new social app launches. Users post, get likes, feel good, post more.
The algorithm shows popular posts to more people, who like them, making those posts even more popular.
Six months later: 10% of users generate 90% of the content.

What is driving this?

Options:
A) The app has great retention features
B) A reinforcing feedback loop — success breeds more success
C) Most users are lazy
D) The algorithm is broken

Answer: B
Explanation: This is a reinforcing feedback loop. Likes → more posting → more likes → even more posting. Each cycle amplifies the last. This is how feedback loops work — and they are everywhere: interest compounds in savings accounts, word-of-mouth grows products, bugs multiply in bad codebases. Recognising the loop is the first step to working with (or against) it.
Thinking Pattern: Reinforcing Feedback Loop

---

**Q2 — Medium — "The Thermostat"**
Prompt:
A startup is growing fast. Every month the team doubles to keep up with demand.
But as team size grows, coordination gets harder, velocity slows, and customers start complaining about quality.

Which type of feedback loop is limiting growth?

Options:
A) A reinforcing loop — growth causes more growth
B) A balancing loop — the system is self-correcting toward a limit
C) There is no feedback loop — it is just bad management
D) A time-delay loop — the effects have not shown up yet

Answer: B
Explanation: This is a balancing loop. Growth → coordination cost → slower delivery → unhappy customers → pressure to fix quality → slower hiring → limited growth. Balancing loops pull systems toward equilibrium. The system is not broken — it is self-limiting. Understanding which loop you are in tells you what to do: reinforce it or find and address the constraint.
Thinking Pattern: Balancing Feedback Loop

---

**Q3 — Hard — "The Optimisation That Broke Everything"**
Prompt:
An e-commerce warehouse tripled its picking speed with better tooling.
But overall order delivery time did not improve — it got slightly worse.

What most likely happened?

Options:
A) The tooling was implemented incorrectly
B) Picking was not the bottleneck — now a different stage is overwhelmed
C) Workers slowed down elsewhere to compensate
D) The improvement was measured incorrectly

Answer: B
Explanation: Optimising a non-bottleneck does not help the system. If packing or shipping was the constraint, tripling picking speed just creates a pile-up before the next stage. The system moves at the speed of its slowest part. Optimising anywhere else just moves inventory around. Always find the bottleneck before optimising anything.
Thinking Pattern: Local vs Global Optimisation

---

### Unit 2: Second-Order Effects

**Q1 — Easy — "The Cobra Effect"**
Prompt:
In colonial India, the British government offered a bounty for every dead cobra to reduce the cobra population.
The plan worked initially — thousands of cobras were turned in.
Then the cobra population exploded.

What happened?

Options:
A) Cobras developed resistance to traps
B) Bounty hunters started breeding cobras to collect more rewards
C) The government ran out of money for bounties
D) Cobras migrated from other regions

Answer: B
Explanation: This is the Cobra Effect — a solution that makes the problem worse. Incentivise killing cobras, and rational actors breed cobras. When the bounty was cancelled, breeders released worthless cobras. The intervention created its own demand. Every incentive system has second-order effects. Ask: what behaviour does this actually reward?
Thinking Pattern: Incentive Second-Order Effect

---

**Q2 — Medium — "The Viral Feature"**
Prompt:
A team launches a "Share your result" button. Engagement goes up 40%.
Two months later: support tickets double, trust scores drop, and two enterprise clients threaten to cancel.

What likely happened?

Options:
A) The feature had a technical bug
B) Sharing surfaced results users did not anticipate being made public
C) Competitors copied the feature and undercut them
D) The engagement metrics were tracked incorrectly

Answer: B
Explanation: Engagement went up because sharing is engaging. But the second-order effect — what happens after things are shared — was not considered. Privacy violations, out-of-context results, or exposed data created downstream damage. Features often have great first-order effects (engagement) and costly second-order ones (trust erosion). Ask "and then what?" before shipping.
Thinking Pattern: Second-Order Consequence

---

**Q3 — Hard — "The Hiring Surge"**
Prompt:
A company struggled with slow code reviews. Their fix: hire 10 more engineers.
After 6 months, code review is still slow. Communication overhead has tripled.
Their best engineers now spend half their time in meetings and Slack.

What went wrong?

Options:
A) They hired the wrong engineers
B) Adding people to a communication-heavy problem makes it worse, not better
C) The engineering manager failed to delegate
D) Remote work caused the coordination issues

Answer: B
Explanation: Adding people to a late software project makes it later — Brooks' Law. More people means more communication channels (grows as n squared). If the bottleneck is review quality or unclear standards, headcount does not fix it. The second-order effect of hiring is coordination cost. The right fix was to improve the review process, not expand the team.
Thinking Pattern: Brooks' Law / Adding Resources

---

### Unit 3: Bottlenecks

**Q1 — Easy — "The Slow Pipeline"**
Prompt:
A team's software release takes 3 days. Breakdown:
- Code to Review: 4 hours
- Review to QA: 6 hours
- QA to Staging: 2 hours
- Staging to Production: 1 hour

They want to cut release time in half. Which stage should they focus on first?

Options:
A) Code to Review — it is the first step
B) Staging to Production — it is fully automatable
C) Review to QA — it is the longest wait
D) All stages equally

Answer: C
Explanation: The bottleneck is the longest wait: Review to QA at 6 hours. Cutting any other stage barely moves the total. Halving the 1-hour staging step saves 30 minutes. Halving the 6-hour QA wait saves 3 hours. Fix the biggest constraint first — everything else is noise until the bottleneck is addressed.
Thinking Pattern: Theory of Constraints

---

**Q2 — Medium — "The Fast Lane"**
Prompt:
A checkout process has two steps: payment processing (1 second) and fraud detection (8 seconds).
The team optimises payment processing down to 0.1 seconds.

How much faster is the checkout experience?

Options:
A) About 10x faster — from 9s to 0.9s
B) About 1 second faster — from 9s to 8.1s
C) No change — fraud detection is still 8 seconds
D) It depends on the server hardware

Answer: B
Explanation: Checkout was 9 seconds (1 + 8). Optimising payment to 0.1 seconds gives 8.1 seconds total — a 0.9-second saving, not 10x. The bottleneck is fraud detection. This is why optimising non-bottlenecks has near-zero impact on the system. Before celebrating an improvement, ask: does it actually improve the end-to-end result?
Thinking Pattern: Bottleneck-Constrained Throughput

---

**Q3 — Hard — "The Moving Bottleneck"**
Prompt:
A factory has three stations: cut (5 min/unit), assemble (10 min/unit), pack (3 min/unit).
Hourly capacity: cut = 12 units, assemble = 6 units, pack = 20 units.

They add a second assembly line, doubling assembly capacity to 12 units/hour.

What happens to total system output?

Options:
A) Output doubles — assembly was the bottleneck
B) Output stays at 12 per hour — cut is now the binding constraint
C) Output increases then plateaus as pack becomes the limit
D) Output doubles, then drops due to coordination overhead

Answer: B
Explanation: Assembly was the bottleneck at 6/hr. A second line raises it to 12/hr — now matching cut exactly. The system can produce 12/hr, but cut is now the new ceiling. The bottleneck shifted. Fixing one bottleneck always reveals the next. Systems thinking means planning for the cascade, not just the first fix.
Thinking Pattern: Bottleneck Cascade

---

### Unit 4: Emergence

**Q1 — Easy — "The Missing Output"**
Prompt:
You hire two senior engineers who each produced 20 features per month individually.
After joining your team, they produce 28 combined — not 40.

What is most likely happening?

Options:
A) They are not working as hard
B) Collaboration overhead — meetings, reviews, context-switching — reduces individual output
C) Your codebase is too complex for them
D) The features they are working on are harder than before

Answer: B
Explanation: Two people working together rarely produce 2x output. Collaboration has overhead: meetings, reviews, resolving conflicts, context-sharing. This is not failure — it is an emergent system property. Team output is not a sum of individuals. Good teams design for this: fewer unnecessary meetings, clear ownership, async communication.
Thinking Pattern: Emergent System Property

---

**Q2 — Medium — "The Phantom Jam"**
Prompt:
A highway has no accidents, no construction, no bad weather.
Yet traffic jams appear and disappear every day at the same spot.

What causes them?

Options:
A) There is a hidden obstruction the data is not capturing
B) Small variations in individual driver behaviour compound into system-wide slowdowns
C) The road was poorly designed for that volume
D) Rush hour demand exceeds the road capacity at that point

Answer: B
Explanation: Phantom traffic jams emerge from individual behaviour: one driver brakes slightly, the car behind overcompensates, the next brakes harder. This ripple amplifies backward into a jam with no single cause. This is emergence — complex system behaviour from simple local interactions. It explains why adding lanes often fails to fix congestion, and why small delays cascade in distributed systems.
Thinking Pattern: Emergent Behaviour

---

**Q3 — Hard — "The Rules That Made It Work"**
Prompt:
Wikipedia has millions of high-quality articles maintained by volunteers with no salaries, no formal roles, and no direct oversight of most edits.

What is the key to this working?

Options:
A) Volunteers are inherently more motivated than employees
B) Simple rules were designed so that good behaviour emerges at scale
C) Wikipedia got lucky with its early community
D) Quality is enforced by a large hidden moderation team

Answer: B
Explanation: Wikipedia designed for emergence. Simple rules — anyone can edit, edits are logged and reversible, neutrality policy, talk pages for disputes — create conditions where good outcomes emerge without central enforcement. This is designed emergence: instead of policing behaviour directly, design the environment so good behaviour becomes the natural result. Open source, peer review, and free markets work the same way.
Thinking Pattern: Designed Emergence

---

## Track 3: Mental Models

### Unit 1: First Principles Thinking

**Q1 — Easy — "The Expensive Ingredient"**
Prompt:
A restaurant owner buys tomato sauce for $250/week from a supplier.
The same sauce costs $4/jar at the supermarket — $200/week for his volume.
He calls the supplier to negotiate. They won't budge.
What is the first principles approach?

Options:
A) Make the sauce from scratch — raw ingredients cost about $80 per week
B) Find a different supplier who charges less
C) Switch to menu items that do not need tomato sauce
D) Accept the cost and raise menu prices

Answer: A
Explanation: First principles means breaking a problem down to its fundamental truths and building back up from there. Instead of accepting "sauce costs $X from a supplier," ask: what is sauce actually made of, and what do those materials cost? The gap between $80 (ingredients) and $250 (supplier) is integration and markup — both reducible. Elon Musk applied this same logic to rocket parts and battery cells. The question is not "who sells it cheapest?" but "what is it actually made of?"
Thinking Pattern: First Principles Decomposition

---

**Q2 — Medium — "The Battery Assumption"**
Prompt:
In 2012, the received wisdom was that battery packs cost $600/kWh and always would.
Everyone accepted this — car makers, analysts, investors.
What is the first principles question that breaks this assumption?

Options:
A) Can we find a cheaper battery supplier?
B) Can we design a vehicle that uses less battery?
C) What are the raw materials in a battery and what do they cost on commodities markets?
D) Can government subsidies offset the battery cost?

Answer: C
Explanation: The first principles question is not "who sells batteries cheapest?" — that still accepts the market structure as fixed. The real question: what is a battery, fundamentally? Carbon, nickel, aluminium, polymer. What do those materials cost at commodity prices? About $80/kWh in 2012. The gap between $80 and $600 was manufacturing overhead, integration margin, and market markup — all reducible with volume and vertical integration. The constraint was assumption, not physics.
Thinking Pattern: Assumption Stripping

---

**Q3 — Hard — "When Not to First-Principle"**
Prompt:
A junior engineer is asked to add a date picker to a form.
Instead of using the standard library component, they build one from first principles — "to really understand how dates work."
It takes 3 weeks. The library component would have taken 1 hour.

What went wrong?

Options:
A) The engineer lacked knowledge of the standard library
B) First principles thinking was applied to a solved problem — it should be reserved for genuine constraints
C) The manager should have specified the required approach upfront
D) Building from scratch is always wrong in software

Answer: B
Explanation: First principles thinking has a real cost: time. It is powerful when facing a genuine constraint — an unacceptable price, a physical limitation, a broken market assumption. But when a good-enough solution already exists, rebuilding it creates no new value. The skill is knowing when to apply it. Use first principles when the existing solution is wrong or unacceptably limited. Otherwise, stand on shoulders.
Thinking Pattern: Judicious Use of First Principles

---

### Unit 2: Inversion

**Q1 — Easy — "The Success Question"**
Prompt:
A startup wants to build a habit-forming app. The team asks: "How do we make users come back every day?"
What question would inversion produce?

Options:
A) How do we make users come back every week instead of every day?
B) What would guarantee that users never come back?
C) What do our most retained users have in common?
D) How did Duolingo solve this problem?

Answer: B
Explanation: Inversion flips the question. Instead of "how do we succeed?" ask "what would guarantee failure?" Users never return if: the app is slow, notifications are annoying, value is unclear on first use, they feel stupid, progress is invisible. Now you have a concrete list of things to avoid. Avoiding failure is often clearer and more actionable than chasing success directly — because failures are specific and success is vague.
Thinking Pattern: Inversion

---

**Q2 — Medium — "The Pre-Mortem"**
Prompt:
A team is about to launch a major feature. Their PM says: "Imagine it is 6 months from now and the feature completely failed. What happened?"

Why is this more useful than asking "how do we make this succeed?"

Options:
A) It is a more engaging exercise for the team
B) It prepares the team emotionally for the possibility of failure
C) It surfaces specific failure modes that optimism bias would hide in normal planning
D) It helps identify who to hold accountable if the launch fails

Answer: C
Explanation: Forward planning is contaminated by optimism bias — we imagine the path where things work. A pre-mortem inverts the question: assume it failed, now explain why. This forces the brain to generate specific, concrete problems rather than vague risks. Teams that run pre-mortems consistently find overlooked issues: a dependency nobody owns, an untested assumption, a competitor move nobody raised. The inversion is the mechanism — it bypasses the optimism filter.
Thinking Pattern: Pre-Mortem / Inversion

---

**Q3 — Hard — "Designing by Negation"**
Prompt:
A payments team is designing a new checkout flow. They could ask:
Option X: "How do we make this excellent?"
Option Y: "What would make this terrible?"

Which leads to a better final design?

Options:
A) Option X — positive framing generates more creative ideas
B) Option Y — each failure mode becomes a concrete design requirement
C) Both are equivalent — output depends on team quality, not the question
D) Neither — study competitor checkouts instead

Answer: B
Explanation: "Make it excellent" produces wish lists. "Make it terrible" produces constraints: it fails if it is slow, if error messages are confusing, if payment data feels insecure, if there are too many steps, if edge cases are unhandled. Avoiding each failure is a specific, testable design obligation. Inversion converts vague ambition into concrete requirements. The resulting checklist is more actionable than a vision statement.
Thinking Pattern: Inversion as Design Tool

---

### Unit 3: Occam's Razor

**Q1 — Easy — "The Monday Bug"**
Prompt:
A web app stops working for some users on Monday morning.
Theory A: A deploy on Friday introduced a bug.
Theory B: A cosmic ray flipped a bit in the server, causing memory corruption that only affects certain ISPs.

Which should you investigate first?

Options:
A) Theory A — the Friday deploy is the simplest explanation consistent with the facts
B) Theory B — it is more specific and accounts for all the details
C) Both simultaneously — it is Monday morning and speed matters
D) Neither — restart the server first and see if it resolves

Answer: A
Explanation: Occam's Razor: among competing explanations, prefer the simplest one consistent with the evidence. A Friday deploy is a common, high-probability cause of Monday bugs. Cosmic ray bit-flips do occur, but are extremely rare. Start with the highest-probability, lowest-complexity explanation. You escalate to exotic theories only after the simple ones are eliminated. Most bugs are boring — and that is useful information.
Thinking Pattern: Occam's Razor

---

**Q2 — Medium — "The User Drop"**
Prompt:
An analytics dashboard shows a 40% drop in daily active users over two days.
The team proposes three theories:
- Theory A: A recent UI change confused users
- Theory B: A major competitor launched and users churned
- Theory C: A tracking bug is under-counting users

What should happen first?

Options:
A) Run a user survey to understand what changed for them
B) Immediately roll back the UI change
C) Investigate the competitor's new feature launch
D) Check whether the tracking code is working correctly before concluding users actually left

Answer: D
Explanation: Before assuming a real change in user behaviour, verify the measurement itself. A 40% drop overnight is dramatic enough to suspect instrumentation first. If a tracking pixel broke, a database migration dropped events, or a deploy changed event naming, the "drop" is not real. Occam's Razor here means: check the boring explanation first (broken tracking) before concluding something dramatic happened in the real world. Measure before you explain.
Thinking Pattern: Measurement Before Explanation

---

**Q3 — Hard — "When Simple Is Wrong"**
Prompt:
A doctor sees a patient with fatigue, joint pain, and a rash.
The simple diagnosis: flu with a skin reaction (fits 80% of similar presentations).
The complex diagnosis: lupus (rare, but fits the same symptoms and requires urgent treatment).

When is Occam's Razor the wrong tool?

Options:
A) When the stakes of a wrong diagnosis are high and the conditions have very different treatment paths
B) When the doctor has fewer than 10 years of experience
C) When the patient insists on a thorough investigation
D) Occam's Razor is never the wrong tool — always start with the simplest explanation

Answer: A
Explanation: Occam's Razor is a heuristic for directing effort, not a rule for stopping investigation. When the cost of a missed complex diagnosis is high — lupus untreated causes permanent organ damage — the stakes override the prior probability. In software, a "simple" root cause might satisfy a P1 incident review while leaving a latent architectural flaw undiscovered. Use Occam's Razor to decide where to look first; do not use it to decide when to stop looking.
Thinking Pattern: Limits of Occam's Razor

---

### Unit 4: Map vs Territory

**Q1 — Easy — "The Org Chart"**
Prompt:
A new engineer joins a company. The org chart shows clear reporting lines.
But when she needs an engineering tooling decision approved, she quickly learns it actually goes through a senior IC in a different team — they wrote the original infrastructure and everyone defers to them informally.

What does this illustrate?

Options:
A) The org chart is wrong and should be updated immediately
B) Informal authority is always more reliable than formal authority
C) The org chart (map) does not reflect how decisions actually get made (territory)
D) The company has poor governance structure

Answer: C
Explanation: The org chart is a map — a simplified model of reality. The territory is how the organisation actually functions: who has credibility, who controls key decisions, who gets consulted informally. Every organisation has both. Confusing the map for the territory leads to wasted time escalating through official channels that do not reflect real power. Learn the territory early; do not assume the map is accurate.
Thinking Pattern: Map vs Territory

---

**Q2 — Medium — "The Velocity Plan"**
Prompt:
A team measures their velocity at 40 story points per sprint and uses this to plan the next 6 months.
At month 3, they are 8 weeks behind.

What most likely went wrong?

Options:
A) The team was not working hard enough
B) Story point estimation is inherently unreliable and should be abandoned
C) Velocity is a lagging average that does not account for future complexity, new dependencies, or interruptions
D) Six-month plans are always wrong regardless of the measurement method

Answer: C
Explanation: Velocity is a map of past performance — a lagging average. It measures what happened, not what will happen. The territory (future work) contains things the map cannot see: new dependencies not yet known, team changes, technical debt that slows future sprints, requirements that expand, incidents. Treating the velocity map as the territory produces precise-but-wrong plans. Maps are useful for navigation; they break down when mistaken for the thing they represent.
Thinking Pattern: Map as Lagging Indicator

---

**Q3 — Hard — "The Schema and the Query"**
Prompt:
A team designs a carefully normalised database schema that accurately models their domain.
Six months later, their most common query takes 4 seconds — because it requires 7 joins across normalised tables.

What does this reveal?

Options:
A) The schema was poorly designed from the start
B) The domain model (map) was correct in theory but the query access patterns (territory) demanded a different structure
C) Normalisation is outdated — always use NoSQL for performance-critical applications
D) The team should have used an ORM to hide the complexity of joins

Answer: B
Explanation: The schema was an accurate map of the domain — entities, relationships, constraints all correctly modelled. But the territory it needed to serve was query performance under real load. The map optimised for conceptual clarity; the territory required read performance. This is the core tension: the map most faithful to abstract reality is often least faithful to operational reality. Good engineers hold both: understand the ideal model and the actual access patterns, then choose the trade-off explicitly.
Thinking Pattern: Model-Reality Gap

---

### Unit 5: Second-Order Thinking

**Q1 — Easy — "And Then What?"**
Prompt:
A city bans cars from the city centre to reduce pollution and congestion.
First-order effect: less traffic and cleaner air in the centre.
What is the most likely second-order effect?

Options:
A) People stop driving entirely and switch to public transport
B) City centre businesses thrive due to the pedestrian-friendly environment
C) Traffic shifts to surrounding roads, increasing congestion and pollution in residential areas
D) Property values in the city centre fall due to reduced accessibility

Answer: C
Explanation: The first-order effect is what the policy intends. The second-order effect is what happens as the system adjusts. Drivers do not disappear — they reroute. The pollution and congestion move rather than decrease. "And then what?" is the key question after any intervention. What does the system do in response to the change? Second-order thinking requires tracing consequences one step beyond the intended outcome.
Thinking Pattern: Second-Order Thinking

---

**Q2 — Medium — "The Raise"**
Prompt:
A company gives everyone a 20% salary raise to improve retention.
First-order effect: employees feel valued.
Six months later: a competitor matches the raise, and the company freezes hiring to cover costs.

What second-order effect was missed in the original decision?

Options:
A) Competitors would match the raise, erasing the retention advantage, while the permanent cost increase would constrain hiring and other investments
B) Employees would expect another raise the following year
C) The company would need to raise product prices to cover payroll
D) High performers would leave anyway because they wanted more than 20%

Answer: A
Explanation: The raise becomes a permanent cost. Competitors observe and respond, eroding the retention differential quickly. Meanwhile, increased payroll constrains hiring — which creates overwork, which drives the very attrition the raise was meant to prevent. Second-order thinking means asking: how does the system — competitors, costs, employee expectations — respond to this action over time? The first-order effect was real; the second-order effects undid it.
Thinking Pattern: Competitive Second-Order Effect

---

**Q3 — Hard — "Short-Term vs Long-Term"**
Prompt:
A SaaS company is behind on growth targets. Leadership offers 50% discounts to close deals quickly and hit Q4 numbers.

What second-order effects should concern them most?

Options:
A) Customers might assume the product is worth less than its original price
B) The sales team will expect high commission rates on discounted deals
C) The product roadmap will need to slow to fund the discount programme
D) Discounted customers churn at higher rates, have lower lifetime value, and establish a negotiation precedent that makes full-price deals harder in future

Answer: D
Explanation: Discounting to hit short-term numbers creates compounding second-order effects: price anchoring (customers expect discounts permanently), adverse selection (price-sensitive customers churn faster), sales process change (reps learn to offer discounts to close any deal), and competitive signalling (a struggling company discounting 50% is visible to rivals). The short-term revenue hit is real; the long-term structural damage is larger. Second-order thinking in business means asking: what kind of customers and habits does this policy create, 12 months from now?
Thinking Pattern: Short-Term vs Long-Term Trade-off

---

## Track 4: Decision Making

### Unit 1: Reversible vs Irreversible
- Q1: Categorising decisions by reversibility before committing resources
- Q2: Why reversible decisions should be made fast, irreversible slowly
- Q3: Making a reversible path for a seemingly irreversible decision

### Unit 2: Deciding with Incomplete Information
- Q1: The cost of waiting for more data vs the cost of deciding now
- Q2: What's the minimum information needed to make this call?
- Q3: Distinguishing uncertainty (unknown odds) from risk (known odds)

### Unit 3: Trade-offs
- Q1: Speed vs quality — when each is the right call
- Q2: No free lunch — every architecture decision has a cost
- Q3: How to make a trade-off explicit and owned rather than accidental

### Unit 4: Cognitive Bias in Technical Decisions
- Q1: Sunk cost — when to abandon a failing approach
- Q2: Confirmation bias in code reviews
- Q3: Anchoring — why the first estimate shapes all future ones

---

## Track 5: Estimation & Scale

### Unit 1: Fermi Estimation
- Q1: How many piano tuners are in Chicago? (classic — teaches the method)
- Q2: Estimating server load for a notification spike
- Q3: Sanity-checking a business claim with back-of-envelope math

### Unit 2: Orders of Magnitude
- Q1: The difference between 10ms and 10s in user experience
- Q2: When "10x more users" doesn't mean "10x more infrastructure"
- Q3: Recognising when a number is implausibly large or small

### Unit 3: Cost Estimation
- Q1: Estimating engineering cost of a feature (days, not hours)
- Q2: The hidden costs (testing, deployment, documentation, support)
- Q3: Why estimates balloon — optimism bias

### Unit 4: Capacity Thinking
- Q1: How much can this system handle before it breaks?
- Q2: Planning for peak load vs average load
- Q3: The 80% rule — why you don't want systems running at full capacity

---

## Track 6: Critical Evaluation

### Unit 1: Spotting Flawed Assumptions
- Q1: Finding the hidden assumption in a product requirement
- Q2: The requirement that contradicts itself
- Q3: Assumptions baked into data — sampling bias

### Unit 2: Edge Cases
- Q1: What happens at zero, one, and maximum?
- Q2: Time zones, empty states, concurrent users — the edge case checklist
- Q3: The edge case that becomes the common case at scale

### Unit 3: Failure Modes
- Q1: Single points of failure — finding them before they break
- Q2: Graceful degradation vs hard failure
- Q3: Cascading failures — one thing breaks, then everything does

### Unit 4: Evaluating AI Output
- Q1: Spotting confident-sounding but wrong AI answers
- Q2: When to trust AI-generated code (and when to verify)
- Q3: Prompting for edge cases the AI didn't consider

---

## Track 7: System Design Thinking

### Unit 1: Trade-offs in Architecture
- Q1: Consistency vs availability (the CAP theorem — without the jargon)
- Q2: Monolith vs microservices — when each is the right call
- Q3: Build vs buy — the honest decision framework

### Unit 2: Scalability Patterns
- Q1: Why caching is the first answer to "it's slow"
- Q2: Horizontal vs vertical scaling — the difference that matters
- Q3: When to shard a database vs when not to

### Unit 3: Reliability
- Q1: What does "99.9% uptime" actually mean in downtime per year?
- Q2: Redundancy — why two of everything isn't always better
- Q3: Designing for failure: what happens when this breaks?

### Unit 4: Bottleneck Thinking in Systems
- Q1: Finding the weakest link in a request pipeline
- Q2: Why adding servers doesn't always solve slowness
- Q3: Queues as buffers — when to add one and when not to

---

## Track 8: Communication Thinking

### Unit 1: Audience Awareness
- Q1: Explaining a technical decision to a non-technical stakeholder
- Q2: The right level of detail for a status update vs a technical spec
- Q3: When to go deep and when to stay high — reading the room

### Unit 2: Making Complexity Clear
- Q1: The one-sentence version — forcing clarity
- Q2: Analogies — when they help and when they mislead
- Q3: Structuring a technical argument: claim → evidence → implication

### Unit 3: Writing for Decisions
- Q1: What a good proposal contains (context, options, recommendation)
- Q2: The async decision doc — replacing unnecessary meetings
- Q3: Writing that ages well — capturing the "why" not just the "what"

---

## Content Writing Status

| Track | Unit 1 | Unit 2 | Unit 3 | Unit 4 | Unit 5 |
|-------|--------|--------|--------|--------|--------|
| 1: Problem Decomposition | DONE | DONE | DONE | DONE | — |
| 2: Systems Thinking | DONE | DONE | DONE | DONE | — |
| 3: Mental Models | DONE | DONE | DONE | DONE | DONE |
| 4: Decision Making | outlined | outlined | outlined | outlined | — |
| 5: Estimation & Scale | outlined | outlined | outlined | outlined | — |
| 6: Critical Evaluation | outlined | outlined | outlined | outlined | — |
| 7: System Design | outlined | outlined | outlined | outlined | — |
| 8: Communication | outlined | outlined | outlined | — | — |

Next: write full questions for Track 3, Unit 1 (Mental Models) — then continue in order.
