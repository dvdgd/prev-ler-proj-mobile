import 'package:prev_ler/src/shared/entities/injury_type.dart';

Map<String, dynamic> injuryToSupabase(InjuryType injury) {
  final Map<String, dynamic> injuryMap = {
    'id_usuario': injury.userId,
    'id_empresa': injury.companyId,
    'nome': injury.name,
    'descricao': injury.description,
  };

  if (injury.idInjuryType != 0) {
    injuryMap['id_enfermidade'] = injury.idInjuryType;
  }

  return injuryMap;
}

InjuryType injutyFromSupabase(dynamic injuryResponse) {
  return InjuryType(
    userId: injuryResponse['id_usuario'],
    idInjuryType: injuryResponse['id_enfermidade'],
    companyId: injuryResponse['id_empresa'],
    name: injuryResponse['nome'],
    description: injuryResponse['descricao'],
  );
}
