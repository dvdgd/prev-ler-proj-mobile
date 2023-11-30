import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

class ExerciseDetailsPage extends StatelessWidget {
  ExerciseDetailsPage({super.key, required this.exercise});

  final Exercise exercise;
  final converter = MyConverter();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final imageBytes = MyConverter.base64Binary(exercise.image);
    final title = exercise.name;
    final description = exercise.description;
    final instrucions = exercise.instructions;

    final injuryType = exercise.injuryType;

    final precautions = exercise.precautions;
    final observations = exercise.observations;

    final createdAt = exercise.createdAt;
    final updatedAt = exercise.updatedAt;

    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Exercício'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCard(
              elevation: 1,
              child: Container(
                width: double.maxFinite,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.memory(
                  imageBytes,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(title, style: textTheme.titleLarge),
            const SizedBox(height: 15),
            Text(
              description,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            Text(
              'Quais são as instruções?',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 15),
            Text(
              instrucions,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            if (precautions != null && precautions.isNotEmpty) ...[
              const SizedBox(height: 30),
              Text(
                'Precauções ao realizar exercício',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 15),
              Text(
                precautions,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
            if (observations != null && observations.isNotEmpty) ...[
              const SizedBox(height: 30),
              Text(
                'Algumas Observações',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 15),
              Text(
                observations,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
            const SizedBox(height: 30),
            Text(
              'Exercício Criado em ${MyConverter.toDateTimeString(createdAt!)}',
              style: textTheme.bodySmall,
            ),
            if (updatedAt != null)
              Text(
                'Exercício Atualizado em ${MyConverter.toDateTimeString(updatedAt)}',
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
