class User {
  String email;
  String? password;
  Patient? patient;
  Medic? medic;

  User({
    required this.email,
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
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['senhaEncriptada'],
      patient:
          json['paciente'] != null ? Patient.fromJson(json['paciente']) : null,
      medic: json['medico'] != null ? Medic.fromJson(json['medico']) : null,
    );
  }
}

class Patient {
  String name;
  String occupation;
  DateTime bornDate;

  Patient({
    required this.name,
    required this.occupation,
    required this.bornDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'ocupacao': occupation,
      'dataNascimento': bornDate.toIso8601String(),
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['nome'],
      occupation: json['ocupacao'],
      bornDate: DateTime.parse(json['dataNascimento']),
    );
  }
}

class Medic {
  String name;
  String crmNumber;
  String crmState;
  String? situacaoCrm;
  DateTime bornDate;

  Medic({
    required this.name,
    required this.crmNumber,
    required this.crmState,
    required this.bornDate,
    this.situacaoCrm,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': name,
      'numeroCrm': crmNumber,
      'ufCrm': crmState,
      'situacaoCrm': situacaoCrm,
      'dataNascimento': bornDate.toIso8601String(),
    };
  }

  factory Medic.fromJson(Map<String, dynamic> json) {
    return Medic(
      name: json['nome'],
      crmNumber: json['numeroCrm'],
      crmState: json['ufCrm'],
      situacaoCrm: json['situacaoCrm'],
      bornDate: DateTime.parse(json['dataNascimento']),
    );
  }
}
