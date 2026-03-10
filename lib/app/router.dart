import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/features/history/presentation/screens/history_screen.dart';
import 'package:think_daily/features/history/presentation/screens/review_screen.dart';
import 'package:think_daily/features/history/presentation/screens/stats_screen.dart';
import 'package:think_daily/features/home/presentation/screens/home_screen.dart';
import 'package:think_daily/features/home/presentation/screens/track_detail_screen.dart';
import 'package:think_daily/features/problem/data/models/problem.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';
import 'package:think_daily/features/problem/presentation/screens/done_screen.dart';
import 'package:think_daily/features/problem/presentation/screens/feedback_screen.dart';
import 'package:think_daily/features/problem/presentation/screens/problem_screen.dart';
import 'package:think_daily/features/problem/presentation/screens/splash_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const track = '/track';
  static const problem = '/problem';
  static const feedback = '/feedback';
  static const done = '/done';
  static const stats = '/stats';
  static const history = '/history';
  static const review = '/review';
}

class FeedbackArgs {
  const FeedbackArgs({required this.problem, required this.answerState});
  final Problem problem;
  final AnswerState answerState;
}

@immutable
class ReviewArgs {
  const ReviewArgs({required this.entry, required this.problem});
  final Map<String, dynamic> entry;
  final Problem problem;
}

final router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (_, state) => _fadePage(state, const SplashScreen()),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (_, state) => _fadePage(state, const HomeScreen()),
    ),
    GoRoute(
      path: '${AppRoutes.track}/:trackId',
      pageBuilder: (_, state) {
        final trackId = state.pathParameters['trackId']!;
        return _fadePage(state, TrackDetailScreen(trackId: trackId));
      },
    ),
    GoRoute(
      path: AppRoutes.problem,
      pageBuilder: (_, state) => _fadePage(state, const ProblemScreen()),
    ),
    GoRoute(
      path: AppRoutes.feedback,
      redirect: (_, state) =>
          state.extra is FeedbackArgs ? null : AppRoutes.home,
      pageBuilder: (_, state) =>
          _fadePage(state, FeedbackScreen(args: state.extra! as FeedbackArgs)),
    ),
    GoRoute(
      path: AppRoutes.done,
      pageBuilder: (_, state) => _fadePage(state, const DoneScreen()),
    ),
    GoRoute(
      path: AppRoutes.stats,
      pageBuilder: (_, state) => _fadePage(state, const StatsScreen()),
    ),
    GoRoute(
      path: AppRoutes.history,
      pageBuilder: (_, state) => _fadePage(state, const HistoryScreen()),
    ),
    GoRoute(
      path: AppRoutes.review,
      redirect: (_, state) =>
          state.extra is ReviewArgs ? null : AppRoutes.history,
      pageBuilder: (_, state) =>
          _fadePage(state, ReviewScreen(args: state.extra! as ReviewArgs)),
    ),
  ],
);

CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );
