import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/mappers/injury_mapper.dart';

Map<String, dynamic> exerciseToSupabase(Exercise exercise) {
  final Map<String, dynamic> exerciseMap = {
    'id_usuario': exercise.userId,
    'id_enfermidade': exercise.injuryTypeId,
    'id_empresa': exercise.companyId,
    'titulo': exercise.name,
    'descricao': exercise.description,
    'instrucoes': exercise.instructions,
    'precaucoes': exercise.precautions,
    'observacoes': exercise.observations,
    'imagem_base64': exercise.image,
  };

  if (exercise.exerciseId != 0) {
    exerciseMap['id_exercicio'] = exercise.exerciseId;
    exerciseMap['data_atualizacao'] = DateTime.now().toIso8601String();
  }

  return exerciseMap;
}

Exercise exerciseFromSupabase(dynamic exercise) {
  return Exercise(
    exerciseId: exercise['id_exercicio'],
    userId: exercise['id_usuario'],
    injuryTypeId: exercise['id_enfermidade'],
    companyId: exercise['id_empresa'],
    name: exercise['titulo'],
    description: exercise['descricao'],
    instructions: exercise['instrucoes'],
    precautions: exercise['precaucoes'],
    image: exercise['imagem_base64'],
    observations: exercise['observacoes'],
    createdAt: DateTime.parse(exercise['data_inclusao']),
    updatedAt: exercise['data_atualizacao'] != null
        ? DateTime.parse(exercise['data_inclusao'])
        : null,
    injuryType: exercise['enfermidade'] != null
        ? injuryFromSupabase(exercise['enfermidade'])
        : null,
  );
}
