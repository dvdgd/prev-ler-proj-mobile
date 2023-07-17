class RoutineModel {
  final String id;
  final dynamic routine;

  RoutineModel({required this.id, required this.routine});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routine': routine,
    };
  }
}
