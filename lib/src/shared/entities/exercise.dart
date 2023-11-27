import 'package:prev_ler/src/shared/entities/injury_type.dart';

class Exercise {
  int idExercise;
  int idMedic;
  int idInjuryType;
  String name;
  String description;
  String instructions;
  String image;
  String? precautions;
  String? observations;
  DateTime? createdAt;
  DateTime? updatedAt;
  InjuryType? injuryType;

  Exercise({
    this.idExercise = 0,
    required this.idMedic,
    required this.idInjuryType,
    required this.name,
    required this.description,
    required this.instructions,
    required this.image,
    required this.precautions,
    required this.observations,
    this.createdAt,
    this.updatedAt,
    this.injuryType,
  });
}
