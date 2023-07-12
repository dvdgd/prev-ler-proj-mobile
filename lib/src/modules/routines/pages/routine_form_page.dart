import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prev_ler/src/modules/routines/components/select_exercise.dart';
import 'package:prev_ler/src/modules/routines/components/week_day_picker.dart';
import 'package:prev_ler/src/modules/routines/shared/exercise_cart_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/week_day_controller.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_hour_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';

class RoutineFormPage extends StatefulWidget {
  const RoutineFormPage({
    super.key,
    required this.title,
    this.routine,
  });

  final String title;
  final Routine? routine;

  @override
  State<RoutineFormPage> createState() => _RoutineFormPageState();
}

class _RoutineFormPageState extends State<RoutineFormPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    context.read<ExerciseCartController>().clearAll();
    context.watch<WeekDayController>().disableAll();
    super.dispose();
  }

  Widget get divider => const Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
        child: Divider(),
      );

  Widget leftAlignWithPadding({required Widget child}) => Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final exercisesCartController = context.watch<ExerciseCartController>();
    final exercises = exercisesCartController.value;

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(title: widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const MyTextFormField(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.title),
              ),
              const MyTextFormField(
                labelText: 'Descrição',
                prefixIcon: Icon(Icons.description),
                maxLines: 10,
                maxLength: 300,
              ),
              divider,
              leftAlignWithPadding(
                child: Text(
                  'Dias da rotina ativa.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: MyDayOfWeekPicker(),
              ),
              divider,
              leftAlignWithPadding(
                child: Text(
                  style: Theme.of(context).textTheme.titleMedium,
                  'Selecione um exercício.',
                ),
              ),
              if (exercises.isNotEmpty)
                ...exercises
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SelectExercise(exercise: e),
                        ))
                    .toList(),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: FilledButton.tonalIcon(
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/routines/cart/exercises',
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar'),
                  ),
                ),
              ),
              divider,
              const SizedBox(height: 15),
              MyHourPicker(
                selectedTime: ValueNotifier(TimeOfDay.now()),
                labelText: 'Horario de inicío',
                prefixIcon: const Icon(Icons.alarm_on),
              ),
              MyHourPicker(
                selectedTime: ValueNotifier(TimeOfDay.now()),
                labelText: 'Horario de fim',
                prefixIcon: const Icon(Icons.alarm_off),
              ),
              MyTextFormField(
                labelText: 'Intervalo em minutos',
                prefixIcon: const Icon(Icons.alarm_off),
                controller: TextEditingController(),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Campo obrigatório.';
                  }

                  if (int.tryParse(text) == null) {
                    return 'O intervalo deve ser um numérico';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 40),
              MyFilledLoadingButton(
                text: 'Salvar',
                action: () async {},
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
