import 'package:prev_ler/entities/medic.dart';

class Injury {
  int? idInjuryType;
  int idMedic;
  String name;
  String abbreviation;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Medic? medic;

  Injury(
      {this.idInjuryType,
      required this.idMedic,
      required this.name,
      required this.abbreviation,
      required this.description,
      this.createdAt,
      this.updatedAt,
      this.medic});

  Map<String, dynamic> toJson() {
    return {
      'idTipoLesao': idInjuryType,
      'idMedico': idMedic,
      'nome': name,
      'sigla': abbreviation,
      'descricao': description,
      'dataCriacao': createdAt?.toIso8601String(),
      'dataAtualizacao': updatedAt?.toIso8601String(),
      'medico': medic?.toJson(),
    };
  }

  factory Injury.fromJson(Map<String, dynamic> json) {
    return Injury(
      idInjuryType: json['idTipoLesao'],
      idMedic: json['idMedico'],
      name: json['nome'],
      abbreviation: json['sigla'],
      description: json['descricao'],
      createdAt: DateTime.parse(json['dataCriacao'] as String),
      updatedAt: DateTime.parse(json['dataAtualizacao'] as String),
      medic: json['medico'] != null ? Medic.fromJson(json['medico']) : null,
    );
  }
}
