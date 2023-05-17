class Content {
  final int idmedico;
  final int idlesao;
  final String titulo;
  final String subtitulo;
  final String descricao;
  final String observacao;

  const Content({
    required this.idmedico,
    required this.idlesao,
    required this.titulo,
    required this.subtitulo,
    required this.descricao,
    required this.observacao,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        idmedico: json['idMedico'],
        idlesao: json['idTipoLesao'],
        titulo: json['titulo'],
        subtitulo: json['subtitulo'],
        descricao: json['descricao'],
        observacao: json['observacao']);
  }
}
