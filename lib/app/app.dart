import 'package:flutter/material.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_theme.dart';

class ThinkDailyApp extends StatelessWidget {
  const ThinkDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ThinkDaily',
      theme: AppTheme.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
