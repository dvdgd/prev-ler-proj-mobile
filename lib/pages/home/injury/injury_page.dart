import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/pages/home/injury/injury_card.dart';
import 'package:prev_ler/pages/home/injury/register_injury.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/widgets/page_title.dart';
import 'package:prev_ler/widgets/search_app_bar.dart';

class InjuryPage extends StatelessWidget {
  InjuryPage({super.key});
  final _searchController = TextEditingController();

  final injuries = [
    InjuryType(
      idMedic: 1,
      name: 'tendinite 1',
      abbreviation: 'tdd',
      description: 'Inflamação dos tendões',
    ),
    InjuryType(
      idMedic: 1,
      name: 'tendinite',
      abbreviation: 'tdd',
      description: 'Inflamação dos tendões',
    ),
    InjuryType(
      idMedic: 1,
      name: 'tendinite',
      abbreviation: 'tdd',
      description: 'Inflamação dos tendões',
    ),
    InjuryType(
      idMedic: 1,
      name: 'tendinite',
      abbreviation: 'tdd',
      description: 'Inflamação dos tendões',
    )
  ];

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
          SliverList(
            delegate: SliverChildListDelegate([
              InjuryCard(injury: injuries[0]),
              InjuryCard(injury: injuries[1]),
              InjuryCard(injury: injuries[2]),
              InjuryCard(injury: injuries[3]),
            ]),
          ),
        ],
      ),
    );
  }
}
