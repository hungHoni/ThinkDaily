import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/features/problem/data/models/problem.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';
import 'package:think_daily/features/problem/presentation/screens/done_screen.dart';
import 'package:think_daily/features/problem/presentation/screens/feedback_screen.dart';
import 'package:think_daily/features/problem/presentation/screens/problem_screen.dart';
import 'package:think_daily/features/problem/presentation/screens/splash_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const problem = '/problem';
  static const feedback = '/feedback';
  static const done = '/done';
}

class FeedbackArgs {
  const FeedbackArgs({required this.problem, required this.answerState});
  final Problem problem;
  final AnswerState answerState;
}

final router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (_, state) => _fadePage(state, const SplashScreen()),
    ),
    GoRoute(
      path: AppRoutes.problem,
      pageBuilder: (_, state) => _fadePage(state, const ProblemScreen()),
    ),
    GoRoute(
      path: AppRoutes.feedback,
      pageBuilder: (_, state) {
        final args = state.extra as FeedbackArgs?;
        if (args == null) return _fadePage(state, const ProblemScreen());
        return _fadePage(state, FeedbackScreen(args: args));
      },
    ),
    GoRoute(
      path: AppRoutes.done,
      pageBuilder: (_, state) => _fadePage(state, const DoneScreen()),
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
