import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/mappers/notification_mapper.dart';

abstract class INotificationService {
  Future<void> updateNotificationAsSended(NotificationData notification);
  Future<void> deleteNotificationByRoutineId(int routineId);
  Future<List<NotificationData>> bulkCreateNotification(
    List<NotificationData> notifications,
    int routineId,
  );
}

class RoutineNotificationRepository implements INotificationService {
  RoutineNotificationRepository();

  @override
  Future<void> deleteNotificationByRoutineId(int routineId) async {
    try {
      await supabaseClient
          .from('notificacao')
          .delete()
          .eq('id_rotina', routineId);
    } catch (e) {
      throw BaseError(
        message: 'Ocorreu um erro ao cancelar as notificações da rotina.',
      );
    }
  }

  @override
  Future<List<NotificationData>> bulkCreateNotification(
    List<NotificationData> notifications,
    int routineId,
  ) async {
    try {
      final notificationsMap = notifications.map((n) {
        n.routineId = routineId;
        return notificationDataToSupabase(n);
      }).toList();

      final supNotifications = await supabaseClient
          .from('notificacao')
          .insert(notificationsMap)
          .select('*') as List<dynamic>;

      return supNotifications
          .map(
            (notificationMap) => notificationDataFromSupabase(notificationMap),
          )
          .toList();
    } catch (e) {
      throw BaseError(
        message: 'Ocorreu um erro ao criar as notificações da rotina.',
      );
    }
  }

  @override
  Future<void> updateNotificationAsSended(NotificationData notification) async {
    try {
      notification.sent = true;
      final notificationMap = notificationDataToSupabase(notification);
      await supabaseClient
          .from('notificacao')
          .update(notificationMap)
          .eq('id_notificacao', notification.notificationId);
    } catch (e) {
      throw BaseError(
        message: 'Ops... Ocorreu um erro ao enviar a notificação',
      );
    }
  }
}
