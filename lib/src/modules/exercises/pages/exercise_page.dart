import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prev_ler/src/modules/exercises/components/exercise_card.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';

import 'package:prev_ler/src/shared/ui/components/auth_medic_add_button.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:prev_ler/src/shared/ui/components/my_search_app_bar.dart';
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

    final exercises = controller.exercises;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
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
              AuthMedicAddButton(onPressed: () {})
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(68),
              child: MySearchBar(
                searchController: _searchController,
                hintText: "Buscar exercício...",
                action: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: const [
                  ExerciseCard(
                    title: 'Jogar de lado',
                    subTitle: 'Com o joelho',
                    imageUrl:
                        'https://img.freepik.com/free-vector/stretching-exercises-concept-illustration_114360-8922.jpg?w=2000',
                  ),
                  ExerciseCard(
                    title: 'Jogar de lado',
                    subTitle: 'Com o joelho',
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGGqVluzAC-edrbajjfEMKiHcp_WypFWRLtw&usqp=CAU',
                  ),
                  ExerciseCard(
                    title: 'Jogar de lado',
                    subTitle: 'Com o joelho',
                    imageUrl:
                        'https://www.realsimple.com/thmb/CqSxk_N2XPv_fJHNXrbP7PIg-vI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/EasyExercises_RS_GluteBridges_Grace-Canaan-0914aa6aa09b41838bd6a2e16e37a8fe.jpg',
                  ),
                  ExerciseCard(
                    title: 'Jogar de lado',
                    subTitle: 'Com o joelho',
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6CZQsPAmGl1L0ohfHlWi6O8y7oetOLHBVlA&usqp=CAU',
                  ),
                  ExerciseCard(
                    title: 'Jogar de lado',
                    subTitle: 'Com o joelho',
                    imageUrl:
                        'https://img.freepik.com/free-vector/stretching-exercises-concept-illustration_114360-8922.jpg?w=2000',
                  ),
                  ExerciseCard(
                    title: 'Jogar de lado',
                    subTitle: 'Com o joelho',
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGGqVluzAC-edrbajjfEMKiHcp_WypFWRLtw&usqp=CAU',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
