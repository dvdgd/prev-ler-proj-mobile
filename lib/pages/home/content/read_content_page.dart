import 'package:flutter/material.dart';
import 'package:prev_ler/entities/content.dart';

class ContentRead extends StatelessWidget {
  const ContentRead(this.content, {super.key});

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Conteúdo'),
      ),
      body: Column(
        children: [
          Text('Título: ${content.title}'),
          Text('Subtítulo: ${content.subtitle}'),
          Text('Descrição: ${content.description}'),
          Text('Observação: ${content.observation}'),
        ],
      ),
    );
  }
}
