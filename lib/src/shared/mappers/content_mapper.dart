import 'package:prev_ler/src/shared/entities/content.dart';

Content contentFromSupabase(dynamic content) {
  return Content(
    injuryTypeId: content['id_enfermidade'],
    userId: content['id_usuario'],
    contentId: content['id_conteudo'],
    companyId: content['id_empresa'],
    title: content['titulo'],
    subtitle: content['subtitulo'],
    description: content['descricao'],
    observation: content['observacao'],
  );
}

dynamic contentToSupabase(Content content) {
  final Map<String, dynamic> contentMap = {
    'id_usuario': content.userId,
    'id_enfermidade': content.injuryTypeId,
    'id_empresa': content.companyId,
    'titulo': content.title,
    'subtitulo': content.subtitle,
    'descricao': content.description,
    'observacao': content.observation,
  };

  if (content.contentId != 0) {
    contentMap['id_conteudo'] = content.contentId;
  }

  return contentMap;
}
