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

## Continuing Tasks (ALWAYS DO THIS FIRST)
At the start of every session:
1. Check `dev/active/` for any in-progress tasks
2. If a task folder exists, read files in this order:
   - [task]-context.md first (current state)
   - [task]-tasks.md (what's done, what's next)
   - [task]-plan.md only if you need full strategy
3. Resume from where context.md says to resume
4. If dev/active/ is empty — ask the user what to work on

When the user says "continue" → always check dev/active/ first.

## During Tasks
- Implement ONE PHASE AT A TIME — do not jump ahead
- Check off tasks.md immediately after completing each task
- Update context.md SESSION PROGRESS after each major milestone
- When context is running low → run /dev-docs-update before compacting

## Skills Available
- Flutter/Dart code → flutter-dev-guidelines skill
Hooks auto-suggest these. Load the skill before writing Flutter code.

## Agents Available
For complex or risky tasks:
- code-architecture-reviewer — before calling a feature done
- plan-reviewer — after /dev-docs generates a plan, before implementing
- web-research-specialist — debugging unknown errors, researching Flutter packages

## Task Management
New feature → /dev-docs [description]
Running low on context → /dev-docs-update
Done → mv dev/active/[task]/ dev/archive/
