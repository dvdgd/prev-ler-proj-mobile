import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:prev_ler/entities/user.dart';

class AuthService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  final String baseUrl =
      '${dotenv.env['API_BASE_URL'] ?? 'env not found!'}/usuarios';
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Map<String, dynamic>> register(User user) async {
    final userJson = user.toJson();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(userJson),
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
    await storage.write(key: 'jwt_token', value: responseBody['auth']['token']);

    notifyListeners();
    return responseBody;
  }

  Future<void> logout() async {
    await storage.delete(key: 'jwt_token');
    notifyListeners();
  }

  Future<String?> getToken() async {
    var jwtToken = await storage.read(key: 'jwt_token');
    if (jwtToken == null) {
      throw Exception("Erro ao obter login, tente novamente.");
    }

    return jwtToken;
  }

  Future<User> getUserData() async {
    final authToken = await getToken();
    if (authToken == null) {
      throw Exception('Erro ao recuperar dados do usuário');
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(authToken);
    var userId = decodedToken['nameid'];

    final response = await http.get(
      Uri.parse('$baseUrl/$userId'),
      headers: {...headers, 'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao recuperar dados do usuário');
    }

    final responseBody = json.decode(response.body);
    return User.fromJson(responseBody);
  }
}

final authProvider = ChangeNotifierProvider<AuthService>((_) => AuthService());

final authDataProvider =
    FutureProvider((ref) => ref.watch(authProvider).getUserData());
