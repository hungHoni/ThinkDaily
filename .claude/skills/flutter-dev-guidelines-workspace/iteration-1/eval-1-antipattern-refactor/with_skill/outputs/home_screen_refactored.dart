import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loading_widget.dart';
import '../providers/user_provider.dart';

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

/// Entry screen that shows the current user's name.
///
/// Uses [ConsumerWidget] — no local state, no business logic in build().
/// Data is owned by [UserNotifier]; this widget only observes and reacts.
///
/// Anti-patterns fixed vs. the original:
///   ❌ StatefulWidget + setState        → ✅ ConsumerWidget + Riverpod AsyncValue
///   ❌ Dio().get() directly in widget   → ✅ UserRepository via userNotifierProvider
///   ❌ No error handling                → ✅ .when() handles data / loading / error
///   ❌ Navigator.push + MaterialPageRoute → ✅ context.go() via GoRouter
///   ❌ Color(0xFF111111) hardcoded      → ✅ Theme.of(context).colorScheme
///   ❌ TextStyle(fontSize:20) hardcoded → ✅ Theme.of(context).textTheme
///   ❌ No const constructor             → ✅ const HomeScreen()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);

    return Scaffold(
      // Use theme background; avoid hardcoding colors at the Scaffold level.
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: userAsync.when(
        data: (user) => _UserContent(name: user.name),
        loading: () => const AppLoadingWidget(),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.read(userNotifierProvider.notifier).refresh(),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private sub-widget — keeps HomeScreen.build() under ~100 lines and
// gives Flutter a stable subtree to diff against on rebuilds.
// ---------------------------------------------------------------------------

class _UserContent extends StatelessWidget {
  const _UserContent({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: GestureDetector(
        // GoRouter — no Navigator.push scattered in widgets.
        onTap: () => context.go('/profile'),
        child: Text(
          name.isEmpty ? 'Guest' : name,
          // Theme text style — no hardcoded fontSize or Color values.
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
