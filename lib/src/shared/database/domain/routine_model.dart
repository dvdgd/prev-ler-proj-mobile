import 'package:prev_ler/src/shared/entities/routine.dart';

class RoutineModel {
  final String id;
  final Routine routine;

  RoutineModel({required this.id, required this.routine});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routine': routine.toMap(),
    };
  }
}
