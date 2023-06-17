import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';

abstract class InjuriesService {
  Future<List<InjuryType>> fetchAll();
  Future<InjuryType> fetchById(int idInjuryType);
  Future<InjuryType> create(InjuryType injuryType);
  Future<void> update(InjuryType newInjuryType);
  Future<void> delete(InjuryType injuryType);
}

class InjuriesServiceImpl extends InjuriesService {
  final String _baseUrl = '${Environment.apiBaseUrl}/TipoLesoes';
  final ClientHttp clientHttp;

  InjuriesServiceImpl(this.clientHttp);

  @override
  Future<InjuryType> create(InjuryType injuryType) async {
    final responseBody = await clientHttp.post(
      uri: Uri.parse(_baseUrl),
      data: injuryType.toMap(),
    );

    return InjuryType.fromMap(responseBody);
  }

  @override
  Future<List<InjuryType>> fetchAll() async {
    final responseBody = await clientHttp.fetch<List<dynamic>>(
      uri: Uri.parse(_baseUrl),
    );

    final contentsList = responseBody.map((e) => InjuryType.fromMap(e));

    return List.from(contentsList);
  }

  @override
  Future<InjuryType> fetchById(int idInjuryType) async {
    final responseBody = await clientHttp.fetch(
      uri: Uri.parse('$_baseUrl/$idInjuryType'),
    );

    return InjuryType.fromMap(responseBody);
  }

  @override
  Future<void> delete(InjuryType injuryType) async {
    await clientHttp.delete(
      uri: Uri.parse('$_baseUrl/${injuryType.idInjuryType}'),
    );
  }

  @override
  Future<void> update(InjuryType newInjuryType) async {
    final id = newInjuryType.idInjuryType;
    await clientHttp.put(
      uri: Uri.parse('$_baseUrl/$id'),
      data: newInjuryType.toMap(),
    );
  }
}
