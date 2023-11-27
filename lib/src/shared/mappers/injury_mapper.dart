import 'package:prev_ler/src/shared/entities/injury_type.dart';

Map<String, dynamic> injuryToSupabase(InjuryType injury) {
  return {
    'id_enfermidade': injury.idInjuryType,
    'id_empresa': injury.companyId,
    'nome': injury.name,
    'descricao': injury.description,
  };
}

InjuryType injutyFromSupabase(dynamic injuryResponse) {
  return InjuryType(
    idInjuryType: injuryResponse['id_enfermidade'],
    companyId: injuryResponse['id_empresa'],
    name: injuryResponse['nome'],
    description: injuryResponse['descricao'],
  );
}
