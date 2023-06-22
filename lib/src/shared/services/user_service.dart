import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/secure_store.dart';

class UserService {
  final String baseUrl = '${Environment.apiBaseUrl}/usuarios';

  final SecureStore secureStorage;
  final ClientHttp clientHttp;

  UserService(this.clientHttp, this.secureStorage);

  Future<void> register(User user) async {
    await clientHttp.post(
      data: user.toMap(),
      uri: Uri.parse(baseUrl),
    );
  }

  Future<Map<String, String>> getBearerHeader() async {
    final bearer = await secureStorage.getBearer();
    return {'Authorization': 'Bearer $bearer'};
  }

  Future<dynamic> getCurrentUserId() async {
    final authToken = await secureStorage.getBearer();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(authToken);
    return decodedToken['nameid'];
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final responseBody = await clientHttp.post(
      data: {'email': email, 'senha': password},
      uri: Uri.parse('$baseUrl/login'),
    );

    await Future.wait([
      secureStorage.saveBearer(responseBody['auth']['token']),
      secureStorage.saveUserPassword(password),
    ]);

    return responseBody;
  }

  Future<User> getUserData() async {
    final results = await Future.wait([getBearerHeader(), getCurrentUserId()]);

    final bearerHeader = results[0];
    final userId = results[1];

    final responseBody = await clientHttp.fetch(
      uri: Uri.parse('$baseUrl/$userId'),
      headers: bearerHeader,
    );

    responseBody['senhaEncriptada'] = await secureStorage.getPassword();
    return User.fromMap(responseBody);
  }

  Future<void> logout() async {
    await secureStorage.deleteBearerAndPassword();
  }

  Future<void> updateUser(User newUser) async {
    final results = await Future.wait([getBearerHeader(), getCurrentUserId()]);

    final bearerHeader = results[0];
    final id = results[1];

    await clientHttp.put(
      uri: Uri.parse('$baseUrl/$id'),
      data: newUser.toMap(),
      headers: bearerHeader,
    );
  }
}
