import 'package:prev_ler/src/shared/entities/injury_type.dart';

class Content {
  int contentId;
  String companyId;
  String title;
  String subtitle;
  String description;
  int injuryTypeId;
  String? userId;
  String? observation;
  DateTime? createdAt;
  DateTime? updatedAt;
  InjuryType? injuryType;

  Content({
    this.contentId = 0,
    required this.companyId,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.observation,
    required this.injuryTypeId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.injuryType,
  });
}
