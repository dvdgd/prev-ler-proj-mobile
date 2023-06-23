import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';

class Exercise {
  int idExercise;
  int idMedic;
  int idInjuryType;
  String name;
  String description;
  String instructions;
  String image;
  String precautions;
  String observations;
  DateTime? createdAt;
  DateTime? updatedAt;
  Medic? medic;
  InjuryType? injuryType;

  Exercise({
    this.idExercise = 0,
    required this.idMedic,
    required this.idInjuryType,
    required this.name,
    required this.description,
    required this.instructions,
    required this.image,
    required this.precautions,
    required this.observations,
    this.createdAt,
    this.updatedAt,
    this.medic,
    this.injuryType,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      idExercise: map['idExercicio'],
      idMedic: map['idMedico'],
      idInjuryType: map['idTipoLesao'],
      name: map['nome'],
      description: map['descricao'],
      instructions: map['instrucoes'],
      image: map['encodedGif'],
      precautions: map['precaucoes'],
      observations: map['observacoes'],
      medic: map['medico'] != null ? Medic.fromMap(map['medico']) : null,
      createdAt: map['dataCriacao'] != null
          ? DateTime.parse(map['dataCriacao'])
          : null,
      updatedAt: map['dataAtualizacao'] != null
          ? DateTime.parse(map['dataAtualizacao'])
          : null,
      injuryType: map['tipoLesao'] != null
          ? InjuryType.fromMap(map['tipoLesao'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "idExercicio": idExercise,
      "idMedico": idMedic,
      "idTipoLesao": idInjuryType,
      "nome": name,
      "descricao": description,
      "instrucoes": instructions,
      "encodedGif": image,
      "precaucoes": precautions,
      "observacoes": observations,
      "dataCriacao": createdAt,
      "dataAtualizacao": updatedAt,
    };
  }
}
