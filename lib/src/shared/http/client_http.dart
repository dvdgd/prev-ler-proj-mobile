import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ClientHttp {
  final Dio dio = Dio();
  final List<InterceptorsWrapper>? interceptors;

  ClientHttp(this.interceptors) {
    dio.options.contentType = 'application/json; charset=utf-8';
    dio.options.responseType = ResponseType.json;
    dio.options.connectTimeout = const Duration(seconds: 10);
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors!);
    }
  }

  Future<Response> _requestWrapper(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      debugPrint(e.toString());
      debugPrintStack();
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Tempo de conexão com o servidor expirado.');
      }
      throw Exception('Ocorreu um erro inesperado na requisição.');
    } catch (e) {
      debugPrint(e.toString());
      debugPrintStack();
      throw Exception('Ocorreu um erro inesperado na requisição.');
    }
  }

  Future<T> fetch<T>({
    required Uri uri,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    final response = await _requestWrapper(() => dio.get(
          uri.toString(),
          queryParameters: queryParams,
          options: Options(headers: headers),
        ));

    if (response.statusCode != 200) {
      throw Exception("Erro na requisição");
    }

    return response.data;
  }

  Future<T> post<T>({
    required Uri uri,
    required Map data,
    Map<String, String>? headers,
  }) async {
    final response = await _requestWrapper(() => dio.post(
          uri.toString(),
          data: data,
          options: Options(
            headers: headers,
          ),
        ));

    final statusCode = response.statusCode;
    if (statusCode == null || statusCode >= 400 && statusCode <= 500) {
      throw Exception("Erro na criação");
    }

    return response.data;
  }

  Future<void> put({
    required Uri uri,
    required Map data,
    Map<String, String>? headers,
  }) async {
    final response = await _requestWrapper(() => dio.put(
          uri.toString(),
          data: data,
          options: Options(headers: headers),
        ));

    if (response.statusCode != 204) {
      throw Exception('Falha ao atualizar');
    }
  }

  Future<void> delete<T>({
    required Uri uri,
    Map<String, String>? headers,
  }) async {
    final response = await _requestWrapper(
      () => dio.delete(uri.toString(), options: Options(headers: headers)),
    );

    if (response.statusCode != 204) {
      throw Exception("Falha ao deletar");
    }
  }
}
