import 'package:prev_ler/src/shared/entities/exercise.dart';

class NotificationData {
  int idNotification;
  int idRoutine;
  int idExercise;
  String title;
  String message;
  DateTime time;
  bool sent;
  Exercise? exercise;

  NotificationData({
    required this.idNotification,
    required this.idRoutine,
    required this.idExercise,
    required this.title,
    required this.message,
    required this.time,
    required this.sent,
    this.exercise,
  });

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      idNotification: map['idNotificacao'],
      idRoutine: map['idRotina'],
      idExercise: map['idExercicio'],
      title: map['titulo'],
      message: map['mensagem'],
      time: DateTime.parse(map['hora']),
      sent: map['enviado'],
      exercise:
          map['exercicio'] != null ? Exercise.fromMap(map['exercicio']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idNotificacao': idNotification,
      'idRotina': idRoutine,
      'idExercicio': idExercise,
      'titulo': title,
      'mensagem': message,
      'hora': time.toIso8601String(),
      'enviado': sent,
      'exercicio': exercise?.toMap(),
    };
  }
}
