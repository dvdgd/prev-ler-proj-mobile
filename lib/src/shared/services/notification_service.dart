import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/notification_config.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:timezone/timezone.dart' as tz;

class FlutterNotificationService {
  final NotificationConfig _notificationConfig;

  FlutterNotificationService(this._notificationConfig);

  tz.TZDateTime _nextInstanceOfHour(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime nextInstanceOfWeekdayHour(int weekday, int hour, int minute) {
    tz.TZDateTime scheduledDate = _nextInstanceOfHour(hour, minute);
    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleNextWeekDayNotification(
    NotificationData myNotification,
  ) async {
    debugPrint('Scheduling notification ${myNotification.idNotification}');

    final notification = CustomNotification(
      id: myNotification.idNotification,
      title: myNotification.title,
      body: myNotification.message,
      payload: '/notifications',
      scheduleDate: tz.TZDateTime.from(myNotification.time, tz.local),
    );
    debugPrint('Notification scheduled: ${notification.toMap()}');

    _notificationConfig.scheduleNotification(notification);
  }

  Future<void> cancelNotification(NotificationData notificationData) async {
    debugPrint(
        'Cancelling notification, notificationId: ${notificationData.idNotification}');
    await _notificationConfig
        .cancelNotification(notificationData.idNotification);
    debugPrint(
        'Cancel notification sucess, notificationId: ${notificationData.idNotification}');
  }
}
