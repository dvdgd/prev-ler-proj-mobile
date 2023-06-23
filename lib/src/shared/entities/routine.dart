import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';

class Routine {
  int idRoutine;
  int idPatient;
  String title;
  String description;
  String startTime;
  String endTime;
  Duration duration;
  bool active;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Exercise>? exercises;
  List<DayOfWeek>? weekdays;
  List<NotificationData>? notifications;

  Routine({
    required this.idRoutine,
    required this.idPatient,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.active,
    required this.duration,
    this.createdAt,
    this.weekdays,
    this.updatedAt,
    this.exercises,
    this.notifications,
  });

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      idRoutine: map['idRotina'],
      idPatient: map['idPaciente'],
      title: map['titulo'],
      description: map['descricao'],
      startTime: map['horarioInicio'],
      endTime: map['horarioFim'],
      active: map['ativa'],
      duration: Duration(milliseconds: int.parse(map['duration'])),
      exercises: map['exercicios']?.map((e) => Exercise.fromMap(e)),
      weekdays: map['diasSemana']?.map((e) => DayOfWeek.fromMap(e)),
      notifications:
          map['notificacoes']?.map((e) => NotificationData.fromMap(e)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idRotina': idRoutine,
      'idPaciente': idPatient,
      'titulo': title,
      'descricao': description,
      'horarioInicio': startTime.toString(),
      'horarioFim': endTime.toString(),
      'intervalo': duration.toString(),
      'ativa': active,
      'exercicios': exercises?.map((e) => e.toMap()),
      'diasSemana': weekdays?.map((e) => e.toMap()),
      'notificacoes': notifications?.map((e) => e.toMap()),
    };
  }
}
