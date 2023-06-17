import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/entities/patient.dart';

class User {
  int idUsuario;
  String email;
  String name;
  DateTime bornDate;
  String? password;
  Patient? patient;
  Medic? medic;

  User({
    this.idUsuario = 0,
    required this.email,
    required this.bornDate,
    required this.name,
    this.password,
    this.patient,
    this.medic,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senhaEncriptada': password,
      'paciente': patient?.toMap(),
      'medico': medic?.toMap(),
      'nome': name,
      'dataNascimento': bornDate.toIso8601String()
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['senhaEncriptada'],
      name: json['nome'],
      bornDate: DateTime.parse(json['dataNascimento']),
      patient:
          json['paciente'] != null ? Patient.fromMap(json['paciente']) : null,
      medic: json['medico'] != null ? Medic.fromMap(json['medico']) : null,
    );
  }
}
