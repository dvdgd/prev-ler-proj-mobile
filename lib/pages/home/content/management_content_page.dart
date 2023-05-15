import 'package:flutter/material.dart';
import 'package:prev_ler/pages/home/content/card_edit_del_content.dart';
import 'package:prev_ler/pages/home/content/edit_content.dart';
import 'package:prev_ler/pages/home/content/register_content.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

class ManagementContentPage extends StatefulWidget {
  const ManagementContentPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ManagementContentPageState createState() => _ManagementContentPageState();
}

class _ManagementContentPageState extends State<ManagementContentPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Buscar lesão",
                      controller: _searchController,
                      prefixIcon: const Icon(Icons.healing_outlined),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      margin: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        right: 5,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: const Icon(Icons.filter_alt),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditContent(
                              title: 'Editar Conteúdo',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterContentPage(
                              title: 'Cadastrar Conteúdo',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return const CustomCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
