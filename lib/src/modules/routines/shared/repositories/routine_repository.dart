import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/modules/notifications/shared/routine_notification_repository.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/mappers/notification_mapper.dart';
import 'package:prev_ler/src/shared/mappers/routine_mapper.dart';

abstract class IRoutineRepository {
  Future<Routine> create(Routine routine);
  Future<void> delete(Routine routine);
  Future<List<Routine>> getAllRoutinesByUserId(String patientId);
  Future<Routine> update(Routine newRoutine);
  Future<void> toggle(Routine routine);
  Future<List<NotificationData>> getActiveRoutinesNotifications(
    String userId,
  );
}

class RoutineRepository implements IRoutineRepository {
  final RoutineNotificationRepository _notificationRepository;

  RoutineRepository(this._notificationRepository);

  @override
  Future<Routine> create(Routine routine) async {
    try {
      final craetedSupRoutine = await supabaseClient
          .from('rotina')
          .insert(routineToSupabase(routine))
          .select(
            '*, notificacao(*), rotina_exercicio(*, exercicio(*, enfermidade(*)))',
          )
          .single();

      final createdRoutine = routineFromSupabase(craetedSupRoutine);
      final exercises = routine.exercises;
      if (exercises != null) {
        await _bulkInsertRoutineExercise(
          createdRoutine.routineId,
          exercises,
        );
      }

      final notifications = routine.notifications;
      if (notifications != null) {
        await _notificationRepository.bulkCreateNotification(
          notifications,
          createdRoutine.routineId,
        );
      }

      final completeInsertedRoutine = getRoutineById(createdRoutine.routineId);
      return completeInsertedRoutine;
    } catch (e) {
      throw BaseError(
        message:
            'Ops... Ocorreu um erro ao criar a rotina, tente novamente mais tarde.',
      );
    }
  }

  @override
  Future<void> delete(Routine routine) async {
    try {
      await supabaseClient
          .from('rotina')
          .delete()
          .eq('id_rotina', routine.routineId);
    } catch (e) {
      throw BaseError(
        message:
            'Ops... Ocorreu um erro ao excluir a rotina, tente novamente mais tarde.',
      );
    }
  }

  @override
  Future<Routine> update(Routine newRoutine) async {
    try {
      await _notificationRepository.deleteNotificationByRoutineId(
        newRoutine.routineId,
      );
      await _deleteRoutineExercisesByRoutineId(newRoutine.routineId);
      final newRoutineMap = routineToSupabase(newRoutine);
      await supabaseClient
          .from('rotina')
          .update(newRoutineMap)
          .eq('id_rotina', newRoutine.routineId);

      final exercises = newRoutine.exercises;
      if (exercises != null) {
        await _bulkInsertRoutineExercise(
          newRoutine.routineId,
          exercises,
        );
      }

      final updatedRoutine = await getRoutineById(newRoutine.routineId);
      return updatedRoutine;
    } catch (e) {
      throw BaseError(
        message:
            'Ops... Ocorreu um erro ao atualizar a rotina, tente novamente mais tarde.',
      );
    }
  }

  @override
  Future<void> toggle(Routine newRoutine) async {
    try {
      final newRoutineMap = routineToSupabase(newRoutine);
      await supabaseClient
          .from('rotina')
          .update(newRoutineMap)
          .eq('id_rotina', newRoutine.routineId);
    } catch (e) {
      throw BaseError(
        message:
            'Ops... Ocorreu um erro ao atualizar a rotina, tente novamente mais tarde.',
      );
    }
  }

  Future<Routine> getRoutineById(int routineId) async {
    try {
      final routine = await supabaseClient
          .from('rotina')
          .select('*, rotina_exercicio(exercicio(*)), notificacao(*)')
          .eq('id_rotina', routineId)
          .single() as dynamic;

      return routineFromSupabase(routine);
    } catch (e) {
      throw BaseError(
        message:
            'Ops... Ocorreu um erro ao buscar as rotinas, tente novamente mais tarde.',
      );
    }
  }

  @override
  Future<List<Routine>> getAllRoutinesByUserId(String userId) async {
    try {
      final supRoutines = await supabaseClient
          .from('rotina')
          .select(
              '*, notificacao(*), rotina_exercicio(exercicio(*, enfermidade(*)))')
          .eq('id_usuario', userId) as List<dynamic>;

      final routines = supRoutines.map((r) => routineFromSupabase(r));
      return routines.toList();
    } catch (e) {
      throw BaseError(
        message:
            'Ops... Ocorreu um erro ao buscar as rotinas, tente novamente mais tarde.',
      );
    }
  }

  @override
  Future<List<NotificationData>> getActiveRoutinesNotifications(
    String userId,
  ) async {
    try {
      final notificationsMap = await supabaseClient
          .from('notificacoes_ativas')
          .select('*') as List<dynamic>;

      final notifications = notificationsMap.map(
        (n) => notificationDataFromSupabase(n),
      );

      return notifications.toList();
    } catch (e) {
      throw BaseError(message: 'Erro ao recuperar as notificações.');
    }
  }

  Future<void> _deleteRoutineExercisesByRoutineId(int routineId) async {
    try {
      await supabaseClient
          .from('rotina_exercicio')
          .delete()
          .eq('id_rotina', routineId);
    } catch (e) {
      throw BaseError(
        message: 'Ops... ocorreu um erro ao atualizar os exercícios da rotina.',
      );
    }
  }

  Future<void> _bulkInsertRoutineExercise(
    int routineId,
    List<Exercise> exercises,
  ) async {
    final routineExercisesMaps = exercises
        .map(
          (e) => {
            'id_rotina': routineId,
            'id_exercicio': e.exerciseId,
          },
        )
        .toList();

    await supabaseClient.from('rotina_exercicio').insert(routineExercisesMaps);
  }
}
