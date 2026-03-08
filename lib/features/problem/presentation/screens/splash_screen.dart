import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/notifications/notification_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), _navigate);
  }

  Future<void> _navigate() async {
    if (!mounted) return;
    final notifications = await ref.read(notificationServiceProvider.future);
    await notifications.initialize();
    await notifications.requestPermissionIfNeeded();

    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: MediaQuery.of(context).disableAnimations
            ? Text('ThinkDaily', style: AppTextStyles.appTitle)
            : Text('ThinkDaily', style: AppTextStyles.appTitle)
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 600))
                .moveY(
                  begin: 12,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                ),
      ),
    );
  }
}
