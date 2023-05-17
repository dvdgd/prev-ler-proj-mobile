import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prev_ler/entities/content.dart';

final String baseUrl =
    '${dotenv.env['API_BASE_URL'] ?? 'env not found!'}/conteudos';
final headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Future<Content> createContent(String idmedico, String idlesao, String titulo,
    String subtitulo, String descricao, String observacao) async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'idMedico': idmedico,
      'idTipoLesao': idlesao,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'descricao': descricao,
      'observacao': observacao,
    }),
  );

  if (response.statusCode == 201) {
    return Content.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create content.');
  }
}
