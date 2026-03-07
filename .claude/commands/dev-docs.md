Create comprehensive dev docs for this task: $ARGUMENTS

1. Analyze the request and the current codebase (if any Flutter code exists, read lib/ structure)
2. Create a folder: `dev/active/[task-slug]/` using a short kebab-case slug
3. Create three files in that folder:

**[task-slug]-plan.md**
- Executive summary (what and why)
- Current state of relevant code
- Implementation phases (each with acceptance criteria)
- Risk assessment
- Success metrics

**[task-slug]-context.md**
- SESSION PROGRESS section with: COMPLETED, IN PROGRESS, BLOCKERS, Next Session — Resume Here
- Quick Resume instructions
- Key files (with purpose)
- Key decisions made so far
- Technical constraints

**[task-slug]-tasks.md**
- Checkbox list organized by phase
- Quick Resume section at bottom: next task, phase X of Y, N/M tasks complete

After creating all three files, summarize the plan and ask: "Ready to implement phase 1?"
Do NOT start implementation until confirmed.
