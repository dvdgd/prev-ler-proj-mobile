import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_form_page.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/services/file_converter.dart';
import 'package:prev_ler/src/shared/ui/components/crud_options_buttons.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_option_button.dart';
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
  static final FileConverter converter = FileConverter();

  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();
    final medic = userController.user?.medic;

    final image = widget.exercise.image;
    final title = widget.exercise.name;
    final subTitle = widget.exercise.description;

    return SizedBox(
      width: 180,
      child: MyCard(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Theme.of(context).cardColor,
        onTap: () {
          final medicContent = widget.exercise.idMedic == medic?.idMedic;
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.memory(converter.base64Binary(image)),
            ),
            ListTile(
              title: Text(title),
              subtitle: Text(
                subTitle,
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
    Navigator.of(context).pop();
    // TODO: implement exercise read page
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
            Navigator.of(context).pop();
            Navigator.of(context).push(
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
            Navigator.of(context).pop();
            context.read<ExercisesController>().delete(widget.exercise);
          },
          icon: const Icon(Icons.delete_forever_outlined),
        ),
      ];
}
