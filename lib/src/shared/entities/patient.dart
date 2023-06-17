class Patient {
  int idPatient;
  String occupation;

  Patient({
    this.idPatient = 0,
    required this.occupation,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPaciente': idPatient,
      'ocupacao': occupation,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> json) {
    return Patient(
      idPatient: json['idPaciente'],
      occupation: json['ocupacao'],
    );
  }
}
