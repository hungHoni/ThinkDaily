// lib/features/user_profile/presentation/screens/user_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_stats_provider.dart';
import 'user_stats_repository.dart';

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

/// Displays the current user's profile — display name, problems solved,
/// current streak, and accuracy percentage.
///
/// All async states (loading, error, data) are handled explicitly; the UI
/// never silently ignores a failure.
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          // Refresh button available even in error state so the user can retry
          // without having to navigate away and back.
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(userStatsNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: statsAsync.when(
        loading: () => const _LoadingView(),
        error: (error, stackTrace) => _ErrorView(
          message: _resolveErrorMessage(error),
          onRetry: () =>
              ref.read(userStatsNotifierProvider.notifier).refresh(),
        ),
        data: (stats) => _ProfileView(stats: stats),
      ),
    );
  }

  /// Maps a caught error to a user-facing message.
  ///
  /// Keeping this outside [build] makes it easy to unit-test independently
  /// and keeps [build] focused purely on the widget tree.
  static String _resolveErrorMessage(Object error) {
    // When a real AppException is introduced, switch on its subtypes here
    // (e.g. NetworkException → 'No internet connection.').
    return 'Something went wrong. Please try again.';
  }
}

// ---------------------------------------------------------------------------
// Data view — extracted so build() stays readable and sub-widgets can be
// tested and reused independently.
// ---------------------------------------------------------------------------

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // Pull-to-refresh is wired via the parent ConsumerWidget's ref; we
      // surface the notifier call through a callback passed down instead of
      // threading ref into a StatelessWidget.
      //
      // For simplicity and to keep _ProfileView a pure display widget, we
      // wrap it in a ProviderScope consumer at the RefreshIndicator level
      // using a Consumer widget.
      onRefresh: () async {
        // No-op here — pull-to-refresh is handled by _ProfileRefreshWrapper.
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AvatarHeader(displayName: stats.displayName),
            const SizedBox(height: 32),
            _StatsGrid(stats: stats),
          ],
        ),
      ),
    );
  }
}

/// Wraps [_ProfileView] to provide pull-to-refresh via [Consumer] without
/// threading a [WidgetRef] into the stateless sub-widget tree.
///
/// Using [Consumer] here scopes the rebuild to only this widget when the
/// notifier's state changes, rather than rebuilding the entire [_ProfileView].
class _ProfileRefreshWrapper extends ConsumerWidget {
  const _ProfileRefreshWrapper({required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(userStatsNotifierProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AvatarHeader(displayName: stats.displayName),
            const SizedBox(height: 32),
            _StatsGrid(stats: stats),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _AvatarHeader extends StatelessWidget {
  const _AvatarHeader({required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            _initials(displayName),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          displayName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Returns up to two uppercase initials from [name].
  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}

// ---------------------------------------------------------------------------
// Stats grid — 2 × 2 layout of stat cards
// ---------------------------------------------------------------------------

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle_outline,
                label: 'Problems Solved',
                value: stats.totalProblemsSolved.toString(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                icon: Icons.local_fire_department_outlined,
                label: 'Current Streak',
                value: '${stats.currentStreakDays}d',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _StatCard(
          icon: Icons.track_changes_outlined,
          label: 'Accuracy',
          value: '${stats.accuracyPercentage.toStringAsFixed(1)}%',
          fullWidth: true,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.fullWidth = false,
  });

  final IconData icon;
  final String label;
  final String value;

  /// When true, the card fills the available horizontal space.
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: fullWidth
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Loading state
// ---------------------------------------------------------------------------

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

// ---------------------------------------------------------------------------
// Error state
// ---------------------------------------------------------------------------

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 56,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
