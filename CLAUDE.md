# Project: ThinkDaily — Flutter Mobile App

## Quick Commands
```bash
flutter run              # Run on device/emulator
flutter build apk        # Build Android APK
flutter build ios        # Build iOS
flutter test             # Run tests
flutter pub get          # Install dependencies
flutter pub upgrade      # Upgrade dependencies
flutter analyze          # Analyze code
```

---

## MANDATORY WORKFLOW — FOLLOW IN ORDER, NO EXCEPTIONS

### STEP 1 — Session Start (ALWAYS)
At the start of every session:
1. Check `dev/active/` for any in-progress tasks
2. If a task folder exists, read files in this order:
   - `[task]-context.md` first (current state + resume point)
   - `[task]-tasks.md` (what's done, what's next)
   - `[task]-plan.md` only if full strategy is needed
3. Resume from the exact point `context.md` says to resume
4. If `dev/active/` is empty — ask the user what to work on

When the user says "continue" → ALWAYS check `dev/active/` first. No exceptions.

---

### STEP 2 — Before Writing ANY Flutter/Dart Code (BLOCKING)

**MANDATORY: Load the `flutter-dev-guidelines` skill using the Skill tool BEFORE writing any Flutter or Dart code.**

```
Skill tool → skill: "flutter-dev-guidelines"
```

This is a BLOCKING requirement. Do NOT write Flutter code first and load the skill after.
Do NOT skip this step even if the skill was loaded earlier in the same session.
The UserPromptSubmit hook will remind you — treat that reminder as a hard gate, not a suggestion.

---

### STEP 3 — During Implementation

- Implement ONE PHASE AT A TIME — do not jump ahead to the next phase
- Check off tasks in `tasks.md` IMMEDIATELY after completing each task (not in batch)
- Update `context.md` SESSION PROGRESS after each major milestone
- When context is running low → run `/dev-docs-update` before compacting

**Hook compliance (PostToolUse):**
After every Write or Edit tool call, the PostToolUse hook may surface IDE diagnostics.
ALWAYS act on those diagnostics before moving to the next task. Fix all warnings and errors immediately.

---

### STEP 4 — Before Calling a Phase/Feature DONE (BLOCKING)

**MANDATORY: Run the `code-architecture-reviewer` agent BEFORE marking any phase complete or updating dev docs.**

```
Agent tool → subagent_type: "code-architecture-reviewer"
```

This is a BLOCKING requirement. Do NOT update `tasks.md` or `context.md` to mark a phase done
until the architecture review has been completed and all HIGH and MEDIUM issues are fixed.

---

### STEP 5 — Phase Complete

After architecture review passes:
1. Mark all tasks complete in `tasks.md`
2. Update `context.md` — move completed items, set next resume point
3. Run `flutter analyze` → must show "No issues found"
4. Run `build_runner` if any models or providers changed

---

### STEP 6 — Session End / Context Running Low

Run `/dev-docs-update` to save session progress before context compacts.

---

## Skills

| Trigger | Skill | How to Load |
|---------|-------|-------------|
| Any Flutter/Dart code | `flutter-dev-guidelines` | `Skill tool → "flutter-dev-guidelines"` |
| New feature planning | `dev-docs` | `/dev-docs [description]` |
| Saving session state | `dev-docs-update` | `/dev-docs-update` |

---

## Agents

| When | Agent | Purpose |
|------|-------|---------|
| BEFORE marking any phase done | `code-architecture-reviewer` | Architecture + pattern review |
| AFTER /dev-docs, BEFORE implementing | `plan-reviewer` | Validate plan before coding |
| Unknown errors / package research | `web-research-specialist` | Debugging, package evaluation |

---

## Task Management

| Action | Command |
|--------|---------|
| New feature | `/dev-docs [description]` |
| Low on context | `/dev-docs-update` |
| Phase archived | `mv dev/active/[task]/ dev/archive/` |
