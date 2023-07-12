import 'package:hive_flutter/hive_flutter.dart';
import 'package:prev_ler/src/shared/database/domain/routine_model.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';

part 'routine_model_database.g.dart';

@HiveType(typeId: 2)
class RoutineModelDatabase extends HiveObject implements RoutineModel {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final Routine routine;

  RoutineModelDatabase(this.id, this.routine);

  factory RoutineModelDatabase.fromDomain(RoutineModel routine) {
    return RoutineModelDatabase(routine.id, routine.routine);
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'routine': routine,
    };
  }
}
