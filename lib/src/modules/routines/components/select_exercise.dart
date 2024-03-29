import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_details_page.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/exercise_cart_controller.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';
import 'package:provider/provider.dart';

class SelectExercise extends StatelessWidget {
  const SelectExercise({
    super.key,
    required this.exercise,
    this.showAction,
  });

  final Exercise exercise;
  final bool? showAction;
  static final converter = MyConverter();

  @override
  Widget build(BuildContext context) {
    final imageBytes = MyConverter.base64Binary(exercise.image);
    final controller = context.watch<ExerciseCartController>();

    final isSelected = controller.exercises.contains(exercise);
    final colorScheme = Theme.of(context).colorScheme;

    final backgroudColor = isSelected ? colorScheme.tertiaryContainer : null;
    final imageBackgroudColor = isSelected
        ? colorScheme.tertiary.withOpacity(0.4)
        : colorScheme.secondary.withOpacity(0.2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: MyCard(
        onTap: () {
          Navigator.of(Routes.navigatorKey.currentContext!).push(
            MaterialPageRoute(
              builder: (ctx) => ExerciseDetailsPage(exercise: exercise),
            ),
          );
        },
        backgroundColor: backgroudColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 60,
                width: 80,
                decoration: BoxDecoration(
                  color: imageBackgroudColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.memory(
                  imageBytes,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                    Text(
                      exercise.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ),
            isSelected
                ? IconButton(
                    onPressed: () => controller.remove(exercise),
                    icon: const Icon(Icons.remove),
                  )
                : IconButton(
                    onPressed: () => controller.add(exercise),
                    icon: const Icon(Icons.add),
                  ),
          ],
        ),
      ),
    );
  }
}
