import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user_stats_repository.dart';

part 'user_stats_provider.g.dart';

/// Async provider that fetches [UserStats] from [UserStatsRepository].
///
/// Uses `@riverpod` code generation so the provider is strongly-typed and
/// automatically invalidated when its dependencies change.  The caller
/// receives an [AsyncValue] that represents loading, data, and error states.
///
/// Usage:
/// ```dart
/// final statsAsync = ref.watch(userStatsProvider);
/// statsAsync.when(
///   loading: () => const CircularProgressIndicator(),
///   error: (e, _) => Text('Error: $e'),
///   data: (stats) => Text(stats.displayName),
/// );
/// ```
@riverpod
Future<UserStats> userStats(Ref ref) async {
  final repository = ref.watch(userStatsRepositoryProvider);
  return repository.fetchUserStats();
}
