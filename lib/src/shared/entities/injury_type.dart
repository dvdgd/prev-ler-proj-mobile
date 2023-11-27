class InjuryType {
  int idInjuryType;
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
    this.createdAt,
    this.updatedAt,
  });
}
