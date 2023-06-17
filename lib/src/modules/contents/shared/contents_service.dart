import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';

abstract class ContentsService {
  Future<List<Content>> fetchAll();
  Future<Content> fetchById(int idContent);
  Future<Content> create(Content content);
  Future<void> update(Content newContent);
  Future<void> delete(Content content);
}

class ContentsServiceImpl extends ContentsService {
  final String _baseUrl = '${Environment.apiBaseUrl}/conteudos';
  final ClientHttp clientHttp;

  ContentsServiceImpl(this.clientHttp);

  @override
  Future<List<Content>> fetchAll() async {
    final responseBody = await clientHttp.fetch<List<dynamic>>(
      uri: Uri.parse(_baseUrl),
    );

    final contentsList = responseBody.map((e) => Content.fromMap(e));

    return List.from(contentsList);
  }

  @override
  Future<Content> fetchById(int idContent) async {
    final responseBody = await clientHttp.fetch(
      uri: Uri.parse('$_baseUrl/$idContent'),
    );

    return Content.fromMap(responseBody);
  }

  @override
  Future<Content> create(Content content) async {
    final responseBody = await clientHttp.post(
      uri: Uri.parse(_baseUrl),
      data: content.toMap(),
    );

    return Content.fromMap(responseBody);
  }

  @override
  Future<void> delete(Content content) async {
    await clientHttp.delete(uri: Uri.parse('$_baseUrl/${content.idContent}'));
  }

  @override
  Future<void> update(Content newContent) async {
    final id = newContent.idContent;
    await clientHttp.put(
      uri: Uri.parse('$_baseUrl/$id'),
      data: newContent.toMap(),
    );
  }
}
