import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/mappers/exercise_mapper.dart';

Map<String, dynamic> notificationDataToSupabase(
  NotificationData notification,
) {
  final notificationMap = {
    'id_rotina': notification.routineId,
    'id_exercicio': notification.exerciseId,
    'titulo': notification.title,
    'mensagem': notification.message,
    'horario': notification.time.toIso8601String(),
    'enviado': notification.sent,
  };

  if (notification.notificationId != 0) {
    notificationMap['id_notificacao'] = notification.notificationId;
  }

  return notificationMap;
}

NotificationData notificationDataFromSupabase(
  Map<String, dynamic> notification,
) {
  return NotificationData(
    notificationId: notification['id_notificacao'],
    routineId: notification['id_rotina'],
    exerciseId: notification['id_exercicio'],
    title: notification['titulo'],
    message: notification['mensagem'],
    time: DateTime.parse(notification['horario']),
    sent: notification['enviado'],
    exercise: notification['exercicio'] != null
        ? exerciseFromSupabase(notification['exercicio'])
        : null,
  );
}
