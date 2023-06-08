import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prev_ler/entities/injury_type.dart';

class InjuryService extends ChangeNotifier {
  final String _baseUrl =
      '${dotenv.env['API_BASE_URL'] ?? 'env not found!'}/TipoLesoes';
  final headers = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  };

  Future<List<InjuryType>> getInjuries() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Nenhum tipo de lesão encontrado.');
    }

    final List<dynamic> responseBody = json.decode(response.body);
    var injuriesList = <InjuryType>[];

    for (final injury in responseBody) {
      injuriesList.add(InjuryType.fromJson(injury));
    }

    return UnmodifiableListView(injuriesList);
  }

  Future<Map<String, dynamic>> register(InjuryType injuryType) async {
    final injuryJson = injuryType.toJson();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: (injuryJson),
    );

    if (response.statusCode != 201) {
      throw Exception(response.body);
    }
    notifyListeners();
    return json.decode(response.body);
  }

  Future<void> update(InjuryType injuryType) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${injuryType.idInjuryType}'),
      body: injuryType.toJson(),
      headers: headers,
    );

    if (response.statusCode != 204) {
      throw Exception(response.body);
    }
    notifyListeners();
  }

  Future<void> deleteById(int numInjury) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$numInjury'));

    if (response.statusCode != 204) {
      throw Exception(
          "Não é possível deletar este tipo de lesão pois ele está ligado a um conteúdo.");
    }
    notifyListeners();
  }
}

final injuryProvider =
    ChangeNotifierProvider<InjuryService>((_) => InjuryService());

final injuryDataProvider =
    FutureProvider((ref) => ref.watch(injuryProvider).getInjuries());
