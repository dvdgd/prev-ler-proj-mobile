import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void debugPrintHttpRequestOptions(RequestOptions options) {
  if (kDebugMode) {
    return;
  }

  log(json.encode('BaseURL: ${options.baseUrl}'), name: 'Request[BaseURL]');
  log(json.encode('Endpoint: ${options.path}'), name: 'Request[Endpoint]');

  if (options.headers['access-token'] != null) {
    log(
      json.encode('access-token: ${options.headers['access-token']}'),
      name: 'Request[access-token]',
    );
  }
  if (options.data != null) {
    log(
      json.encode('Payload: ${json.encode(options.data)}'),
      name: 'Request[Payload]',
    );
  }
}

void debugPrintHttpResponse(Response response) {
  if (kDebugMode) {
    log(json.encode('Response: ${response.data}'), name: 'Response');
  }
}
