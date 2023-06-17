import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';

class ContentRead extends StatelessWidget {
  const ContentRead(this.content, {super.key});

  final Content content;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final title = content.title;
    final subtitle = content.subtitle;
    final description = content.description;
    final observation = content.observation;

    final injuryType = content.injuryType;

    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Detalhes do Conteúdo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(subtitle, style: textTheme.titleMedium),
              const SizedBox(height: 20),
              Text(
                description,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 25),
              Text('Observações', style: textTheme.titleMedium),
              const SizedBox(height: 10),
              Text(
                observation,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 25),
              Text(
                'Conteúdo criado em ${content.createdAt.toString()}',
                style: textTheme.bodySmall,
              ),
              Text(
                'Conteúdo atualizado em ${content.createdAt.toString()}',
                style: textTheme.bodySmall,
              ),
              if (injuryType != null) ...[
                const Divider(),
                Text(
                  'Lesão: ${injuryType.name} - (${injuryType.abbreviation})',
                  style: textTheme.bodySmall,
                ),
                Text(
                  'Lesão criada em ${injuryType.createdAt.toString()}',
                  style: textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
