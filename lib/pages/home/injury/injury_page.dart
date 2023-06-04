import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/pages/home/injury/injury_card.dart';
import 'package:prev_ler/pages/home/injury/register_injury.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/services/injury_service.dart';
import 'package:prev_ler/widgets/page_title.dart';
import 'package:prev_ler/widgets/search_app_bar.dart';

class InjuryPage extends StatelessWidget {
  InjuryPage({super.key});
  final _searchController = TextEditingController();

  _buildAddButton(BuildContext context, int idMedic) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterInjury(
              idMedic: idMedic,
              title: 'Cadastrar Lesão',
            ),
          ),
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
            title: const PageTitle(title: 'Lesões'),
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
                        ? _buildAddButton(context, user.medic!.idMedic!)
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
                action: () {},
                hintText: "Buscar lesão",
                searchController: _searchController,
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final data = ref.watch(injuryDataProvider);
              return data.when(
                data: (injuries) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InjuryCard(injuryType: injuries[index]);
                      },
                      childCount: injuries.length,
                    ),
                  );
                },
                error: (_, __) =>
                    const SliverToBoxAdapter(child: Text("Error")),
                loading: () => const SliverToBoxAdapter(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
