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
}

final contentProvider =
    ChangeNotifierProvider<ContentService>((_) => ContentService());

final contentDataProvider =
    FutureProvider((ref) => ref.watch(contentProvider).getContents());
