class InjuryType {
  int idInjuryType;
  String userId;
  String companyId;
  String name;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;

  InjuryType({
    this.idInjuryType = 0,
    required this.companyId,
    required this.name,
    required this.description,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });
}
