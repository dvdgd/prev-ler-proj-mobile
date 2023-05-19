import 'package:prev_ler/entities/medic.dart';
import 'package:prev_ler/entities/patient.dart';

class User {
  String email;
  String name;
  DateTime bornDate;
  String? password;
  Patient? patient;
  Medic? medic;

  User({
    required this.email,
    required this.bornDate,
    required this.name,
    this.password,
    this.patient,
    this.medic,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'senhaEncriptada': password,
      'paciente': patient?.toJson(),
      'medico': medic?.toJson(),
      'nome': name,
      'dataNascimento': bornDate.toIso8601String()
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['senhaEncriptada'],
      name: json['nome'],
      bornDate: DateTime.parse(json['dataNascimento']),
      patient:
          json['paciente'] != null ? Patient.fromJson(json['paciente']) : null,
      medic: json['medico'] != null ? Medic.fromJson(json['medico']) : null,
    );
  }
}
