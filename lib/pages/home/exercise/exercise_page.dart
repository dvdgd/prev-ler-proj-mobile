import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prev_ler/pages/home/exercise/exercise_card.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/widgets/page_title.dart';
import 'package:prev_ler/widgets/search_app_bar.dart';

class ExercisePage extends StatelessWidget {
  ExercisePage({
    super.key,
  });

  final _searchController = TextEditingController();

  IconButton _buildAddButton() {
    return IconButton(
      onPressed: () {
        throw UnimplementedError(
          'Register Exercises Page is not implemented yet!',
        );
      },
      icon: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Consumer(
                builder: (context, ref, child) {
                  final data = ref.watch(authDataProvider);
                  return data.when(
                    data: (user) => user.medic != null
                        ? _buildAddButton()
                        : const SizedBox.shrink(),
                    error: (_, __) => const Text("Error"),
                    loading: () => const CircularProgressIndicator(),
                  );
                },
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(68),
              child: SearchBar(
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
