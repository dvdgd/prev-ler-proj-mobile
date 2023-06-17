import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_service.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/enums/state_controller.dart';

class ContentsController extends ChangeNotifier {
  List<Content> contents = [];
  StateEnum state = StateEnum.idle;
  String errorMessage = '';

  final ContentsService service;

  ContentsController(this.service);

  Future<void> fetchAllContents() async {
    state = StateEnum.loading;
    contents = [];
    notifyListeners();

    try {
      contents = await service.fetchAll();
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<Content> fetchContentById(int idContent) async {
    return service.fetchById(idContent);
  }

  Future<void> create(Content content) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      final newContent = await service.create(content);
      contents.add(newContent);
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> update(Content newContent) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await service.update(newContent);

      final contentIndex = contents.indexWhere(
        (cnt) => cnt.idContent == newContent.idContent,
      );

      if (contentIndex != -1) {
        contents[contentIndex] = newContent;
        notifyListeners();
      }

      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteContent(Content content) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await service.delete(content);

      contents.removeWhere((cnt) => cnt.idContent == content.idContent);
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }
}