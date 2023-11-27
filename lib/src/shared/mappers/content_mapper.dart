import 'package:prev_ler/src/shared/entities/content.dart';

Content contentFromSupabase(dynamic content) {
  return Content(
    contentId: content['id_conteudo'],
    companyId: content['id_empresa'],
    title: content['titulo'],
    subtitle: content['subtitulo'],
    description: content['descricao'],
    observation: content['observacao'],
  );
}

dynamic contentToSupabase(Content content) {
  return {
    'id_conteudo': content.contentId,
    'id_empresa': content.companyId,
    'titulo': content.title,
    'subtitulo': content.subtitle,
    'descricao': content.description,
    'observacao': content.observation,
  };
}
