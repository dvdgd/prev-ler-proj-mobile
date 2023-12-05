import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/routines/components/select_exercise.dart';
import 'package:prev_ler/src/modules/routines/components/week_day_legend.dart';
import 'package:prev_ler/src/modules/routines/components/week_day_picker.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/exercise_cart_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/routines_controller.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/week_day_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/routine_create_model.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_hour_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:prev_ler/src/shared/utils/gen_select_days_list.dart';
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

  late final User user;

  @override
  void initState() {
    _exerciseCartController = context.read<ExerciseCartController>();
    _weekDayController = context.read<WeekDayController>();

    final user = context.read<UserController>().user;
    if (user == null) {
      Navigator.of(Routes.navigatorKey.currentContext!)
          .pushReplacementNamed('/');
    } else {
      this.user = user;
    }

    _routinesController = context.read<RoutinesController>();
    _routinesController.addListener(_handleStateChange);

    _serializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    _exerciseCartController.clearAll();
    _weekDayController.disableAll();
    _routinesController.removeListener(_handleStateChange);
    super.dispose();
  }

  _handleStateChange() {
    if (_routinesController.state == StateEnum.success) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sucesso!')),
      );
      Navigator.of(Routes.navigatorKey.currentContext!).pop();
    }
    if (_routinesController.state == StateEnum.error) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(Routes.navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(_routinesController.errorMessage),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  _serializeControllers() {
    final routine = widget.routine;
    if (routine == null) return;

    _titleController.text = routine.title;
    _descriptionController.text = routine.description;
    _durationController.text = routine.duration.inMinutes.toString();

    final selectedList = generateSelectedDaysFromRoutine(routine);
    _weekDayController.fromList(selectedList);

    routine.exercises?.forEach((exercise) {
      _exerciseCartController.add(exercise);
    });

    _startTime.value = routine.startTime;
    _endTime.value = routine.endTime;
  }

  Future<void> _handleFormSubmit() async {
    final validForm = _formKey.currentState?.validate();
    if (validForm == null || !validForm) {
      return;
    }

    final selectedDays = _weekDayController.selectedDays;
    final exercises = _exerciseCartController.exercises;

    final someActive = selectedDays.where((e) => e == true).toList();
    if (exercises.isEmpty || someActive.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione no mínimo um exercicio e um dia da semana!',
          ),
        ),
      );

      return;
    }

    if (widget.routine != null) {
      return _routinesController.update(_getRoutineCreateModel());
    }
    await _routinesController.create(_getRoutineCreateModel());
  }

  RoutineCreateModel _getRoutineCreateModel() {
    final exercises = _exerciseCartController.exercises;
    final selectedDays = _weekDayController.selectedDays;

    final minutes = int.parse(_durationController.text);
    final duration = Duration(minutes: minutes);

    return RoutineCreateModel(
      routineId: widget.routine?.routineId ?? 0,
      userId: user.userId,
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
    final exercises = context.watch<ExerciseCartController>().exercises;

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
                labelText: 'Nome*',
                prefixIcon: const Icon(Icons.title),
              ),
              MyTextFormField(
                validator: (text) =>
                    text == null || text.isEmpty ? 'Campo obrigatório.' : null,
                controller: _descriptionController,
                labelText: 'Descrição*',
                prefixIcon: const Icon(Icons.description),
                maxLines: 10,
                maxLength: 300,
              ),
              divider,
              leftAlignWithPadding(
                child: Text(
                  'Dias da rotina ativa*',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              leftAlignWithPadding(
                child: const WeekdayLegend(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: MyDayOfWeekPicker(),
              ),
              divider,
              leftAlignWithPadding(
                child: Text(
                  style: Theme.of(context).textTheme.titleMedium,
                  'Selecione um exercício*',
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
                labelText: 'Horario de inicío*',
                prefixIcon: const Icon(Icons.alarm_on),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Campo obrigatório.';
                  }

                  final startTime = _startTime.value;
                  if (startTime.hour == 0) {
                    return 'Horário não permitido';
                  }
                  return null;
                },
              ),
              MyHourPicker(
                selectedTime: _endTime,
                labelText: 'Horario de fim*',
                prefixIcon: const Icon(Icons.alarm_off),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Campo obrigatório.';
                  }

                  final endTime = _endTime.value;
                  final startTime = _startTime.value;
                  if (endTime == startTime) {
                    return 'Os horários não podem ser iguais.';
                  }

                  final isEqualHours = endTime.hour == startTime.hour;
                  final isMinuteBefore = startTime.minute > endTime.minute;

                  if (endTime.hour < startTime.hour ||
                      (isEqualHours && isMinuteBefore)) {
                    return 'Selecione um horário maior que o de início.';
                  }

                  return null;
                },
              ),
              MyTextFormField(
                labelText: 'Intervalo em minutos*',
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
                action: _handleFormSubmit,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
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
}
