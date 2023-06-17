class Medic {
  int idMedic;
  String crmNumber;
  String crmState;
  String? crmStatus;

  Medic({
    this.idMedic = 0,
    required this.crmNumber,
    required this.crmState,
    this.crmStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'idMedico': idMedic,
      'numeroCrm': crmNumber,
      'ufCrm': crmState,
      'situacaoCrm': crmStatus,
    };
  }

  factory Medic.fromMap(Map<String, dynamic> json) {
    return Medic(
      idMedic: json['idMedico'],
      crmNumber: json['numeroCrm'],
      crmState: json['ufCrm'],
      crmStatus: json['situacaoCrm'],
    );
  }
}
