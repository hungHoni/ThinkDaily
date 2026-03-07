import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'notification_service.g.dart';

@riverpod
Future<NotificationService> notificationService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return NotificationService(prefs);
}

class NotificationService {
  NotificationService(this._prefs);

  final SharedPreferences _prefs;
  final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'think_daily_daily';
  static const _channelName = 'Daily Problem';
  static const _notificationId = 0;
  static const _permissionAskedKey = 'notification_permission_asked';

  bool get hasAskedPermission => _prefs.getBool(_permissionAskedKey) ?? false;

  Future<void> initialize() async {
    if (kIsWeb) return;

    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
    );
  }

  Future<void> requestPermissionIfNeeded() async {
    if (kIsWeb || hasAskedPermission) return;
    await _prefs.setBool(_permissionAskedKey, true);

    if (Platform.isIOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, sound: true);
    } else if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    await scheduleDailyNotification();
  }

  Future<void> scheduleDailyNotification() async {
    if (kIsWeb) return;

    await _plugin.cancel(_notificationId);
    await _plugin.zonedSchedule(
      _notificationId,
      'ThinkDaily',
      "Today's problem is ready.",
      _nextInstanceOf9AM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: 'Daily problem reminder at 9am.',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  tz.TZDateTime _nextInstanceOf9AM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
