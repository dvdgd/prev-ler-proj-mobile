import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/mappers/injury_mapper.dart';

abstract class InjuriesService {
  Future<List<InjuryType>> fetchAll();
  Future<InjuryType> create(InjuryType injuryType);
  Future<void> update(InjuryType newInjuryType);
  Future<void> delete(InjuryType injuryType);
}

class InjuriesServiceImpl extends InjuriesService {
  InjuriesServiceImpl();

  @override
  Future<InjuryType> create(InjuryType injuryType) async {
    try {
      final injurySupabaseInsert = injuryToSupabase(injuryType);
      await supabaseClient.from('enfermidade').insert(injurySupabaseInsert);
      return injuryType;
    } catch (e) {
      throw UnknowError();
    }
  }

  @override
  Future<List<InjuryType>> fetchAll() async {
    try {
      final supabaseInjuries =
          await supabaseClient.from('enfermidade').select('*') as List<dynamic>;

      final injuries =
          supabaseInjuries.map((injury) => injutyFromSupabase(injury)).toList();

      return injuries;
    } catch (e) {
      throw BaseError(
        message:
            'Ocorreu um erro ao buscar as lessões, tente novamente mais tarde.',
      );
    }
  }

  @override
  Future<void> delete(InjuryType injuryType) async {
    try {
      await supabaseClient
          .from('enfermidade')
          .delete()
          .eq('id_enfermidade', injuryType.idInjuryType);
    } catch (e) {
      throw BaseError(
        message: 'Ops... Não foi possível excluir a enfermidade.',
      );
    }
  }

  @override
  Future<void> update(InjuryType newInjuryType) async {
    try {
      final newInjuryTypeSupabase = injuryToSupabase(newInjuryType);
      await supabaseClient
          .from('enfermidade')
          .update(newInjuryTypeSupabase)
          .eq('id_enfermidade', newInjuryType.idInjuryType);
    } catch (e) {
      throw UnknowError();
    }
  }
}
