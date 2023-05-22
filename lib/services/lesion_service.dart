import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prev_ler/entities/injury.dart';
import 'dart:convert';

final String baseUrl =
    '${dotenv.env['API_BASE_URL'] ?? 'env not found!'}/tipolesoes';
final headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Future<Injury> createLesion(
    String idmedico, String nome, String sigla, String descricao) async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'idMedico': idmedico,
      'nome': nome,
      'sigla': sigla,
      'descricao': descricao,
    }),
  );

  if (response.statusCode == 201) {
    return Injury.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create lesion.');
  }
}
