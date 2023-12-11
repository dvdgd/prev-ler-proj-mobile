import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/notifications/shared/routine_notification_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/services/auth_service.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class NotificationController extends ChangeNotifier {
  final INotificationService _notificationService;
  final IRoutineRepository _routineRepository;
  final AuthService _userService;

  StateEnum state = StateEnum.idle;
  String errorMessage = '';
  List<NotificationData> notifications = [];

  NotificationController(
    this._notificationService,
    this._userService,
    this._routineRepository,
  );

  User _getPatientUser() {
    final user = _userService.currentUser;
    if (user == null || user.type == UserType.employee) {
      throw BaseError(
        message: 'Você precisa ser um paciente para criar rotinas.',
      );
    }

    return user;
  }

  Future<void> getNotifications() async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      final patientId = _getPatientUser().userId;

      notifications =
          await _routineRepository.getActiveRoutinesNotifications(patientId);
      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e) {
      state = StateEnum.error;
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> markAsRead(NotificationData notification) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      notification.sent = true;
      await _notificationService.updateNotificationAsSended(notification);

      final notificationIndex = notifications.indexWhere(
        (e) => e.routineId == notification.notificationId,
      );
      if (notificationIndex != -1) {
        notifications[notificationIndex] = notification;
      }

      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e) {
      state = StateEnum.error;
      errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
