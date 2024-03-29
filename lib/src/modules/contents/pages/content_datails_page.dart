import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

class ContentDetailsPage extends StatelessWidget {
  const ContentDetailsPage(this.content, {super.key});

  final Content content;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final title = content.title;
    final subtitle = content.subtitle;
    final description = content.description;
    final observations = content.observation;

    final injuryType = content.injuryType;

    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Conteúdo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(title, style: textTheme.titleLarge),
            const SizedBox(height: 15),
            Text(subtitle, style: textTheme.titleMedium),
            const SizedBox(height: 30),
            Text(
              description,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            if (observations != null && observations.isNotEmpty) ...[
              Text('Observações', style: textTheme.titleMedium),
              const SizedBox(height: 10),
              Text(
                observations,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
            const SizedBox(height: 30),
            Text(
              'Conteúdo criado em ${MyConverter.toDateTimeString(content.createdAt!)}',
              style: textTheme.bodySmall,
            ),
            Text(
              'Conteúdo atualizado em ${MyConverter.toDateTimeString(content.createdAt!)}',
              style: textTheme.bodySmall,
            ),
            if (injuryType != null) ...[
              const Divider(),
              Text(
                'Lesão: ${injuryType.name}',
                style: textTheme.bodySmall,
              ),
              Text(
                'Lesão criada em ${MyConverter.toDateTimeString(injuryType.createdAt!)}',
                style: textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
