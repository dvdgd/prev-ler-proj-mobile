import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/components/exercise_card.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';

class RoutineDetailsPage extends StatelessWidget {
  const RoutineDetailsPage({super.key, required this.routine});

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final title = routine.title;
    final description = routine.description;
    final weekdays = routine.weekdays;
    final active = routine.active;
    final status = active ? 'ATIVA' : 'INATIVA';

    final startTime = routine.startTime;
    final endTime = routine.endTime;
    final interval = routine.duration;

    final exercises = routine.exercises;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Rotina'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 15),
            Text(
              'Status: $status',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Horario de Inicio: ${startTime.format(context)}',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Horario Fim: ${endTime.format(context)}',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Intervalo: ${interval.inMinutes} minuto(s)',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            Text(
              'Dias da Semana ativos: ',
              style: textTheme.bodyLarge,
            ),
            if (weekdays != null && weekdays.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: weekdays
                    .map((e) => Text('${e!.name.substring(0, 3)} '))
                    .toList(),
              ),
            ] else
              Text(
                'Nenhum dia da semana selecionado.',
                style: textTheme.bodyLarge,
              ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            Text(
              'Exercícios: ',
              style: textTheme.bodyLarge,
            ),
            if (exercises != null && exercises.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...exercises.map((e) => ExerciseCard(exercise: e))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
