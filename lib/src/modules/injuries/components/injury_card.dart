import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/injuries/pages/injury_read_page.dart';
import 'package:prev_ler/src/modules/injuries/pages/register_injury.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/ui/components/crud_options_buttons.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_option_button.dart';
import 'package:provider/provider.dart';

class InjuryCard extends StatefulWidget {
  const InjuryCard({Key? key, required this.injuryType}) : super(key: key);

  final InjuryType injuryType;

  @override
  State<InjuryCard> createState() => _InjuryCardState();
}

class _InjuryCardState extends State<InjuryCard> {
  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();
    final medic = userController.user?.medic;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: MyCard(
          padding: const EdgeInsets.all(0),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onTap: () {
            final medicContent = widget.injuryType.idMedic == medic?.idMedic;
            if (medic == null || !medicContent) {
              return _navigateToInjuryDetailsPage();
            }

            if (medicContent) {
              return _showOptions();
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(widget.injuryType.name),
                  subtitle: Text('Sigla: ${widget.injuryType.abbreviation}'),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: Text(
                    widget.injuryType.description,
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

  void _navigateToInjuryDetailsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InjuryRead(widget.injuryType),
      ),
    );
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      builder: (context) {
        return CrudOptionsButtons(options: optionsButtons);
      },
    );
  }

  List<Widget> get optionsButtons => [
        MyOptionButton(
          title: 'Visualizar',
          pressedFunction: () {
            Navigator.of(context).pop();
            _navigateToInjuryDetailsPage();
          },
          icon: const Icon(Icons.remove_red_eye_outlined),
        ),
        MyOptionButton(
          title: 'Editar',
          pressedFunction: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => RegisterInjury(
                title: 'Editar Lesão',
                injury: widget.injuryType,
              ),
            ));
          },
          icon: const Icon(Icons.edit_outlined),
        ),
        MyOptionButton(
          title: 'Deletar',
          pressedFunction: () {
            Navigator.of(context).pop();
            context
                .read<InjuriesController>()
                .deleteInjuryType(widget.injuryType);
          },
          icon: const Icon(Icons.delete_forever_outlined),
        ),
      ];
}
