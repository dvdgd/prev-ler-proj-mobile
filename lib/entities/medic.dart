class Medic {
  int? idMedic;
  String crmNumber;
  String crmState;
  String? situacaoCrm;

  Medic({
    this.idMedic,
    required this.crmNumber,
    required this.crmState,
    this.situacaoCrm,
  });

  Map<String, dynamic> toJson() {
    return {
      'idMedico': idMedic,
      'numeroCrm': crmNumber,
      'ufCrm': crmState,
      'situacaoCrm': situacaoCrm,
    };
  }

  factory Medic.fromJson(Map<String, dynamic> json) {
    return Medic(
      idMedic: json['idMedico'],
      crmNumber: json['numeroCrm'],
      crmState: json['ufCrm'],
      situacaoCrm: json['situacaoCrm'],
    );
  }
}
