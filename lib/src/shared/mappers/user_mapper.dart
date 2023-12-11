import 'package:prev_ler/src/shared/entities/company.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/mappers/user_type_mapper.dart';

User userFromSupabase(dynamic userResponse) {
  final userTypeEnum = userTypeFromSupabase(userResponse['id_tipo_usuario']);

  return User(
    userId: userResponse['id_usuario'],
    email: userResponse['email'],
    firstName: userResponse['first_name'],
    lastName: userResponse['last_name'],
    cpf: userResponse['cpf'],
    type: userTypeEnum,
    jobRole: userResponse['cargo']['nome'],
    company: Company(
      cnpj: userResponse['empresa']['id_cnpj'],
      companyName: userResponse['empresa']['razao_social'],
      fantasyName: userResponse['empresa']['nome_fantasia'],
    ),
  );
}
