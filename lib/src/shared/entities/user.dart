import 'package:prev_ler/src/shared/entities/company.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class UserSignUp {
  String email;
  String password;
  String passwordConfirmation;
  String cpf;

  UserSignUp({
    required this.cpf,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}

class User {
  String userId;
  String email;
  String firstName;
  String lastName;
  String cpf;
  String jobRole;
  DateTime? bornDate;
  String? password;
  UserType? type;
  Company? company;

  User({
    this.userId = '',
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.cpf,
    required this.jobRole,
    this.company,
    this.type,
    this.bornDate,
    this.password,
  });
}
