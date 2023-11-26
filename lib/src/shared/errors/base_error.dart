import 'package:flutter/material.dart';

class BaseError implements Exception {
  String message;
  String? description;

  BaseError({
    required this.message,
    this.description,
  });
}

class UnknowError implements BaseError {
  @override
  String? description = "Desculpe, tente novamente mais tarde.";
  @override
  String message = "Ops, ocorreu um erro inesperado...";

  String? detailedMessage;

  UnknowError({this.description, this.detailedMessage}) {
    debugPrint(detailedMessage);
    debugPrintStack();
  }
}
