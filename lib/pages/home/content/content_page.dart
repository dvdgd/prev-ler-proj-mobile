import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/pages/home/content/content_card.dart';
import 'package:prev_ler/pages/home/content/register_content_page.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/widgets/page_title.dart';
import 'package:prev_ler/widgets/search_app_bar.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});

  final _searchController = TextEditingController();

  _buildAddButton(BuildContext context, int idMedic) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterContentPage(
              idMedic: idMedic,
              title: 'Cadastrar Conteúdo',
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
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final data = ref.watch(authDataProvider);
          return data.when(
            data: (user) {
              if (user.medic != null) {
                return FloatingActionButton.extended(
                  label: const Text('Adicionar'),
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterContentPage(
                        idMedic: user.medic!.idMedic!,
                        title: 'Cadastrar Conteúdo',
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            error: (_, __) => const Text("Error"),
            loading: () => const CircularProgressIndicator(),
          );
        },
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            title: const PageTitle(title: 'Conteúdos'),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_alt),
                onPressed: () {},
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
                hintText: "Buscar lesão",
                searchController: _searchController,
                action: () {},
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(const [
              ContentCard(),
              ContentCard(),
              ContentCard(),
              ContentCard(),
              ContentCard(),
            ]),
          ),
        ],
      ),
    );
  }
}
