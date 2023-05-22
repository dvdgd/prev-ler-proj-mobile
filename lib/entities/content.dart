import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/entities/medic.dart';

class Content {
  int? idContent;
  int idMedic;
  int idInjuryType;
  String title;
  String subtitle;
  String description;
  String observation;
  DateTime? createdAt;
  DateTime? updatedAt;
  Medic? medic;
  InjuryType? injuryType;

  Content({
    this.idContent,
    required this.idMedic,
    required this.idInjuryType,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.observation,
    this.createdAt,
    this.updatedAt,
    this.medic,
    this.injuryType,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      idContent: json['idConteudo'] as int,
      idMedic: json['idMedico'] as int,
      idInjuryType: json['idTipoLesao'] as int,
      title: json['titulo'] as String,
      subtitle: json['subtitulo'] as String,
      description: json['descricao'] as String,
      observation: json['observacao'] as String,
      createdAt: DateTime.parse(json['dataCriacao'] as String),
      updatedAt: DateTime.parse(json['dataAtualizacao'] as String),
      medic: json['medico'] != null ? Medic.fromJson(json['medico']) : null,
      injuryType: json['tipoLesao'] != null
          ? InjuryType.fromJson(json['tipoLesao'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idConteudo': idContent,
      'idMedico': idMedic,
      'idTipoLesao': idInjuryType,
      'titulo': title,
      'subtitulo': subtitle,
      'descricao': description,
      'observacao': observation,
      'dataCriacao': createdAt?.toIso8601String(),
      'dataAtualizacao': updatedAt?.toIso8601String(),
      'medico': medic?.toJson(),
      'tipoLesao': injuryType?.toJson(),
    };
  }
}
