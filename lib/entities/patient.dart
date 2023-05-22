class Patient {
  int? idPatient;
  String occupation;

  Patient({
    this.idPatient,
    required this.occupation,
  });

  Map<String, dynamic> toJson() {
    return {
      'idPaciente': idPatient,
      'ocupacao': occupation,
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      idPatient: json['idPaciente'],
      occupation: json['ocupacao'],
    );
  }
}
