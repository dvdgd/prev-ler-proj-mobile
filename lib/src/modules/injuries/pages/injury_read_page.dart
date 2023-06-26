import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';

class InjuryRead extends StatelessWidget {
  const InjuryRead(this.injuryType, {super.key});

  final InjuryType injuryType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final title = injuryType.name;
    final subtitle = injuryType.abbreviation;
    final description = injuryType.description;

    final createdAt = injuryType.createdAt;
    final updatedAt = injuryType.updatedAt;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const PageTitle(title: 'Detalhes da lesão'),
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
              const Divider(),
              Text(
                'Criada em ${createdAt.toString()}',
                style: textTheme.bodySmall,
              ),
              Text(
                'Atualizada em ${updatedAt.toString()}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
