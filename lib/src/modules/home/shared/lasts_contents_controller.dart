import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_service.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class LastsContentsController extends ChangeNotifier {
  StateEnum state = StateEnum.idle;
  List<Content> contents = [];
  String errorMessage = '';

  final ContentsService _contentsService;
  LastsContentsController(this._contentsService);

  Future<void> fetchLastsContents() async {
    notifyListeners();

    try {
      contents = await _contentsService.fetchLastsContents(3);
      state = StateEnum.success;
    } catch (e) {
      errorMessage =
          'Ocorreu um erro inesperado ao buscar os últimos exercicíos.';
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }
}
