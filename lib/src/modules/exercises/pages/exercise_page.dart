import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/exercises/components/exercise_card.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_form_page.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/ui/components/auth_medic_add_button.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/components/sliver_center_text.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_search_app_bar.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final controller = context.read<ExercisesController>();

    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchAll();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExercisesController>();

    final state = controller.state;
    final errorMessage = controller.errorMessage;

    final idMedic = context.read<UserController>().user?.medic?.idMedic;

    final exercises = controller.exercises;
    final userExercises = exercises.where((e) => e.idMedic == idMedic).toList();
    final otherExercises =
        exercises.where((e) => e.idMedic != idMedic).toList();
    final isLoading = state == StateEnum.loading;

    return Scaffold(
      bottomNavigationBar: isLoading ? const LinearProgressIndicator() : null,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAll();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _appBar,
            if (state == StateEnum.error)
              SliverCenterText(message: errorMessage),
            if (exercises.isEmpty)
              const SliverCenterText(
                message: 'Não existem exercícios para serem exibidos.',
              ),
            if (userExercises.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Meus:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                      left: 10,
                    ),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: userExercises
                          .map((e) => ExerciseCard(exercise: e))
                          .toList(),
                    ),
                  ),
                ]),
              ),
            if (otherExercises.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  if (idMedic != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Outros:',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                      left: 10,
                    ),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: otherExercises
                          .map((e) => ExerciseCard(exercise: e))
                          .toList(),
                    ),
                  ),
                ]),
              ),
          ],
        ),
      ),
    );
  }

  SliverAppBar get _appBar => SliverAppBar(
        floating: true,
        pinned: true,
        snap: false,
        title: const PageTitle(title: 'Exercícios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              throw UnimplementedError(
                'Filter button is not implemented yet!',
              );
            },
          ),
          AuthMedicAddButton(onPressed: () {
            Navigator.of(Routes.navigatorKey.currentContext!)
                .push(MaterialPageRoute(
              builder: (context) => const ExerciseFormPage(),
            ));
          })
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: MySearchBar(
            searchController: _searchController,
            hintText: "Buscar exercício...",
            action: () {},
          ),
        ),
      );
}
