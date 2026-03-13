import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_stats_provider.dart';
import 'user_stats_repository.dart';

// ---------------------------------------------------------------------------
// Inline design tokens (mirrors the project's AppColors / AppTextStyles /
// AppSpacing conventions so this file compiles standalone).
// ---------------------------------------------------------------------------

abstract class _Colors {
  static const background = Color(0xFFFFFFFF);
  static const text = Color(0xFF111111);
  static const textSecondary = Color(0xFF555555);
  static const border = Color(0xFFE0E0E0);
  static const surface = Color(0xFFF8F8F8);
  static const invertedBackground = Color(0xFF111111);
  static const invertedText = Color(0xFFFFFFFF);
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

/// Full-page profile screen that displays the user's display name, total
/// problems solved, current streak, and accuracy percentage.
///
/// Delegates data fetching to [userStatsProvider] and handles all three
/// [AsyncValue] states: loading, error, and data.
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsProvider);

    return Scaffold(
      backgroundColor: _Colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(onClose: () => Navigator.of(context).maybePop()),
            const Divider(height: 1, color: _Colors.border),
            Expanded(
              child: statsAsync.when(
                loading: () => const _LoadingState(),
                error: (error, stackTrace) => _ErrorState(
                  message: error.toString(),
                  onRetry: () => ref.invalidate(userStatsProvider),
                ),
                data: (stats) => _ProfileBody(stats: stats),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Georgia', // Lora fallback for standalone use
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: _Colors.text,
                letterSpacing: 1.5,
              ),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, color: _Colors.text),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Loading state
// ---------------------------------------------------------------------------

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: _Colors.text,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Error state
// ---------------------------------------------------------------------------

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 32,
              color: _Colors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Could not load profile.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: _Colors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 11,
                color: _Colors.textSecondary,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 24),
            _RetryButton(onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: _Colors.invertedBackground,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          'RETRY',
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _Colors.invertedText,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Profile body (data state)
// ---------------------------------------------------------------------------

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Avatar + Display Name ──────────────────────────────────
          const SizedBox(height: 8),
          _Avatar(displayName: stats.displayName),
          const SizedBox(height: 20),
          Text(
            stats.displayName,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: _Colors.text,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 40),
          const Divider(height: 1, color: _Colors.border),
          const SizedBox(height: 40),

          // ── Stat row ──────────────────────────────────────────────
          _StatRow(
            children: [
              _StatCell(
                value: '${stats.totalProblemsSolved}',
                label: 'SOLVED',
              ),
              _StatCell(
                value: '${stats.currentStreak}',
                label: 'STREAK',
                suffix: ' days',
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(height: 1, color: _Colors.border),
          const SizedBox(height: 40),

          // ── Accuracy ──────────────────────────────────────────────
          _AccuracySection(accuracyPercentage: stats.accuracyPercentage),

          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Avatar widget
// ---------------------------------------------------------------------------

class _Avatar extends StatelessWidget {
  const _Avatar({required this.displayName});

  final String displayName;

  String get _initials {
    final parts = displayName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: _Colors.invertedBackground,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Center(
        child: Text(
          _initials,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: _Colors.invertedText,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat row / cell helpers
// ---------------------------------------------------------------------------

class _StatRow extends StatelessWidget {
  const _StatRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      items.add(Expanded(child: children[i]));
      if (i < children.length - 1) {
        items.add(const SizedBox(width: 32));
      }
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.value,
    required this.label,
    this.suffix,
  });

  final String value;
  final String label;

  /// Optional suffix appended to [value] in smaller text, e.g. " days".
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Georgia',
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: _Colors.text,
                height: 1,
              ),
            ),
            if (suffix != null)
              Text(
                suffix!,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: _Colors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: _Colors.textSecondary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Accuracy section
// ---------------------------------------------------------------------------

class _AccuracySection extends StatelessWidget {
  const _AccuracySection({required this.accuracyPercentage});

  final double accuracyPercentage;

  @override
  Widget build(BuildContext context) {
    final fraction = (accuracyPercentage / 100).clamp(0.0, 1.0);
    final displayPct = accuracyPercentage.toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ACCURACY',
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: _Colors.textSecondary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              displayPct,
              style: const TextStyle(
                fontFamily: 'Georgia',
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: _Colors.text,
                height: 1,
              ),
            ),
            const Text(
              '%',
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _Colors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Progress bar
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 2,
                  width: constraints.maxWidth,
                  color: _Colors.border,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  height: 2,
                  width: constraints.maxWidth * fraction,
                  color: _Colors.text,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Text(
          _accuracyLabel(accuracyPercentage),
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 11,
            color: _Colors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  /// Returns a qualitative label based on the numeric accuracy.
  String _accuracyLabel(double pct) {
    if (pct >= 90) return 'Excellent';
    if (pct >= 75) return 'Good';
    if (pct >= 50) return 'Improving';
    return 'Keep practising';
  }
}
