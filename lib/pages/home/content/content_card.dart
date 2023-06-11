import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/entities/content.dart';
import 'package:prev_ler/pages/home/content/read_content_page.dart';
import 'package:prev_ler/pages/home/content/edit_content_page.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/services/content_service.dart';
import 'package:prev_ler/widgets/custom_card.dart';
import 'package:prev_ler/widgets/custom_option_button.dart';

class ContentCard extends ConsumerWidget {
  const ContentCard({Key? key, required this.content}) : super(key: key);

  final Content content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authDataProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: CustomCard(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onTap: () {
            authData.when(
              data: (user) =>
                  user.medic != null && content.idMedic == user.medic!.idMedic!
                      ? _showOptions(context, ref, user.medic!.idMedic!)
                      : _navigateToContentRead(context),
              error: (_, __) => const Text("Error"),
              loading: () => const CircularProgressIndicator(),
            );
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content.title,
                  style: const TextStyle(fontSize: 16, height: 1),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 7),
                Text(
                  content.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Enfermidade: ${content.injuryType?.name ?? 'Não informada'}',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, ref, int idMedic) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OptionButton(
                    title: 'Visualizar',
                    pressedFunction: () {
                      Navigator.of(context).pop();
                      _navigateToContentRead(context);
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  OptionButton(
                    title: 'Editar',
                    pressedFunction: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditContentPage(
                            idMedic: idMedic,
                            title: 'Editar Conteúdo',
                            content: content,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  OptionButton(
                    title: 'Deletar',
                    pressedFunction: () {
                      Navigator.of(context).pop();
                      final contentServiceProvider = ref.read(contentProvider);
                      contentServiceProvider.delete(content.idContent);
                    },
                    icon: const Icon(Icons.delete_forever_outlined),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _navigateToContentRead(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentRead(content),
      ),
    );
  }
}
