import 'package:prev_ler/src/shared/entities/medic.dart';

class InjuryType {
  int idInjuryType;
  int idMedic;
  String name;
  String abbreviation;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Medic? medic;

  InjuryType({
    this.idInjuryType = 0,
    required this.idMedic,
    required this.name,
    required this.abbreviation,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.medic,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTipoLesao': idInjuryType,
      'idMedico': idMedic,
      'nome': name,
      'sigla': abbreviation,
      'descricao': description,
      'dataCriacao': createdAt?.toIso8601String(),
      'dataAtualizacao': updatedAt?.toIso8601String(),
      'medico': medic?.toMap(),
    };
  }

  factory InjuryType.fromMap(Map<String, dynamic> json) {
    return InjuryType(
      idInjuryType: json['idTipoLesao'],
      idMedic: json['idMedico'],
      name: json['nome'],
      abbreviation: json['sigla'],
      description: json['descricao'],
      createdAt: json['dataCriacao'] != null
          ? DateTime.parse(json['dataCriacao'] as String)
          : null,
      updatedAt: json['dataAtualizacao'] != null
          ? DateTime.parse(json['dataAtualizacao'] as String)
          : null,
      medic: json['medico'] != null
          ? Medic.fromMap(json['medico'] as Map<String, dynamic>)
          : null,
    );
  }
}
