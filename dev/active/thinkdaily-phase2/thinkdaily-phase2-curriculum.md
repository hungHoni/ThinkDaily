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

**Q1 — Easy — "Reversible or Not?"**
Prompt:
You're choosing where to host your app. Option A: AWS (easy to migrate away from). Option B: a custom datacenter (very expensive to move, tied to hardware contracts).

Which framework should guide this decision?

Options:
A) Whichever is cheaper right now
B) Whichever has the best features today
C) "Reversible decisions can be made with less analysis; irreversible ones need more"
D) They're equally important — just flip a coin

Answer: C
Explanation: Jeff Bezos calls this the two-way door vs one-way door decision. A reversible decision (AWS) can be revisited later if it's wrong. An irreversible one (custom datacenter contract) locks you in. Reversible decisions deserve 80% less analysis — make them fast. Irreversible ones deserve rigorous debate. Most teams reverse this and agonize over reversible choices.
Thinking Pattern: Decision Reversibility Framework

---

**Q2 — Medium — "Two-Way Door Opportunity"**
Prompt:
You're launching a feature, but you're not sure if users want it. You could:
A) Run an A/B test (easy to kill the feature if it flops) — takes 2 weeks
B) Spend a month refining it first, then launch to everyone
C) Ask customers upfront (they don't know what they want until they try it)
D) Launch to 10% of users, ready to kill it based on real usage

What's the best decision-making approach here?

Answer: D
Explanation: You can launch to 10% fast (reversible), learn whether the feature works, then decide to expand or kill it. This is cheaper than either refining without evidence or running a formal test. The key insight: if a decision is reversible, you have an option to "gather data by doing it," which is often better than planning alone.
Thinking Pattern: Reversible Decision (Two-Way Door)

---

**Q3 — Hard — "Making the Irreversible Reversible"**
Prompt:
You're about to acquire another company. This looks irreversible: once you merge cultures, systems, and teams, you can't "unmerge."

But your CEO proposes: "Keep them operating as a separate unit for 12 months. Prove integration works before fully merging."

What's she doing?

Options:
A) Wasting time with extra process
B) Converting an irreversible decision into a reversible one via staged commitment
C) Just delaying the inevitable
D) Being too cautious

Answer: B
Explanation: By treating the merger as a reversible "trial period," she lowers the stakes of the big decision. Full integration is irreversible; trial integration is reversible. If it fails, you can still separate. This staged-commitment approach turns high-stakes decisions into low-stakes experiments.
Thinking Pattern: Staged Commitment

---

### Unit 2: Deciding with Incomplete Information

**Q1 — Easy — "The Cost of Waiting"**
Prompt:
You're hiring a senior engineer. You could interview this candidate now (decision in 1 week) or wait for 5 more candidates to interview (decision in 1 month).

The role will be open for 3 more weeks either way.

If you wait, what are you really trying to do?

Options:
A) Make a better decision
B) Gather more information before deciding
C) Reduce the risk of hiring the wrong person
D) Both A and B, but with a hidden cost: if the first candidate was great, they've taken another job by then

Answer: D
Explanation: The cost of waiting is not zero. Information has diminishing returns. The first candidate might be in the top 2%, and waiting costs you them. Ask: "How much better does my decision need to be to justify the delay?" If the added information only improves the decision by 5%, and you're giving up a 95th-percentile candidate, you're paying the wrong price.
Thinking Pattern: Information Value vs Decision Cost

---

**Q2 — Medium — "Minimum Information"**
Prompt:
Your product team wants to know: "Should we build for mobile or desktop first?"

They propose a 4-week research project: surveys, focus groups, analytics deep-dives.

You push back: "What's the minimum we need to know to decide?"

What's the right answer?

Options:
A) At least 50% of our users are on mobile (or not)
B) Mobile users are more engaged than desktop users
C) One metric: which device produces more revenue right now?
D) Just launch on both platforms and A/B test

Answer: C
Explanation: You don't need perfect information, just enough to decide better than a coin flip. "Which device made more money last month?" is a single number that beats 4 weeks of research. If the answer is ambiguous (45% mobile, 55% desktop), then you add more data. But start with the simplest question that could change your mind.
Thinking Pattern: Minimum Viable Information

---

**Q3 — Hard — "Uncertainty vs Risk"**
Prompt:
Scenario A: You're deploying new code. There's a 0.1% chance it breaks production, but you've stress-tested it thoroughly — you know the odds.

Scenario B: You're entering a new market. You don't know the demand, the competition, the regulatory environment, or whether customers will adopt. These aren't probabilities you can estimate.

Which is riskier?

Options:
A) Scenario A — 0.1% is still a failure
B) Scenario B — because you don't even know the odds
C) They're equally risky
D) Neither — risk and uncertainty are the same thing

Answer: B
Explanation: Risk has known odds (0.1% chance of breaking prod). Uncertainty has unknown odds (you don't know if the market exists). Uncertainty is scarier because you can't compute expected value or plan for all failure modes. You handle them differently: risk you can insure/test; uncertainty you mitigate through small experiments and options.
Thinking Pattern: Uncertainty vs Risk

---

### Unit 3: Trade-offs

**Q1 — Easy — "Speed vs Quality"**
Prompt:
Two teams building the same feature.
- Team A: ships in 2 weeks with 10% bug rate
- Team B: ships in 6 weeks with 1% bug rate

You have 100k users. In 6 months, which approach loses more money?

Options:
A) Team A — 10% bug rate is intolerable
B) Team B — they lost 4 weeks of user growth and revenue
C) It depends on the severity of the bugs
D) Can't compare without knowing what the feature is

Answer: C
Explanation: If the bugs are "search returns wrong results," Team A loses more (users go elsewhere). If the bugs are "button color is wrong," Team B loses more (4 weeks of revenue > minor visual issues). Trade-offs aren't universal. The context determines the answer: severity, user impact, and time value of the feature.
Thinking Pattern: Context-Dependent Trade-offs

---

**Q2 — Medium — "The Architecture Trade-off"**
Prompt:
You're building a payment system. Option A: monolithic, simple to deploy, but one payment bug breaks everything. Option B: microservices, isolated payment logic, but complex to debug and 3× the DevOps overhead.

What's the hidden cost you must account for?

Options:
A) Microservices are always better
B) Monoliths are simpler, so always prefer them
C) The cost of your mistakes in each architecture (one coin-flip error costs very different amounts in each)
D) Deployment speed

Answer: C
Explanation: Every architecture choice has a cost function. In a monolith, a simple mistake cascades. In microservices, the same mistake is isolated, but debugging takes longer. You're not choosing "simple vs reliable" — you're choosing "which types of failures can you afford?" Choose based on your error tolerance and the cost of recovery, not on abstract principles.
Thinking Pattern: Cost Function in Architecture

---

**Q3 — Hard — "Making Trade-offs Explicit"**
Prompt:
Two engineers argue about caching strategy.
- Engineer A: "Always cache, it's faster"
- Engineer B: "Caching adds complexity; only cache if we hit scale limits"

The conversation is going nowhere. What's missing?

Options:
A) More data on performance
B) The trade-off isn't being made explicit — neither engineer is saying "I'm choosing simplicity over speed" or vice versa
C) A code review
D) A customer survey

Answer: B
Explanation: Most arguments hide a trade-off. Engineer A is implicitly saying "speed > simplicity." Engineer B is saying "simplicity > speed." Until those tradeoffs are explicit — and until you agree on the priority — you're arguing in different languages. The fix: "We're prioritizing easy debugging over raw speed until we hit 10k requests/sec. Then we cache."
Thinking Pattern: Making Trade-offs Explicit

---

### Unit 4: Cognitive Bias in Technical Decisions

**Q1 — Easy — "The Sunk Cost Fallacy"**
Prompt:
Your team spent 3 weeks building a feature using Technology X. It's slower than expected. A colleague suggests: "Let's switch to Technology Y — it's clearly better."

Your manager says: "We've already spent 3 weeks. Can't waste that."

Who's right?

Options:
A) Your manager — sunk costs matter
B) Your colleague — those 3 weeks don't matter anymore
C) Both — it's a tough call
D) Neither — the decision should be based only on future costs

Answer: B
Explanation: The 3 weeks are gone. Whether to continue is a choice between "spend 2 more weeks on X" vs "spend 3 weeks on Y." The past investment is irrelevant. Clinging to it (sunk cost fallacy) means you keep investing in bad decisions. The moment you realize a path is wrong, the sunk cost becomes a reason to change, not a reason to continue.
Thinking Pattern: Ignoring Sunk Costs

---

**Q2 — Medium — "Confirmation Bias in Code Review"**
Prompt:
Engineer A proposes a new caching layer. Engineer B reviews the PR.

Engineer B initially had doubts about caching, but during the review, she notices Engineer A found solutions to every concern she was going to raise.

She approves the PR quickly.

Six months later, the caching layer becomes the bottleneck.

What bias happened?

Options:
A) Engineer A was just better at implementation
B) Engineer B did her job correctly
C) Engineer B fell into confirmation bias — Engineer A answered her concerns so thoroughly that she stopped critically evaluating the trade-off
D) Caching is never the answer

Answer: C
Explanation: When each of your concerns is answered, it's easy to slip into "okay, they've thought of everything." But answering technical concerns ≠ proving the trade-off is worth it. Engineer B should have asked: "Is this caching layer necessary at this scale?" instead of just "Is it implemented correctly?" Confirmation bias in code reviews is the risk of being so impressed with competence that you skip the bigger question.
Thinking Pattern: Distinguishing Technical Correctness from Strategic Wisdom

---

**Q3 — Hard — "Anchoring in Estimates"**
Prompt:
Project Alpha: First estimate was "3 months." Months later, still ongoing. Team estimates: "5 more weeks." Final time: 6 months total.

Project Beta: First estimate was "8 months." It finished in 7 months.

The estimates came from different teams, different problems.

What's the anchor effect in play?

Options:
A) The first estimate in Project Alpha was too optimistic
B) The first estimate in Project Beta was pessimistic, allowing for buffer
C) Team Beta is better at estimation
D) Once an estimate is public, all future estimates "orbit" it, even if wrong

Answer: D
Explanation: In Project Alpha, the initial "3 months" became an anchor. Every revised estimate (4 months, then 5 more weeks) tried to stay close to it rather than starting from first principles. In Project Beta, the "8 months" was pessimistic enough that the final estimate could land close to it. The first number said in a room shapes all subsequent ones. To break the anchor, re-estimate from scratch without referencing the old number.
Thinking Pattern: Recognizing Anchoring

---

## Track 5: Estimation & Scale

### Unit 1: Fermi Estimation

**Q1 — Easy — "The Piano Tuner Method"**
Prompt:
How many gas stations are in your country?

To estimate this, what's the first question you should ask?

Options:
A) How many cars are registered?
B) How much gasoline does the country use per year?
C) What's the population?
D) How many gas stations did the government build?

Answer: A
Explanation: Fermi estimation works backwards from consumption. Population × cars per capita = total cars. Cars × miles per year = total miles. Miles × gallons per mile = total gallons. Gallons per station per year = number of stations. You're decomposing the big question into smaller answerable ones. The method matters more than the final number.
Thinking Pattern: Fermi Decomposition

---

**Q2 — Medium — "Server Load at 3 AM"**
Prompt:
Your app normally handles 1,000 requests/second. At 3 AM you send a notification to 1 million users.

If 5% open it immediately, that's 50,000 simultaneous requests.

Your servers can handle 1,000 req/s peak. What goes wrong?

Options:
A) 50 servers are needed (50,000 ÷ 1,000)
B) The servers will queue requests and handle them slowly
C) The system cascades: slow response times → users retry → more load → collapse
D) Nothing — just add 50 servers

Answer: C
Explanation: At 50× normal load, your system doesn't gracefully degrade. Slow responses trigger user retries. Retries add load. Load causes more slowness. This cascade collapses the system faster than linear overload would. The Fermi estimate (50× normal) is your signal to either rate-limit, queue to a background job, or provision for the spike.
Thinking Pattern: Capacity Planning with Cascading Failure

---

**Q3 — Hard — "Sanity-Checking Claims"**
Prompt:
Your CEO says: "We're capturing 0.5% market share in a $50 billion market. That's $250 million in revenue."

Run a quick Fermi check. The company has 100 employees. Average software salary is $200k. Your burn rate is ~$30 million/year.

At current growth, will you hit $250M in 5 years?

Options:
A) Yes, definitely
B) No, that's impossibly fast
C) Maybe — need more data
D) Can't estimate revenue from burn rate

Answer: B
Explanation: You're spending $30M/year on a 100-person team. $200k × 100 = $20M in salary alone. Even at 90% gross margin, you'd need ~$333M in revenue to break even. To reach $250M in 5 years means going from $0 to $50M/year revenue growth. At your burn rate and team size, that's an impossibly fast hockey stick. The claim needs much better justification.
Thinking Pattern: Sanity-Checking with Fermi Estimates

---

### Unit 2: Orders of Magnitude

**Q1 — Easy — "The 10x Difference"**
Prompt:
Response time: 10ms vs 100ms.

To a user, what's the difference?

Options:
A) Both feel instant
B) 10ms feels instant; 100ms feels slow
C) They're both just milliseconds; no practical difference
D) 10ms is 10× faster so 10× better

Answer: B
Explanation: Below ~100ms, humans perceive action as instant. Above ~500ms, they perceive lag. So 10ms and 100ms are both "instant" to users. But 10ms vs 1 second is a huge difference. You should know these bounds: 10ms instant, 100ms slow, 1s user attention lost. These bounds change how you design systems.
Thinking Pattern: Perceptual Thresholds in Performance

---

**Q2 — Medium — "10x Users Doesn't Mean 10x Infrastructure"**
Prompt:
Your database handles 1,000 concurrent users perfectly. You grow to 10,000 concurrent users.

Do you need 10x more database server resources?

Options:
A) Yes, obviously
B) No, often you need only 2-3x more
C) It depends on the query patterns
D) Database scaling doesn't work that way

Answer: C, but B is usually true
Explanation: If your bottleneck is CPU (queries), you might need 10x. But if your bottleneck was just "number of connections," adding connection pooling solves it at 1x cost. Or if 90% of traffic is reads, you add read replicas, not more write capacity. The lesson: 10x users ≠ 10x resources. Understand your bottleneck first. Most systems can 3-5x before needing radical redesign.
Thinking Pattern: Bottleneck Analysis

---

**Q3 — Hard — "Implausible Numbers"**
Prompt:
A startup claims: "We're growing 10% per week and will have 1 billion users in 3 years."

Do the math: 1 billion ÷ (1.1^156 weeks) = starting from ~80 users. Is this plausible?

What's the real issue?

Options:
A) The growth rate will drop as they scale (which it always does)
B) The math checks out, so it's possible
C) They're not accounting for market size (only ~5 billion internet users exist)
D) Both A and C

Answer: D
Explanation: The claim fails on two fronts. First, 10% weekly growth is possible for 18 months; after that, it crashes as the market saturates. Second, 1B users exceeds the global internet population. Sanity-check large numbers against: market size, historical precedent (did any company grow this fast?), and diminishing returns. If a number seems implausible, the claim probably is.
Thinking Pattern: Questioning Implausible Growth Claims

---

### Unit 3: Cost Estimation

**Q1 — Easy — "Days, Not Hours"**
Prompt:
You're asked: "How long to implement user authentication?"

A junior engineer says: "15 hours."
A senior engineer says: "3 weeks."

Who's more accurate and why?

Options:
A) The junior engineer — 15 hours is 2 days of work
B) The senior engineer — auth is complex, needs testing
C) The junior engineer for the code; the senior engineer for the project
D) It depends on the specific requirements

Answer: C
Explanation: The junior is estimating code time (15 hours of typing). The senior is estimating project time (design, testing, documentation, deployment, rollback plan, monitoring, on-call support). Real cost = code time + overhead. For a small feature, overhead might be 3x. For auth, it's higher because the stakes are security. Estimate in "weeks" for project scope, not "hours" for code.
Thinking Pattern: Project Cost vs Code Time

---

**Q2 — Medium — "Hidden Costs"**
Prompt:
A feature is estimated at "40 hours of development." You ship it. But then:
- Testing finds 2 days of bugs
- Documentation takes 1 day
- Deployment and monitoring setup takes 1 day
- 1 week of on-call support (paying engineers to monitor it)
- 2 days of follow-up fixes

What's the true cost?

Options:
A) 40 hours
B) 40 + (2+1+1+5+2) = 51 hours (30% overhead)
C) 40 × 2.5 = 100 hours (true project cost)
D) Infinity — ongoing support is never "done"

Answer: C
Explanation: The original 40 hours was just coding. Add testing (60% of code time), deployment (20%), and support (50%). Total is often 2-3x the initial estimate. If you quote a client "40 hours," they'll be shocked when the true bill is 100. Always quote project cost, not code time. Experienced teams use a multiplier: 2.5-3x for well-defined features.
Thinking Pattern: Full Cost Accounting

---

**Q3 — Hard — "Why Estimates Balloon"**
Prompt:
You estimate a feature at 4 weeks. 6 months later, it's still being tweaked.

Three things went wrong:
1. Initial estimate assumed no blockers
2. Stakeholders kept adding requirements
3. The team hit unexpected technical debt halfway through

Which is hardest to predict upfront?

Options:
A) Blockers — you should expect 20% of time spent unblocked
B) Scope creep — ask stakeholders to freeze requirements
C) Technical debt — you don't know what you don't know
D) All three are equally unpredictable

Answer: C
Explanation: Blockers are foreseeable (add 20% buffer). Scope creep is avoidable (scope lock). But technical debt hits you mid-sprint when you realize "this codebase is a mess" or "the API isn't what we need." You can't estimate what you don't know. The fix: time-box, iterate, and plan for the unknown unknowns. Never quote a single estimate for something you haven't started.
Thinking Pattern: Estimating Under Uncertainty

---

### Unit 4: Capacity Thinking

**Q1 — Easy — "The Breaking Point"**
Prompt:
Your database can handle 10,000 simultaneous connections. Today you have 8,000.

Do you have headroom or are you in danger?

Options:
A) You have 20% headroom, so you're safe for 2 more weeks
B) 80% utilisation is dangerously high — you're one spike away from crashing
C) It depends on your peak load vs average load
D) You should start planning to scale immediately

Answer: C
Explanation: If those 8,000 are average, and your peak is 9,000, you're fine. If 8,000 is your baseline and you spike to 10,000 during lunch, you'll hit the limit. Capacity planning isn't about the number — it's about peak load vs capacity. If average is 8k and peak is 9.5k, you have 500 connections of headroom. If peak is 10k, you're at the cliff and need to scale now.
Thinking Pattern: Peak Load vs Average Load

---

**Q2 — Medium — "Planning for the Spike"**
Prompt:
Your app normally handles 1,000 requests/second. During a marketing campaign or viral moment, it might hit 10,000 req/s for 30 minutes.

Should you:
A) Build capacity for 10k req/s permanently (expensive, unused 99% of the time)
B) Build capacity for 2k req/s and rate-limit spikes
C) Build capacity for 5k req/s and queue overflow traffic
D) Hope it doesn't happen

Answer: C
Explanation: Option A is wasteful (9k req/s idle capacity costs 10× more). Option B ruins user experience (they see "service unavailable"). Option C balances cost and experience: you handle 5x traffic, queue the rest, and burn through the queue over 5 minutes. Cost is reasonable, experience is acceptable. This is why queues exist: to decouple traffic spikes from backend capacity.
Thinking Pattern: Handling Load Spikes with Queues

---

**Q3 — Hard — "The 80% Rule"**
Prompt:
Your database server can handle 100 transactions per second. You're running at 80 transactions/sec.

Your infrastructure team says: "We need to upgrade now, before it gets worse."

Operations says: "We're at 80%. We still have 20% headroom. It's fine."

Who should win this decision?

Options:
A) Operations — 20% headroom is safe
B) Infrastructure — 80% utilization means unpredictable performance
C) They need more context
D) Just scale to 90% and check again later

Answer: B
Explanation: Above 80% utilization, system behavior becomes unpredictable. Contention increases, latency becomes variable, and small traffic spikes cause cascading failures. At 80%, you have headroom, but you're in the danger zone. The rule of thumb: keep systems at ≤70% utilization for predictable performance. At 80%, you're one bad day away from an outage. Start planning the upgrade now.
Thinking Pattern: Utilization Headroom

---

## Track 6: Critical Evaluation

### Unit 1: Spotting Flawed Assumptions

**Q1 — Easy — "The Hidden Assumption"**
Prompt:
Requirement: "Users want to see their purchase history sorted by date."

What assumption is hidden in this requirement?

Options:
A) Users have purchase history
B) Users want to view history at all
C) Date sorting is more useful than sorting by category, price, or status
D) All of the above

Answer: D
Explanation: The requirement assumes users exist, they've made purchases, they want to see them, and date is the right sort order. Any of these could be wrong. Before building, ask: "Do users actually view history? What do they do with it? Is date the most useful sort?" Never trust a requirement at face value. Excavate the assumptions buried in it.
Thinking Pattern: Assumption Excavation

---

**Q2 — Medium — "The Contradictory Requirement"**
Prompt:
A stakeholder says: "The app should be simple for new users and powerful for experts."

Later, they add: "Every screen must fit on a mobile phone with no scrolling."

These can't both be true. Simple-yet-powerful requires options. Mobile-no-scroll requires minimalism.

What's the right move?

Options:
A) Build both and let the user choose
B) Ask which is more important and make the trade-off explicit
C) Build it simple first, add power later
D) It's possible with the right UX design

Answer: B
Explanation: The requirements contradict. You must choose: optimize for simplicity (and sacrifice power) or optimize for power (and sacrifice simplicity). Or find a different constraint to negotiate (maybe scrolling is okay, or maybe mobile isn't the priority platform). Make the trade-off explicit and owned. Never build a contradiction hoping it magically resolves.
Thinking Pattern: Contradiction Detection

---

**Q3 — Hard — "Sampling Bias in Data"**
Prompt:
You analyze your user survey: "92% of customers are satisfied."

But you surveyed only users who opened your in-app feedback form.

What's wrong with this conclusion?

Options:
A) 92% is too high; real satisfaction is lower
B) You've sampled the easy-to-reach users, not the whole population
C) Users who open feedback forms might be different from those who don't (selection bias)
D) All of the above

Answer: D
Explanation: By surveying only in-app feedback openers, you miss silent dissenters who've left. You've selected for users engaged enough to give feedback, who might be more satisfied than the average. This selection bias inflates satisfaction. The fix: sample randomly, or acknowledge the bias in reporting ("of engaged users").
Thinking Pattern: Selection Bias Recognition

---

### Unit 2: Edge Cases

**Q1 — Easy — "The Zero, One, Many Rule"**
Prompt:
You're building a shopping list. You need to test edge cases.

Which are critical?

Options:
A) 0 items (empty list), 1 item (minimum), 100 items (scale)
B) 0 items, 1000 items, 1 million items
C) Just 1 item (normal case)
D) Only the case with many items (that's where bugs hide)

Answer: A
Explanation: The zero, one, many rule catches most bugs. Zero items: does the UI crash or show an empty state? One item: do arrays work correctly? Many items: does pagination work? You don't need to test 100 and 1000 — both reveal the same patterns. Most bugs hide at the boundaries (0) or the transitions (one → many).
Thinking Pattern: Zero-One-Many Testing

---

**Q2 — Medium — "The Edge Case Checklist"**
Prompt:
You're shipping a notification feature. What's the edge case most engineers miss?

Options:
A) No notifications (empty state)
B) The notification arrives in a different timezone than the user
C) Two notifications arrive at the same millisecond
D) A user deletes their account while viewing notifications

Answer: B
Explanation: Timezone issues hide in plain sight. If you store notification times in UTC but display them locally, a user in Tokyo sees different times than NYC. This breaks sorting and UX. Other sneaky edge cases: concurrent actions (what if the user clicks twice?), state transitions (what if the notification is deleted mid-render?), and time-dependent logic (does this work at midnight on a leap second?). Build a habit of thinking through time, concurrency, and state transitions.
Thinking Pattern: Edge Case Categories

---

**Q3 — Hard — "The Scaling Edge Case"**
Prompt:
Your payment system works perfectly with 1,000 concurrent users. At 10,000 users, a subtle bug emerges:

Race condition: two charges go through instead of one.

This bug existed at 1,000 users but never triggered. At 10,000, it triggers regularly.

Why didn't testing catch it?

Options:
A) The tests were insufficiently thorough
B) Concurrency bugs only manifest under high load; you can't predict them in advance
C) The system was never stress-tested
D) The edge case (concurrent identical requests) is statistically rare at small scale

Answer: D
Explanation: The race condition existed at 1,000 users, but the odds of two identical requests arriving in the same millisecond were tiny. At 10,000 users, the collision probability jumps. This is the edge case that becomes the common case at scale. The lesson: stress-test early and often. What's statistically impossible at 1k might be common at 100k.
Thinking Pattern: Scale-Dependent Edge Cases

---

### Unit 3: Failure Modes

**Q1 — Easy — "Finding the Single Point of Failure"**
Prompt:
Your app architecture:
- Frontend talks to one API server
- API server talks to one database
- Database writes to one backup disk

Where will the system fail first?

Options:
A) The API server (single point of failure)
B) The database (single point of failure)
C) The backup disk (least critical)
D) The frontend (user-side failure)

Answer: A
Explanation: If the API server goes down, users can't reach the service. The database is backed up (redundancy), but the API is a bottleneck. Single points of failure are architectural weaknesses. The fix: run multiple API servers behind a load balancer. Identify every service that, if it fails, breaks the whole system. Those are your priorities for redundancy.
Thinking Pattern: Identifying Single Points of Failure

---

**Q2 — Medium — "Graceful Degradation vs Hard Failure"**
Prompt:
Your recommendation system calls an ML service. If the ML service times out, should you:
A) Return an error page ("Recommendations unavailable")
B) Return the last cached recommendation (best-effort)
C) Return a random selection (reasonable fallback)
D) Retry infinitely until the service responds

Answer: B or C
Explanation: Hard failure (A) = bad UX. Infinite retry (D) = cascading failure. Graceful degradation means offering something useful when the primary system fails. Stale recommendations (B) or random picks (C) are better than "service unavailable." This is how robust systems work: every dependency has a fallback. If you can't degrade gracefully, the dependency is critical — make it resilient instead.
Thinking Pattern: Fault Tolerance Design

---

**Q3 — Hard — "Cascading Failures"**
Prompt:
Event sequence:
1. The payment service is slow (5-second responses)
2. The web server has a 10-second timeout
3. So web requests wait 10s, then timeout
4. Users retry, generating more load
5. More load makes the payment service slower
6. More slow requests → more timeouts → more retries → more load → collapse

This is a cascading failure. How do you break the cycle?

Options:
A) Increase the 10-second timeout to 30 seconds
B) Add a circuit breaker to stop calling the payment service when it's slow
C) Scale up the payment service
D) Both B and C

Answer: D
Explanation: A makes it worse (timeouts just come later). B is critical (stop calling a failing service; let it recover). C addresses root cause. The real lesson: cascading failures require circuit breakers. When a service is slow, fail fast and queue the request instead of blocking. Give the service time to recover. If you don't, a single slow service will bring down your entire platform.
Thinking Pattern: Circuit Breaker Pattern

---

### Unit 4: Evaluating AI Output

**Q1 — Easy — "Confident and Wrong"**
Prompt:
Claude gives you this code to count unique items in a list:

```
result = len(set([1, 1, 2, 2, 2, 3]))
```

The explanation says: "Sets automatically remove duplicates, so the length of the set is the count of unique items."

Is this correct?

Options:
A) Yes, perfectly correct
B) No, sets require sorting first
C) No, the logic is correct but the explanation implies the code also removes duplicates from the original list (it doesn't)
D) No, this doesn't work in Python

Answer: A
Explanation: The code and explanation are both correct. But this illustrates the risk: AI can sound confident while being subtly wrong. For instance, if the answer were "lists automatically remove duplicates," that would sound equally confident but be false. Always verify AI output by testing, thinking through the logic, and checking against authoritative sources. Confidence and correctness are not correlated.
Thinking Pattern: Verifying AI Output

---

**Q2 — Medium — "When to Trust AI Code"**
Prompt:
You ask Claude to write a password hashing function. The code uses bcrypt and includes salt generation.

Should you:
A) Use it as-is; AI knows security
B) Review it carefully and verify it matches bcrypt best practices
C) Test it before using it
D) Both B and C

Answer: D
Explanation: Security code needs verification. Bcrypt is a standard library, so correct usage is likely. But verify: Is the salt length correct? Are the rounds appropriate? Does error handling prevent timing attacks? AI can generate plausible code, but security requires scrutiny. Never deploy AI-generated security code without review by a security expert or reference against official documentation.
Thinking Pattern: Trust but Verify (Especially for Security)

---

**Q3 — Hard — "Prompting for Missed Edge Cases"**
Prompt:
You ask Claude to write a date parser. It handles common formats: "2025-03-13", "2025/03/13", "March 13, 2025".

What edge case should you ask Claude about?

Options:
A) Leap years
B) Timezones
C) Ambiguous dates (03-04-2025 is March 4 or April 3?)
D) All of the above

Answer: D
Explanation: The generated code handles the happy path but misses subtle cases. The fix: before accepting AI-generated code, ask: "What happens with leap years? Timezones? Ambiguous formats?" This makes the AI second-guess itself and often reveals bugs it missed. The best prompt is one that says: "What edge cases does this code not handle?" AI will often find them if explicitly asked.
Thinking Pattern: Defensive Prompting

---

## Track 7: System Design Thinking

### Unit 1: Trade-offs in Architecture

**Q1 — Easy — "CAP Theorem Without the Jargon"**
Prompt:
You're designing a banking system. A network partition (two datacenters lose connection) happens.

You can:
A) Keep accepting deposits on both sides; reconcile later (risk: double-counting)
B) Stop accepting deposits on one side until they reconnect (users see outage)

Which is the trade-off you're making?

Options:
A) Performance vs security
B) Availability vs consistency
C) Cost vs reliability
D) Simplicity vs scalability

Answer: B
Explanation: CAP theorem says: in a network split, you choose consistency (A safe, but B's site is down) or availability (both sites work, but data might diverge). Most systems choose consistency for money. Social networks choose availability (a like might appear twice, who cares?). The point isn't the jargon — it's recognizing that no system has all three: consistency, availability, partition tolerance. You must sacrifice one.
Thinking Pattern: CAP Trade-offs

---

**Q2 — Medium — "Monolith vs Microservices"**
Prompt:
A startup has 10 engineers building a social app. Monolith or microservices?

Five years later, 100 engineers. Monolith or microservices?

Why is the answer different?

Options:
A) Microservices is always better — start with it
B) Monolith is always better — simpler to build
C) At 10 people, you move slower with microservices (org overhead). At 100, monoliths collapse (too many features competing)
D) The choice depends on tech stack, not team size

Answer: C
Explanation: Conway's Law: architecture mirrors organization. 10 people sharing one monolith = fast, no coordination overhead. 100 people on one monolith = chaos, constant merge conflicts, deployments risk everything. At 100 people, split the system so teams own their services independently. But don't start there — the overhead of microservices coordination isn't worth it when you're small.
Thinking Pattern: Architecture as an Organization Problem

---

**Q3 — Hard — "Build vs Buy"**
Prompt:
You're building a payments platform. You could:
A) Buy Stripe (pay per transaction, no control)
B) Build payment processing yourself (control, but 6-month effort, compliance nightmare)

When should you build instead of buy?

Options:
A) When you want full control
B) When the bought solution doesn't fit your use case
C) When the cost of buying is higher than the cost of building
D) When you're certain the product won't change and you'll maintain it forever

Answer: C
Explanation: "Build vs buy" is a cost-benefit analysis. Stripe costs ~2.9% per transaction. For $1M annual volume, that's $29k/year. Building costs 6 months of two engineers = $300k + ongoing maintenance. Buy Stripe. But if your volume is $100M/year, that's $2.9M/year, and building might be cheaper over 5 years. The hidden factor: build requires perfect execution and forever maintenance. Buy shifts that burden to the vendor.
Thinking Pattern: Total Cost of Ownership

---

### Unit 2: Scalability Patterns

**Q1 — Easy — "Why Caching is the First Answer"**
Prompt:
Your database is slow. Response times: 500ms.

The ops team suggests:
A) Add caching in front (result: 5ms)
B) Scale the database (cost: 10× more machines)
C) Optimize the queries (3-month effort)

What's the right first move?

Options:
A) A — it's the fastest, cheapest fix
B) B — databases are the source of truth
C) C — optimize first, then cache
D) None; the problem is elsewhere

Answer: A
Explanation: Caching is the highest-ROI scaling tactic. If your data doesn't change every second, cache it for 5-60 minutes. This reduces database load exponentially and drops latency from 500ms to 5ms. You should always cache before scaling infrastructure. Only scale when you've exhausted caching, query optimization, and indexing.
Thinking Pattern: Caching as Primary Scaling Strategy

---

**Q2 — Medium — "Horizontal vs Vertical Scaling"**
Prompt:
Your single database server is at 90% CPU. You could:
A) Vertical: buy a 10× more powerful server ($100k)
B) Horizontal: split data across 3 servers ($30k) but now you need distributed transactions

What's the real trade-off?

Options:
A) Cost vs simplicity
B) Vertical is always better
C) Horizontal is always better
D) Depends on the workload

Answer: D
Explanation: Vertical scales easily (just upgrade) but has a ceiling (no server is infinitely powerful). Horizontal scales forever but introduces complexity (distributed systems are hard). If your workload is read-heavy, horizontal (sharding reads) is cheap. If you need atomic transactions across all data, vertical is simpler until you hit the ceiling.
Thinking Pattern: Recognizing When Each Scaling Strategy Wins

---

**Q3 — Hard — "When to Shard a Database"**
Prompt:
You have a database of 500 million users. It's slow.

Your options:
A) Shard by user ID (user 1-100M on shard 1, etc.)
B) Shard by geography (US users on server 1, EU on server 2)
C) Add read replicas instead of sharding

When is (A) the right choice?

Options:
A) When you have more data than one server can handle
B) When queries are distributed evenly across all rows
C) When you're certain the sharding key won't change
D) When you've exhausted caching and vertical scaling

Answer: D
Explanation: Sharding is complex and requires the key (user ID) to be used in every query. If you shard by user ID but then run queries like "all users in California," you need to query all shards. Bad sharding is worse than no sharding. Only shard when: single-machine limits are hit, your queries naturally use the shard key, and you can distribute evenly. Otherwise, read replicas are simpler.
Thinking Pattern: Sharding as a Last Resort

---

### Unit 3: Reliability

**Q1 — Easy — "What 99.9% Uptime Actually Means"**
Prompt:
Your SLA promises "99.9% uptime."

In one year, how much downtime is that?

Options:
A) 10 minutes
B) 1 hour
C) 9 hours
D) 1 day

Answer: C
Explanation: 99.9% of 365 days = 0.999 × 365 × 24 hours = 8.76 hours/year. That's one unexpected outage per quarter. Most teams think "99.9% is great," but it means you can't afford more than one significant incident per year. 99.99% (4 nines) = 52 minutes/year. 99.999% (5 nines) = 5 minutes/year. Know what you're promising.
Thinking Pattern: Interpreting SLA Numbers

---

**Q2 — Medium — "Redundancy Doesn't Mean Two of Everything"**
Prompt:
A company runs two database servers for redundancy. But both are in the same datacenter.

A power outage hits. Both go down.

What's the lesson?

Options:
A) Two servers are useless
B) Redundancy only matters if the redundant systems can fail independently
C) You need three servers, not two
D) Redundancy is too expensive

Answer: B
Explanation: Redundancy protects against component failure, not shared-failure modes. Two servers in the same datacenter fail together in a power outage, fire, or network cut. True redundancy means geographic distribution (different datacenters), different power supplies, or both. The rule: redundancy is useful only if the failures are independent.
Thinking Pattern: Independent Failure Modes

---

**Q3 — Hard — "Designing for Failure"**
Prompt:
You're building a critical system. You design every component with redundancy: dual servers, dual databases, dual networks.

But one day, a cascading failure takes down the whole system.

What went wrong?

Options:
A) You didn't have enough redundancy
B) You designed each component for failure but not the system as a whole
C) The failure was unforeseeable
D) Redundancy doesn't prevent cascading failures

Answer: B
Explanation: Designing for failure means: every component fails independently, but the system degrades gracefully. A cascading failure happens when component A fails → timeouts → component B fails → load spike → component C fails. The fix: circuit breakers, timeouts, and fallbacks at every boundary. One component failing shouldn't cascade. This is system-level design, not component-level.
Thinking Pattern: System-Level Fault Tolerance

---

### Unit 4: Bottleneck Thinking in Systems

**Q1 — Easy — "Finding the Weakest Link"**
Prompt:
Your request pipeline: Client → Proxy → API → Cache → Database.

Each component can handle:
- Proxy: 10k req/s
- API: 5k req/s
- Cache: 50k req/s
- Database: 3k req/s

What's the bottleneck?

Options:
A) The proxy (first thing the request hits)
B) The API (in the middle)
C) The database (lowest number: 3k req/s)
D) It depends on the request pattern

Answer: C
Explanation: The bottleneck is the weakest link: the database at 3k req/s. No amount of caching, proxy scaling, or API replicas fixes this. You need more database capacity. The bottleneck is not always obvious; it's wherever the constraint is tightest. Find it with profiling, not guessing.
Thinking Pattern: Constraint Identification

---

**Q2 — Medium — "Why More Servers Don't Always Help"**
Prompt:
Your app is slow. You add more servers. Still slow.

Three possible reasons:
A) You're not actually scaling the bottleneck (maybe it's the database)
B) The new servers aren't being used (load balancer misconfiguration)
C) The problem is elsewhere entirely (network, cache miss, lock contention)

How do you diagnose which?

Options:
A) Look at CPU/memory on the new servers — if it's low, they're not being used
B) Profile the request pipeline to find where time is spent
C) Measure database query time and API response time
D) All of the above

Answer: D
Explanation: Scaling is useless if you're not scaling the bottleneck. To find it: profile (where is time spent?), measure components (API 10ms, DB 400ms), and check that new resources are actually being used. Throwing hardware at the problem without diagnosis is wasteful.
Thinking Pattern: Systematic Bottleneck Diagnosis

---

**Q3 — Hard — "Queues as Buffers"**
Prompt:
Your API can process 1k requests/sec. Traffic spikes to 5k requests/sec for 5 minutes.

Option A: Users see "service busy" (drop requests)
Option B: Queue requests, process 1k/sec, accumulate 4k backlog
Option C: Add more API servers instantly (impossible)

Should you add a queue?

Options:
A) Yes — buffer the spike, process later
B) No — users will see slow responses (5 min wait)
C) Only if the requests are idempotent
D) Queues are a last resort

Answer: A, with the caveat that B's penalty matters
Explanation: Queues decouple traffic spikes from processing capacity. Users wait 5 minutes instead of seeing "busy." This is better for many use cases (background jobs, email) but worse for latency-critical ones (real-time trading). The rule: use a queue when you can tolerate the delay. If a 5-minute wait is unacceptable, you need more API capacity, not a queue.
Thinking Pattern: Queue Trade-offs (Throughput vs Latency)

---

## Track 8: Communication Thinking

### Unit 1: Audience Awareness

**Q1 — Easy — "Explaining to Non-Technical Stakeholders"**
Prompt:
You're explaining why a deployment failed to the CFO. Which approach is better?

A) "The microservices architecture experienced a cascading failure in the event-driven message queue, causing timeouts in the distributed transaction handler."

B) "We pushed an update to production. A bug made one of our systems slow, which caused other systems to pile up with work they couldn't process fast enough. The whole thing got stuck."

What's the difference?

Options:
A) B is simpler but less accurate
B) A is more impressive technically
C) B is correct; A uses jargon that obscures meaning
D) Both are equally good for different audiences

Answer: C
Explanation: The CFO doesn't need jargon. They need to understand: what broke, why, and how much it cost. B answers that. A uses technical terms that don't convey meaning to non-engineers. Good communication adapts to the audience. Jargon makes you sound smart; clarity makes you effective.
Thinking Pattern: Audience-Adapted Explanation

---

**Q2 — Medium — "Detail Level: Status vs Spec"**
Prompt:
Your manager asks for a status update on a feature.

Option A (5 minutes): "We're 60% done. Should ship Friday."
Option B (20 minutes): "Unit tests for auth: done. Integration tests: 80% done. API endpoints: 3 of 4 complete. Blocked on database schema review by the DBA. Risk: Friday might slip to Monday if schema review takes >1 day."

Manager asks: "Which would you prefer?"

Options:
A) Just the 5-minute version; they don't have time for details
B) Just the 20-minute version; it shows you've thought it through
C) It depends on what the manager needs to know
D) Always provide both

Answer: C
Explanation: If the manager is checking progress (1-on-1), option A is enough. If they're determining whether to commit to Friday (planning), option B is critical. Match detail to decision. The principle: provide the minimum information needed to make the decision, plus visible uncertainty.
Thinking Pattern: Audience-Appropriate Detail

---

**Q3 — Hard — "Reading the Room"**
Prompt:
You're in a meeting presenting a technical proposal. Halfway through, you notice:
- The CEO has stopped taking notes
- The CFO is checking email
- One engineer is leaning forward, engaged

What should you do?

Options:
A) Keep going — finish your prepared slides
B) Ask: "Should I go deeper or move to the recommendation?"
C) Stop and ask what they want to know
D) Adjust on the fly, shift to high-level summary

Answer: B or D
Explanation: The room is telling you something. The executive audience is losing interest; the engineer wants depth. Don't plow through. Instead: "Should I dive into the technical details or jump to why this matters?" This re-engages them and shows you respect their time. Reading the room means being flexible, not following a script.
Thinking Pattern: Real-Time Audience Feedback

---

### Unit 2: Making Complexity Clear

**Q1 — Easy — "The One-Sentence Rule"**
Prompt:
Your system uses a distributed cache with eventual consistency. This is complex: data might be stale, conflicts require resolution, etc.

How would you explain it in one sentence to a non-engineer?

Options:
A) "We use a distributed cache with eventual consistency to handle CAP theorem trade-offs."
B) "We keep copies of data on multiple servers. They're not perfectly in sync, but that's okay because the delay is tiny."
C) "It's a caching layer."
D) Can't explain this in one sentence

Answer: B
Explanation: B is clear. A uses jargon. The test: if you can't explain it simply, you don't understand it yet. Forcing yourself to write one sentence clarifies your own thinking. If it's truly too complex for one sentence, the system might be unnecessarily complex.
Thinking Pattern: Simplification Through Constraint

---

**Q2 — Medium — "Analogies: Help or Harm?"**
Prompt:
You're explaining blockchain to a non-technical person.

Analogy A: "Blockchain is like a ledger that everyone has a copy of."
Analogy B: "Blockchain is like a notebook where you write down transactions, and once written, the ink can't be erased."

Which analogy breaks down first?

Options:
A) A — doesn't explain immutability
B) B — doesn't explain the "chain" part or consensus
C) Both, but B breaks down faster in a detailed technical discussion
D) Analogies always break down; never use them

Answer: C
Explanation: Analogy A clarifies decentralization but misses immutability. Analogy B clarifies immutability but misses hashing. No analogy survives detailed scrutiny. Use analogies to convey one core idea clearly, then acknowledge where they break. Don't force an analogy to do too much work.
Thinking Pattern: Knowing When Analogies End

---

**Q3 — Hard — "Structuring a Technical Argument"**
Prompt:
You're proposing to migrate from PostgreSQL to MongoDB. You structure your argument:

1. Claim: "MongoDB is faster."
2. Evidence: "Our queries are 50% slower in PG than in the benchmark."
3. Implication: "So we should migrate."

What's wrong with this structure?

Options:
A) Claim is too strong
B) Evidence doesn't support the claim (benchmark ≠ your actual workload)
C) Missing the counter-argument and trade-offs (MongoDB loses transactions, gains flexibility)
D) All of the above

Answer: D
Explanation: Good arguments: make a precise claim (not "faster" but "reduce query latency from 200ms to 100ms"), back it with evidence from your system (not a benchmark), acknowledge trade-offs explicitly ("we lose ACID transactions but gain flexibility"), and explain the decision ("the speed gain justifies the trade-off given our access patterns"). Weak arguments ignore context, trade-offs, and counter-evidence.
Thinking Pattern: Logically Sound Arguments

---

### Unit 3: Writing for Decisions

**Q1 — Easy — "What a Good Proposal Contains"**
Prompt:
You're proposing a new logging system. What must the proposal include for stakeholders to decide?

Options:
A) Problem (current logging is slow), solution (new system), cost
B) Problem, solution, cost, timeline, risk, trade-offs, and the recommended choice
C) Just the recommended solution; the rest is noise
D) Technical architecture; business people don't need it

Answer: B
Explanation: A good proposal answers: What's broken? What's the fix? What does it cost? When? What could go wrong? What do we lose (trade-offs)? What do I recommend and why? Without all of these, stakeholders make uninformed decisions or ask 10 follow-up questions. Do the thinking upfront.
Thinking Pattern: Proposal Completeness

---

**Q2 — Medium — "The Async Decision Doc"**
Prompt:
Your team debates whether to use PostgreSQL or MySQL for a new service.

Option A: "Call a 1-hour meeting, debate in real-time, decide."
Option B: "Write a 2-page decision doc: problem, options, pros/cons, recommendation. Circulate. Gather feedback async. Decide."

When is B better?

Options:
A) Never — meetings are more efficient
B) When the decision affects multiple teams or has long-term impact
C) When people have thought-through views to contribute
D) All of the above

Answer: D
Explanation: Async docs are slower to write but faster to decide. They force clarity (you must write your thinking), allow thinking time (people read and think before responding), and create a record (future teams know why you chose PostgreSQL). Use docs for decisions that: affect many people, have trade-offs, or need buy-in.
Thinking Pattern: Async Decision-Making

---

**Q3 — Hard — "Writing That Ages Well"**
Prompt:
You ship a feature with a workaround: the UI polls the server every 5 seconds instead of using proper WebSockets.

Option A (comment): "Polling every 5s — low effort, good enough for now."
Option B (comment): "Polling every 5s until WebSocket support is added (Task #1234). Using polling because we launched with limited backend time; WebSockets require database refactor (Task #2345) and frontend auth changes (Task #1122). Revisit in Q3 when bandwidth is available."

Which comment will still be useful in 6 months?

Options:
A) A — concise, doesn't clutter the code
B) B — too verbose, clutters the code
C) B — because it captures the "why" and links to the real work
D) Neither matters; code speaks for itself

Answer: C
Explanation: In 6 months, a new engineer reads the code and wonders: "Why polling?" Option A gives no hint. Option B explains the decision and the path to fix it, plus links to related work. Good comments capture the "why" and the context ("we chose X because Y, plan to fix with Z"). This is how knowledge survives team turnover.
Thinking Pattern: Future-Proof Documentation

---

## Content Writing Status

| Track | Unit 1 | Unit 2 | Unit 3 | Unit 4 | Unit 5 |
|-------|--------|--------|--------|--------|--------|
| 1: Problem Decomposition | DONE | DONE | DONE | DONE | — |
| 2: Systems Thinking | DONE | DONE | DONE | DONE | — |
| 3: Mental Models | DONE | DONE | DONE | DONE | DONE |
| 4: Decision Making | DONE | DONE | DONE | DONE | — |
| 5: Estimation & Scale | DONE | DONE | DONE | DONE | — |
| 6: Critical Evaluation | DONE | DONE | DONE | DONE | — |
| 7: System Design | DONE | DONE | DONE | DONE | — |
| 8: Communication | DONE | DONE | DONE | — | — |

**Next: Code all questions (96 total) into problem_local_source.dart**
