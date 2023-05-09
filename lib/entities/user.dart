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

class Patient {
  String occupation;

  Patient({
    required this.occupation,
  });

  Map<String, dynamic> toJson() {
    return {
      'ocupacao': occupation,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      occupation: json['ocupacao'],
    );
  }
}

class Medic {
  String crmNumber;
  String crmState;
  String? situacaoCrm;

  Medic({
    required this.crmNumber,
    required this.crmState,
    this.situacaoCrm,
  });

  Map<String, dynamic> toJson() {
    return {
      'numeroCrm': crmNumber,
      'ufCrm': crmState,
      'situacaoCrm': situacaoCrm,
    };
  }

  factory Medic.fromJson(Map<String, dynamic> json) {
    return Medic(
      crmNumber: json['numeroCrm'],
      crmState: json['ufCrm'],
      situacaoCrm: json['situacaoCrm'],
    );
  }
}
