import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prev_ler/entities/content.dart';

class ContentService extends ChangeNotifier {
  final String _baseUrl =
      '${dotenv.env['API_BASE_URL'] ?? 'env not found!'}/conteudos';
  final headers = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  };

  Future<List<Content>> getContents() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Nenhum conteúdo encontrado.');
    }

    final List<dynamic> responseBody = json.decode(response.body);
    var contentsList = <Content>[];

    for (final content in responseBody) {
      contentsList.add(Content.fromJson(content));
    }

    return UnmodifiableListView(contentsList);
  }

  Future<Map<String, dynamic>> register(Content content) async {
    final contentJson = content.toJson();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(contentJson),
    );

    if (response.statusCode != 201) {
      throw Exception(response.body);
    }
    notifyListeners();
    return json.decode(response.body);
  }

  Future<void> update(Content content) async {
    final contentJson = content.toJson();
    final response = await http.put(
      Uri.parse('$_baseUrl/${content.idContent}'),
      body: jsonEncode(contentJson),
      headers: headers,
    );

    if (response.statusCode != 204) {
      throw Exception("Conteúdo não pôde ser editado");
    }
    notifyListeners();
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception("Conteúdo não pôde ser excluído");
    }
    notifyListeners();
  }
}

final contentProvider =
    ChangeNotifierProvider<ContentService>((_) => ContentService());

final contentDataProvider =
    FutureProvider((ref) => ref.watch(contentProvider).getContents());
