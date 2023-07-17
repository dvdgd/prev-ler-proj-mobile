import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/routines/components/select_exercise.dart';
import 'package:prev_ler/src/modules/routines/components/week_day_picker.dart';
import 'package:prev_ler/src/modules/routines/shared/exercise_cart_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/routine_create_model.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/week_day_controller.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_hour_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
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

  late final ExerciseCartController _exerciseCartController;
  late final WeekDayController _weekDayController;
  late final RoutinesController _routinesController;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();

  final _startTime = ValueNotifier(TimeOfDay.now());
  final _endTime = ValueNotifier(TimeOfDay.now());

  @override
  void dispose() {
    _exerciseCartController.clearAll();
    _weekDayController.disableAll();
    super.dispose();
  }

  @override
  void initState() {
    _exerciseCartController = context.read<ExerciseCartController>();
    _weekDayController = context.read<WeekDayController>();

    _routinesController = context.read<RoutinesController>();
    _routinesController.addListener(_handleStateChange);
    super.initState();
  }

  _handleStateChange() {
    if (_routinesController.state == StateEnum.success) {
      Navigator.of(Routes.navigatorKey.currentContext!).pop();
    }
    if (_routinesController.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_routinesController.errorMessage),
          action: SnackBarAction(
            label: 'Fechar',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
    }
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

  RoutineCreateModel _getRoutineCreateModel() {
    final exercises = _exerciseCartController.value;
    final selectedDays = _weekDayController.selectedDays;

    final minutes = int.parse(_durationController.text);
    final duration = Duration(minutes: minutes);

    return RoutineCreateModel(
      patientId: 0,
      title: _titleController.text,
      description: _descriptionController.text,
      startTime: _startTime.value,
      endTime: _endTime.value,
      duration: duration,
      active: true,
      exercises: exercises,
      selectedDays: selectedDays,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routineController = context.read<RoutinesController>();
    final exercisesCartController = context.watch<ExerciseCartController>();
    final selectedDays = context.watch<WeekDayController>().selectedDays;
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
              MyTextFormField(
                validator: (text) =>
                    text == null || text.isEmpty ? 'Campo obrigatório.' : null,
                controller: _titleController,
                labelText: 'Nome',
                prefixIcon: const Icon(Icons.title),
              ),
              MyTextFormField(
                validator: (text) =>
                    text == null || text.isEmpty ? 'Campo obrigatório.' : null,
                controller: _descriptionController,
                labelText: 'Descrição',
                prefixIcon: const Icon(Icons.description),
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
                    onPressed: () =>
                        Navigator.of(Routes.navigatorKey.currentContext!)
                            .pushNamed(
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
                selectedTime: _startTime,
                labelText: 'Horario de inicío',
                prefixIcon: const Icon(Icons.alarm_on),
                validator: (text) =>
                    text == null || text.isEmpty ? 'Campo obrigatório.' : null,
              ),
              MyHourPicker(
                selectedTime: _endTime,
                labelText: 'Horario de fim',
                prefixIcon: const Icon(Icons.alarm_off),
                validator: (text) =>
                    text == null || text.isEmpty ? 'Campo obrigatório.' : null,
              ),
              MyTextFormField(
                labelText: 'Intervalo em minutos',
                prefixIcon: const Icon(Icons.alarm_off),
                controller: _durationController,
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
                action: () async {
                  final validForm = _formKey.currentState?.validate();
                  if (validForm == null || !validForm) {
                    return;
                  }

                  final someActive =
                      selectedDays.where((e) => e == true).toList();
                  if (exercises.isEmpty || someActive.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Selecione no mínimo um exercicio e um dia da semana!',
                        ),
                      ),
                    );

                    return;
                  }

                  await routineController.create(_getRoutineCreateModel());
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
