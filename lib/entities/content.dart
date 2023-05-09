import 'package:prev_ler/entities/lesion.dart';

class Content {
  String title;
  String subtitle;
  Lesion lesion;
  String? description;
  String? observation;

  Content({
    required this.title,
    required this.subtitle,
    required this.lesion,
    required this.description,
    this.observation,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': title,
      'subtitulo': subtitle,
      'descricao': description,
      'observacao': observation,
      // 'tipoLesao' : lesion?.toJson(),
    };
  }
}
