import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/services/injury_service.dart';
import 'package:prev_ler/widgets/custom_card.dart';
import 'package:prev_ler/widgets/custom_option_button.dart';

class InjuryCard extends ConsumerWidget {
  const InjuryCard({Key? key, required this.injuryType}) : super(key: key);

  final InjuryType injuryType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authDataProvider);

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: CustomCard(
          padding: const EdgeInsets.all(0),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onTap: () {
            authData.when(
              data: (user) => user.medic != null
                  ? _showOptions(context, ref)
                  : const SizedBox.shrink(),
              error: (_, __) => const Text("Error"),
              loading: () => const CircularProgressIndicator(),
            );
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(injuryType.name),
                  subtitle: Text('Sigla: ${injuryType.abbreviation}'),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: Text(
                    injuryType.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, WidgetRef ref) {
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
                    title: 'Editar',
                    pressedFunction: () {},
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  OptionButton(
                    title: 'Deletar',
                    pressedFunction: () {
                      Navigator.of(context).pop();
                      final injuryTypeServiceProvider =
                          ref.read(injuryProvider);
                      injuryTypeServiceProvider
                          .deleteById(injuryType.idInjuryType);
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
}
