import 'package:prev_ler/src/shared/entities/content.dart';

abstract class ContentsService {
  Future<List<Content>> fetchAll();
  Future<Content> fetchById(int idContent);
  Future<Content> create(Content content);
  Future<void> update(Content newContent);
  Future<void> delete(Content content);
}

class ContentsServiceImpl extends ContentsService {
  ContentsServiceImpl();

  @override
  Future<List<Content>> fetchAll() async {
    final contentsList = [
      Content(
        idMedic: 1,
        idInjuryType: 1,
        title: "teste",
        subtitle: "subtitle",
        description: "description",
        observation: "observation",
      ),
      Content(
        idMedic: 1,
        idInjuryType: 2,
        title: "teste 2",
        subtitle: "subtitle",
        description: "description",
        observation: "observation",
      ),
    ];

    return List.from(contentsList);
  }

  @override
  Future<Content> fetchById(int idContent) async {
    return Content(
      idMedic: 1,
      idInjuryType: 1,
      title: "teste",
      subtitle: "subtitle",
      description: "description",
      observation: "observation",
    );
  }

  @override
  Future<Content> create(Content content) async {
    return content;
  }

  @override
  Future<void> delete(Content content) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> update(Content newContent) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
