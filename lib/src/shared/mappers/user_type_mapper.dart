import '../utils/enums.dart';

UserType? userTypeFromSupabase(String? status) {
  switch (status) {
    case 'profissional_saude':
      return UserType.healthProfessional;
    case 'funcionario':
      return UserType.employee;
    default:
      return null;
  }
}
