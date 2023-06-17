import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';

// TODO: Implement toMap and fromMap methods
class Exercise {
  int idExercise;
  int idMedic;
  int idInjuryType;
  String name;
  String description;
  String instructions;
  String encodedGif;
  String precautions;
  String observations;
  String createdAt;
  String? updatedAt;
  Medic? medic;
  InjuryType? injuryType;

  Exercise({
    required this.idExercise,
    required this.idMedic,
    required this.idInjuryType,
    required this.name,
    required this.description,
    required this.instructions,
    required this.encodedGif,
    required this.precautions,
    required this.observations,
    required this.createdAt,
    this.updatedAt,
    this.medic,
    this.injuryType,
  });
}
