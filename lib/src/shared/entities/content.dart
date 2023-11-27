import 'package:prev_ler/src/shared/entities/injury_type.dart';

class Content {
  int idContent;
  int idMedic;
  int idInjuryType;
  String title;
  String subtitle;
  String description;
  String? observation;
  DateTime? createdAt;
  DateTime? updatedAt;
  InjuryType? injuryType;

  Content({
    this.idContent = 0,
    required this.idMedic,
    required this.idInjuryType,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.observation,
    this.createdAt,
    this.updatedAt,
    this.injuryType,
  });
}
