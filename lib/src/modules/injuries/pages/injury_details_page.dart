import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';

class InjuryDetailsPage extends StatelessWidget {
  const InjuryDetailsPage(this.injuryType, {super.key});

  final InjuryType injuryType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final title = injuryType.name;
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
              const SizedBox(height: 15),
              Text(
                description,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
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
