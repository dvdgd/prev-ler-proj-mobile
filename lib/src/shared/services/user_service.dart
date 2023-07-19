import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/secure_store.dart';

class UserService {
  final String baseUrl = '${Environment.apiBaseUrl}/usuarios';

  final SecureStore _secureStorage;
  final ClientHttp _clientHttp;

  User? currentUser;

  UserService(this._clientHttp, this._secureStorage);

  Future<void> register(User user) async {
    await _clientHttp.post(
      data: user.toMap(),
      uri: Uri.parse(baseUrl),
    );
  }

  Future<bool> checkUserState() {
    return _secureStorage.containsBearer();
  }

  Future<Map<String, String>> getBearerHeader() async {
    final bearer = await _secureStorage.getBearer();
    return {'Authorization': 'Bearer $bearer'};
  }

  Future<dynamic> getCurrentUserId() async {
    final authToken = await _secureStorage.getBearer();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(authToken);
    return decodedToken['nameid'];
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final responseBody = await _clientHttp.post(
      data: {'email': email, 'senha': password},
      uri: Uri.parse('$baseUrl/login'),
    );

    await Future.wait([
      _secureStorage.saveBearer(responseBody['auth']['token']),
      _secureStorage.saveUserPassword(password),
    ]);

    return responseBody;
  }

  Future<User> getUserData() async {
    final results = await Future.wait([getBearerHeader(), getCurrentUserId()]);

    final bearerHeader = results[0];
    final userId = results[1];

    final responseBody = await _clientHttp.fetch(
      uri: Uri.parse('$baseUrl/$userId'),
      headers: bearerHeader,
    );

    responseBody['senhaEncriptada'] = await _secureStorage.getPassword();
    final user = User.fromMap(responseBody);
    currentUser = user;

    return user;
  }

  Future<void> logout() async {
    await _secureStorage.deleteBearerAndPassword();
  }

  Future<void> updateUser(User newUser) async {
    final results = await Future.wait([getBearerHeader(), getCurrentUserId()]);

    final bearerHeader = results[0];
    final id = results[1];

    await _clientHttp.put(
      uri: Uri.parse('$baseUrl/$id'),
      data: newUser.toMap(),
      headers: bearerHeader,
    );
  }
}
