import 'dart:convert';

import 'package:http/http.dart' as http;

class ClientHttp {
  final headers = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  };

  Future<T> fetch<T>({
    required Uri uri,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    final response = await http.get(uri, headers: {
      ...this.headers,
      ...?headers,
    });

    if (response.statusCode != 200) {
      throw Exception("Erro na requisição");
    }

    return json.decode(response.body);
  }

  Future<T> post<T>({
    required Uri uri,
    required Map data,
    Map<String, String>? headers,
  }) async {
    final response = await http.post(
      headers: {
        ...this.headers,
        ...?headers,
      },
      uri,
      body: json.encode(data),
    );

    final statusCode = response.statusCode;
    if (statusCode >= 400 && statusCode <= 500) {
      throw Exception("Erro na criação");
    }

    return json.decode(response.body);
  }

  Future<void> put({
    required Uri uri,
    required Map data,
    Map<String, String>? headers,
  }) async {
    final response = await http.put(
      uri,
      body: json.encode(data),
      headers: {...this.headers, ...?headers},
    );

    if (response.statusCode != 204) {
      throw Exception('Falha ao atualizar');
    }
  }

  Future<void> delete<T>({
    required Uri uri,
    Map<String, String>? headers,
  }) async {
    final response = await http.delete(uri, headers: {
      ...this.headers,
      ...?headers,
    });

    if (response.statusCode != 204) {
      throw Exception("Falha ao deletar");
    }
  }
}
