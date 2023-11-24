import 'package:prev_ler/src/shared/entities/notification.dart';

abstract class INotificationService {
  Future<List<NotificationData>> getActiveRoutinesNotifications(int patientId);
  Future<void> updateNotificationAsSended(NotificationData notification);
}

class NotificationServiceImp implements INotificationService {
  NotificationServiceImp();

  @override
  Future<List<NotificationData>> getActiveRoutinesNotifications(
      int patientId) async {
    return [
      NotificationData(
        idNotification: 1,
        idRoutine: 1,
        idExercise: 1,
        title: "title",
        message: "teste",
        time: DateTime.now(),
        sent: true,
      ),
    ];
  }

  @override
  Future<void> updateNotificationAsSended(
    NotificationData notification,
  ) async {
    Future.delayed(const Duration(seconds: 1));
  }
}
