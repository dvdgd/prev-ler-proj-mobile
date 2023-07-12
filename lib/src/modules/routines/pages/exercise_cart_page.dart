import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/modules/routines/components/select_exercise.dart';
import 'package:prev_ler/src/modules/routines/shared/exercise_cart_controller.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ExerciseCartPage extends StatelessWidget {
  const ExerciseCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExercisesController>();
    final selectedExercises = context.watch<ExerciseCartController>().value;
    final exercises = controller.exercises;

    controller.exercises.sort((a, b) {
      if (selectedExercises.contains(a) && !selectedExercises.contains(b)) {
        return -1;
      }
      if (!selectedExercises.contains(a) && selectedExercises.contains(b)) {
        return 1;
      }
      return a.name.compareTo(b.name);
    });

    if (controller.state == StateEnum.idle) {
      controller.fetchAll();
    }

    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Selecionar exercícios'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pop(),
        label: const Text('OK'),
        icon: const Icon(Icons.done),
      ),
      body: Column(
        children: [
          if (exercises.isEmpty)
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Desculpe, não foram encontrados exercícios. Tente novamente mais tarde.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return SelectExercise(exercise: exercises[index]);
                },
              ),
            ),
        ],
      ),
    );
  }
}
