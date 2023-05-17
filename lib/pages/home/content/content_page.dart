import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/pages/home/content/content_card.dart';
import 'package:prev_ler/pages/home/content/register_content_page.dart';
import 'package:prev_ler/service/auth_service.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});

  final _searchController = TextEditingController();

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
      appBar: AppBar(
        toolbarHeight: 90,
        title: CustomTextField(
          margin: const EdgeInsets.symmetric(vertical: 5),
          hintText: "Buscar lesão",
          controller: _searchController,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                if (index == 5) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 80),
                    child: ContentCard(),
                  );
                }
                return const ContentCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
