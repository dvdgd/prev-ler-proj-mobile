import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/mappers/content_mapper.dart';

abstract class ContentsService {
  Future<List<Content>> fetchAll();
  Future<Content> create(Content content);
  Future<List<Content>> fetchLastsContents(int qtdContents);
  Future<void> update(Content newContent);
  Future<void> delete(Content content);
}

class ContentsServiceImpl extends ContentsService {
  ContentsServiceImpl();

  @override
  Future<Content> create(Content content) async {
    try {
      final contentSup = contentToSupabase(content);
      await supabaseClient.from('conteudo').insert(contentSup);
      return content;
    } catch (e) {
      throw BaseError(message: 'Desculpe, não foi possível criar o conteúdo.');
    }
  }

  @override
  Future<List<Content>> fetchAll() async {
    try {
      final supContents = await supabaseClient
          .from('conteudo')
          .select('*, enfermidade(*)') as List<dynamic>;
      final contents = supContents.map((c) => contentFromSupabase(c)).toList();
      return contents;
    } catch (e) {
      throw BaseError(
        message:
            'Ocorreu um erro ao buscar as lessões, tente novamente mais tarde.',
      );
    }
  }

  @override
  Future<void> delete(Content content) async {
    try {
      await supabaseClient
          .from('conteudo')
          .delete()
          .eq('id_conteudo', content.contentId);
    } catch (e) {
      throw UnknowError();
    }
  }

  @override
  Future<void> update(Content newContent) async {
    try {
      final supContent = contentToSupabase(newContent);
      await supabaseClient
          .from('conteudo')
          .update(supContent)
          .eq('id_conteudo', newContent.contentId);
    } catch (e) {
      throw UnknowError();
    }
  }

  @override
  Future<List<Content>> fetchLastsContents(int qtdContents) async {
    try {
      final supContents = await supabaseClient
          .from('conteudo')
          .select('*, enfermidade(*)')
          .order('id_conteudo', ascending: false)
          .limit(qtdContents) as List<dynamic>;

      final contents = supContents.map((c) => contentFromSupabase(c)).toList();
      return contents;
    } catch (e) {
      throw BaseError(
        message:
            'Ocorreu um erro ao buscar as lessões, tente novamente mais tarde.',
      );
    }
  }
}
