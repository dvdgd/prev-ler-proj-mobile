import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';

abstract class INotificationService {
  Future<List<NotificationData>> getNotifications(int patientId);
  Future<void> updateNotificationAsSended(NotificationData notification);
}

class NotificationServiceImp implements INotificationService {
  final ClientHttp _clientHttp;
  final _patientBaseUrl = '${Environment.apiBaseUrl}/pacientes';
  final _notificationBaseUrl = '${Environment.apiBaseUrl}/notificacoes';

  NotificationServiceImp(this._clientHttp);

  @override
  Future<List<NotificationData>> getNotifications(int patientId) async {
    final respBody = await _clientHttp.fetch<List<dynamic>>(
      uri: Uri.parse('$_patientBaseUrl/$patientId/rotinas/notificacoes'),
      queryParams: {
        'statusRotinas': true,
      },
    );

    final notifications = respBody.map((e) => NotificationData.fromMap(e));
    return notifications.toList();
  }

  @override
  Future<void> updateNotificationAsSended(
    NotificationData notification,
  ) async {
    final id = notification.idNotification;

    await _clientHttp.put(
      uri: Uri.parse('$_notificationBaseUrl/$id'),
      data: notification.toMap(),
    );
  }
}
