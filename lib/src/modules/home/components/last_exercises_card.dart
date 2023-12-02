import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_details_page.dart';
import 'package:prev_ler/src/modules/home/shared/lasts_exercises_controller.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class LastsExercisesCard extends StatefulWidget {
  const LastsExercisesCard({super.key});

  @override
  State<LastsExercisesCard> createState() => _LastsExercisesCardState();
}

class _LastsExercisesCardState extends State<LastsExercisesCard> {
  @override
  void initState() {
    super.initState();

    final controller = context.read<LastsExercisesController>();

    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchLastsExercises();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LastsExercisesController>();

    final exercises = controller.exercises;
    final state = controller.state;

    return MyCard(
      padding: const EdgeInsets.all(20),
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Últimos Exercícios!',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
            if (state == StateEnum.loading)
              Padding(
                padding: const EdgeInsets.all(90),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ),
            if (state == StateEnum.error)
              const SizedBox(
                child: Text('teste de erro'),
              ),
            if (exercises.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Não existem exercícios cadastrados.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ),
            if (exercises.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return ListTile(
                    iconColor: Theme.of(context).colorScheme.onTertiary,
                    textColor: Theme.of(context).colorScheme.onTertiary,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(exercise.name),
                    subtitle: Text(
                      exercise.description,
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.keyboard_double_arrow_right_sharp),
                      onPressed: () {
                        Navigator.of(Routes.navigatorKey.currentContext!).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ExerciseDetailsPage(
                              exercise: exercise,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: exercises.length,
              ),
          ],
        ),
      ),
    );
  }
}
