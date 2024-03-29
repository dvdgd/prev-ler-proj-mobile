import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_details_page.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_form_page.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/ui/components/crud_options_buttons.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_option_button.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';
import 'package:provider/provider.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();
    final medic = userController.user;

    final title = widget.exercise.name;
    final description = widget.exercise.description;

    final imageBytes = MyConverter.base64Binary(widget.exercise.image);

    return SizedBox(
      width: 180,
      child: MyCard(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Theme.of(context).cardColor,
        onTap: () {
          final medicContent = widget.exercise.userId == medic?.userId;
          if (medic == null || !medicContent) {
            return _navigateToExerciseReadPage();
          }

          if (medicContent) {
            return _showOptions();
          }
        },
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: 80,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.memory(imageBytes),
            ),
            ListTile(
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptions() {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      builder: (context) {
        return CrudOptionsButtons(options: optionsButtons);
      },
    );
  }

  void _navigateToExerciseReadPage() {
    Navigator.of(Routes.navigatorKey.currentContext!).pop();
    Navigator.of(Routes.navigatorKey.currentContext!).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ExerciseDetailsPage(
          exercise: widget.exercise,
        ),
      ),
    );
  }

  get optionsButtons => [
        MyOptionButton(
          title: 'Visualizar',
          pressedFunction: _navigateToExerciseReadPage,
          icon: const Icon(Icons.remove_red_eye_outlined),
        ),
        MyOptionButton(
          title: 'Editar',
          pressedFunction: () {
            Navigator.of(Routes.navigatorKey.currentContext!).pop();
            Navigator.of(Routes.navigatorKey.currentContext!).push(
              MaterialPageRoute(
                builder: (_) => ExerciseFormPage(
                  exercise: widget.exercise,
                ),
              ),
            );
          },
          icon: const Icon(Icons.edit_outlined),
        ),
        MyOptionButton(
          title: 'Deletar',
          pressedFunction: () {
            Navigator.of(Routes.navigatorKey.currentContext!).pop();
            context.read<ExercisesController>().delete(widget.exercise);
          },
          icon: const Icon(Icons.delete_forever_outlined),
        ),
      ];
}
