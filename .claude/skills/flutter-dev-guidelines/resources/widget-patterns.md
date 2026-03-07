# Widget Patterns

## Widget Type Selection

| Situation | Use |
|-----------|-----|
| Pure display, no state | `StatelessWidget` |
| Reads/watches providers | `ConsumerWidget` |
| Needs local state + providers | `ConsumerStatefulWidget` |
| Needs local lifecycle only (animations, focus) | `StatefulWidget` |
| Fine-grained rebuild inside larger widget | `Consumer` inline |

**Default choice: `ConsumerWidget`.** Only reach for `StatefulWidget` when you need `TickerProvider`, `FocusNode`, `PageController`, or similar lifecycle objects.

---

## Standard Widget Structure

```dart
// feature_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureCard extends ConsumerWidget {
  const FeatureCard({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title, style: theme.textTheme.titleMedium),
        ),
      ),
    );
  }
}
```

Rules applied:
- `const` constructor
- Named params with `required` for mandatory ones
- `Theme.of(context)` not hardcoded styles
- `super.key`

---

## ConsumerStatefulWidget Template

```dart
class AnimatedCounter extends ConsumerStatefulWidget {
  const AnimatedCounter({super.key, required this.providerId});
  final String providerId;

  @override
  ConsumerState<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends ConsumerState<AnimatedCounter>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 200.ms);
    _scaleAnim = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();  // always dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider(widget.providerId));

    ref.listen(counterProvider(widget.providerId), (_, __) {
      _controller.forward(from: 0);
    });

    return ScaleTransition(
      scale: _scaleAnim,
      child: Text('$count'),
    );
  }
}
```

---

## Extracting Widgets — When and How

**Extract when:**
- `build()` exceeds ~80 lines
- A subtree is reused in 2+ places
- A subtree has independent rebuild conditions
- A conceptually distinct UI section

**How to extract:**

```dart
// Before — monolithic build()
@override
Widget build(BuildContext context, WidgetRef ref) {
  return Scaffold(
    body: Column(
      children: [
        // 30 lines of header
        // 40 lines of content
        // 20 lines of footer
      ],
    ),
  );
}

// After — clean, readable
@override
Widget build(BuildContext context, WidgetRef ref) {
  return Scaffold(
    body: Column(
      children: [
        const _ProfileHeader(),
        const _ProfileContent(),
        const _ProfileFooter(),
      ],
    ),
  );
}

// Private sub-widgets in same file (if feature-specific, not reused)
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) { ... }
}
```

---

## Lists

Always use builder variants for lists of unknown length:

```dart
// ListView
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemCard(item: items[index]),
)

// ListView with separator
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (_, __) => const Divider(height: 1),
  itemBuilder: (context, index) => ItemCard(item: items[index]),
)

// GridView
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.8,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => ItemCard(item: items[index]),
)

// Sliver list inside CustomScrollView (preferred for complex scroll)
CustomScrollView(
  slivers: [
    SliverAppBar.large(title: const Text('Orders')),
    SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList.builder(
        itemCount: orders.length,
        itemBuilder: (context, i) => OrderCard(order: orders[i]),
      ),
    ),
  ],
)
```

Never use `Column` with `.map().toList()` for lists that can grow:
```dart
// WRONG — no virtualization, all items rendered
Column(
  children: items.map((item) => ItemCard(item: item)).toList(), // ❌
)
```

---

## Loading & Empty States

```dart
// Shared loading widget
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}

// Shimmer loading (add shimmer package)
class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// Empty state
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(message, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## Forms with reactive_forms

```dart
class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(loginFormProvider);

    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          ReactiveTextField<String>(
            formControlName: 'email',
            decoration: const InputDecoration(labelText: 'Email'),
            validationMessages: {
              ValidationMessage.required: (_) => 'Email is required',
              ValidationMessage.email: (_) => 'Enter a valid email',
            },
          ),
          const SizedBox(height: 16),
          ReactiveTextField<String>(
            formControlName: 'password',
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password'),
            validationMessages: {
              ValidationMessage.required: (_) => 'Password is required',
              ValidationMessage.minLength: (_) => 'At least 8 characters',
            },
          ),
          const SizedBox(height: 24),
          ReactiveFormConsumer(
            builder: (context, form, _) => FilledButton(
              onPressed: form.valid
                  ? () => ref.read(authNotifierProvider.notifier).login(
                        form.value['email'] as String,
                        form.value['password'] as String,
                      )
                  : null,
              child: const Text('Sign In'),
            ),
          ),
        ],
      ),
    );
  }
}

// Provider for form
@riverpod
FormGroup loginForm(LoginFormRef ref) => FormGroup({
  'email': FormControl<String>(
    validators: [Validators.required, Validators.email],
  ),
  'password': FormControl<String>(
    validators: [Validators.required, Validators.minLength(8)],
  ),
});
```

---

## Images

Always use `CachedNetworkImage` — never `Image.network` directly:

```dart
CachedNetworkImage(
  imageUrl: user.avatarUrl,
  width: 48,
  height: 48,
  fit: BoxFit.cover,
  placeholder: (context, url) => const CircleAvatar(
    child: Icon(Icons.person),
  ),
  errorWidget: (context, url, error) => const CircleAvatar(
    child: Icon(Icons.broken_image),
  ),
  imageBuilder: (context, imageProvider) => CircleAvatar(
    backgroundImage: imageProvider,
  ),
)
```

---

## Responsive Layout with flutter_screenutil

```dart
// Initialize in app.dart
ScreenUtilInit(
  designSize: const Size(390, 844), // iPhone 14 design size
  minTextAdapt: true,
  splitScreenMode: true,
  builder: (context, child) => MaterialApp.router(...),
)

// Usage
Container(
  width: 200.w,    // scales with screen width
  height: 120.h,   // scales with screen height
  padding: EdgeInsets.all(16.r),   // radius-like adaptive
  child: Text('Hello', style: TextStyle(fontSize: 14.sp)),
)
```

---

## Animations with flutter_animate

```dart
// Entrance animation
Card(...)
  .animate()
  .fadeIn(duration: 300.ms)
  .slideY(begin: 0.1, end: 0)

// Staggered list items
ListView.builder(
  itemBuilder: (context, i) => ItemCard(item: items[i])
    .animate(delay: (50 * i).ms)
    .fadeIn()
    .slideX(begin: -0.1),
)

// On event
AnimatedWidget(...)
  .animate(target: isSelected ? 1 : 0)
  .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05))
```

---

## Dialogs & Bottom Sheets

```dart
// Bottom sheet
void showOrderDetails(BuildContext context, String orderId) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      expand: false,
      builder: (_, controller) => OrderDetailsSheet(
        orderId: orderId,
        scrollController: controller,
      ),
    ),
  );
}

// Confirmation dialog
Future<bool> showConfirmDialog(BuildContext context, String message) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirm'),
        ),
      ],
    ),
  ) ?? false;
}
```
