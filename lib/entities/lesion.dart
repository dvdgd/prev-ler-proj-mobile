class Lesion {
  final int idmedico;
  final String nome;
  final String sigla;
  final String descricao;

  Lesion({
    required this.idmedico,
    required this.nome,
    required this.sigla,
    required this.descricao,
  });

  Map<String, dynamic> toJson() {
    return {
      'idMedico': idmedico,
      'nome': nome,
      'sigla': sigla,
      'descricao': descricao,
    };
  }

  factory Lesion.fromJson(Map<String, dynamic> json) {
    return Lesion(
      idmedico: json['idMedico'],
      nome: json['nome'],
      sigla: json['sigla'],
      descricao: json['descricao'],
    );
  }
}
