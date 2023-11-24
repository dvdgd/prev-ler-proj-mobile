import 'package:prev_ler/src/shared/utils/enums.dart';

class User {
  int idUser;
  String email;
  String firstName;
  String lastName;
  String cpf;
  DateTime? bornDate;
  String? password;
  UserType type;

  User({
    this.idUser = 0,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.type,
    required this.cpf,
    this.bornDate,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUser,
      'email': email,
      'data': {},
      'first_name': firstName,
    };
  }

  Map<String, dynamic> toSignUpMap() {
    return {
      'id_usuario': idUser,
      'email': email,
      'data': {
        'first_name': firstName,
        'last_name': lastName,
        'cpf': cpf,
        'born_date': bornDate?.toIso8601String(),
      },
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      bornDate: json['born_date'],
      cpf: json['cpf'],
      idUser: json['id_usuario'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      type: UserType.employee,
    );
  }
}
