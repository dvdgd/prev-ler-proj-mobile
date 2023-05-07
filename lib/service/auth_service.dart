import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../entities/user.dart';

class AuthService {
  final storage = const FlutterSecureStorage();

  final String baseUrl =
      '${dotenv.env['API_BASE_URL'] ?? 'env not found!'}/usuarios';
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Map<String, dynamic>> register(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(response.body);
    }

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers,
      body: jsonEncode({'email': email, 'senha': password}),
    );

    if (response.statusCode != 200) {
      throw Exception("Usuario ou senha invalidos");
    }

    var responseBody = json.decode(response.body);
    await storage.write(key: 'jwt_token', value: responseBody['token']);

    return responseBody;
  }

  Future<void> logout() async {
    await storage.delete(key: 'jwt_token');
  }

  Future<String?> getToken() async {
    var jwtToken = await storage.read(key: 'jwt_token');
    if (jwtToken == null) {
      throw Exception("Erro ao obter login, tente novamente.");
    }
    return jwtToken;
  }
}
