import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/my_crud_options_buttons.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_card.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_option_button.dart';

class RoutineCard extends StatefulWidget {
  const RoutineCard({super.key, required this.routine});

  final Routine routine;

  @override
  State<RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  late bool routineActive;
  late final String activeWeekDays;
  late final int qtdExercises;

  @override
  void initState() {
    super.initState();
    routineActive = widget.routine.active;

    final activesDayOfWeekStr = widget.routine.weekdays
        ?.map((wd) => wd.name.substring(0, 3))
        .reduce((value, element) => '$value | $element');

    activeWeekDays = activesDayOfWeekStr ?? '';
    qtdExercises = widget.routine.exercises?.length ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: Theme.of(context).cardColor,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => MyCrudOptionsButtons(options: [
            MyOptionButton(
              title: 'Visualizar',
              icon: const Icon(Icons.remove_red_eye_outlined),
              pressedFunction: () {},
            ),
            MyOptionButton(
              title: 'Editar',
              icon: const Icon(Icons.edit_outlined),
              pressedFunction: () {},
            ),
            MyOptionButton(
              title: 'Deletar',
              icon: const Icon(Icons.delete_outline),
              pressedFunction: () {},
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
            child: _exercicesColumn,
          ),
          Expanded(
            flex: 2,
            child: _titleColumn,
          ),
          Expanded(
            flex: 1,
            child: Switch(
              value: routineActive,
              onChanged: (value) {
                setState(() => routineActive = value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Column get _titleColumn => Column(
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
      );

  Column get _exercicesColumn {
    return Column(
      children: [
        Text(
          widget.routine.exercises?.length.toString() ?? '0',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          qtdExercises > 1 ? 'Exercícios' : 'Exercício',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
