import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/routines/pages/routine_details_page.dart';
import 'package:prev_ler/src/modules/routines/pages/routine_form_page.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/routines_controller.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/crud_options_buttons.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_option_button.dart';
import 'package:provider/provider.dart';

class RoutineCard extends StatefulWidget {
  const RoutineCard({super.key, required this.routine});

  final Routine routine;

  @override
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  late Routine routine;

  @override
  void initState() {
    routine = widget.routine.copyWith();
    super.initState();
  }

  Future<void> _handleToggleRoutine(bool value) async {
    final newRoutine = routine.copyWith(active: value);
    await context.read<RoutinesController>().toggleRoutine(newRoutine);
    setState(() => routine = newRoutine);
    if (mounted) {
      final activeStr = newRoutine.active ? 'Ativada' : 'Desativada';
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rotina ${routine.title} $activeStr.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final qtdExercises = widget.routine.exercises?.length ?? 0;
    final qtdExercisesSubtitle = qtdExercises > 1 ? 'Exercícios' : 'Exercício';
    String activeWeekDays = ' ';
    final weekdays = routine.weekdays;
    if (weekdays != null && weekdays.isNotEmpty) {
      for (var day in weekdays) {
        if (day == null) continue;
        activeWeekDays += '${day.name.substring(0, 3)} ';
      }
    }
    return MyCard(
      backgroundColor: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(20),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => CrudOptionsButtons(options: [
            MyOptionButton(
              title: 'Visualizar',
              icon: const Icon(Icons.remove_red_eye_outlined),
              pressedFunction: () {
                Navigator.of(Routes.navigatorKey.currentContext!).pop();
                Navigator.of(Routes.navigatorKey.currentContext!)
                    .push(MaterialPageRoute(
                  builder: (context) => RoutineDetailsPage(
                    routine: routine,
                  ),
                ));
              },
            ),
            MyOptionButton(
              title: 'Editar',
              icon: const Icon(Icons.edit_outlined),
              pressedFunction: () {
                final currentContext = Routes.navigatorKey.currentContext!;
                Navigator.of(currentContext).pop();
                Navigator.of(currentContext).push(MaterialPageRoute(
                  builder: (context) => RoutineFormPage(
                    routine: routine,
                    title: 'Editar',
                  ),
                ));
              },
            ),
            MyOptionButton(
              title: 'Deletar',
              icon: const Icon(Icons.delete_forever_outlined),
              pressedFunction: () {
                Navigator.of(Routes.navigatorKey.currentContext!).pop();
                context.read<RoutinesController>().delete(widget.routine);
              },
            ),
          ]),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  widget.routine.exercises?.length.toString() ?? '0',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  qtdExercisesSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.routine.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 4),
                Text(
                  activeWeekDays,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Switch(
              value: routine.active,
              onChanged: _handleToggleRoutine,
            ),
          ),
        ],
      ),
    );
  }
}
