
class Injury {
  final int medicId;
  final String name;
  final String abbreviation;
  final String description;

  Injury({
    required this.medicId,
    required this.name,
    required this.abbreviation,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'idMedico': medicId,
      'nome': name,
      'sigla': abbreviation,
      'descricao': description,
    };
  }

  factory Injury.fromJson(Map<String, dynamic> json) {
    return Injury(
      medicId: json['idMedico'],
      name: json['nome'],
      abbreviation: json['sigla'],
      description: json['descricao'],
    );
  }
}
