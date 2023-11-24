import 'package:prev_ler/src/shared/entities/injury_type.dart';

abstract class InjuriesService {
  Future<List<InjuryType>> fetchAll();
  Future<InjuryType> fetchById(int idInjuryType);
  Future<InjuryType> create(InjuryType injuryType);
  Future<void> update(InjuryType newInjuryType);
  Future<void> delete(InjuryType injuryType);
}

class InjuriesServiceImpl extends InjuriesService {
  InjuriesServiceImpl();

  @override
  Future<InjuryType> create(InjuryType injuryType) async {
    return injuryType;
  }

  @override
  Future<List<InjuryType>> fetchAll() async {
    return [
      InjuryType(
        idMedic: 1,
        name: "name",
        abbreviation: "abbreviation",
        description: "description",
      ),
      InjuryType(
        idMedic: 1,
        name: "name",
        abbreviation: "abbreviation",
        description: "description",
      ),
    ];
  }

  @override
  Future<InjuryType> fetchById(int idInjuryType) async {
    return InjuryType(
      idMedic: 1,
      name: "name",
      abbreviation: "abbreviation",
      description: "description",
    );
  }

  @override
  Future<void> delete(InjuryType injuryType) async {
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> update(InjuryType newInjuryType) async {
    Future.delayed(const Duration(seconds: 1));
  }
}
