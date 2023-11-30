import 'package:prev_ler/src/shared/entities/injury_type.dart';

class Exercise {
  int exerciseId;
  String userId;
  String companyId;
  int injuryTypeId;
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
    this.exerciseId = 0,
    required this.userId,
    required this.injuryTypeId,
    required this.name,
    required this.description,
    required this.instructions,
    required this.image,
    required this.precautions,
    required this.observations,
    required this.companyId,
    this.createdAt,
    this.updatedAt,
    this.injuryType,
  });
}
