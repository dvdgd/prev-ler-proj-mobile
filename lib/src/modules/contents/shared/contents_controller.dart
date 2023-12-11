import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_service.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

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
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> create(Content content) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      final newContent = await service.create(content);
      contents.add(newContent);
      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
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
        (cnt) => cnt.contentId == newContent.contentId,
      );

      if (contentIndex != -1) {
        contents[contentIndex] = newContent;
        notifyListeners();
      }

      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
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

      contents.removeWhere((cnt) => cnt.contentId == content.contentId);
      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }
}
