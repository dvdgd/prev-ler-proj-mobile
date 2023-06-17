import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/pages/content_read_page.dart';
import 'package:prev_ler/src/modules/contents/pages/content_register_page.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/ui/components/my_crud_options_buttons.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_card.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_option_button.dart';
import 'package:provider/provider.dart';

class ContentCard extends StatefulWidget {
  const ContentCard({Key? key, required this.content}) : super(key: key);

  final Content content;

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    final userController = context.watch<UserController>();
    final medic = userController.user?.medic;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: CustomCard(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onTap: () {
            final medicContent = widget.content.idMedic == medic?.idMedic;
            if (medic == null || !medicContent) {
              return _navigateToContentRead();
            }

            if (medicContent) {
              return _showOptions();
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.content.title,
                  style: const TextStyle(fontSize: 16, height: 1),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 7),
                Text(
                  widget.content.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Enfermidade: ${widget.content.injuryType?.name ?? 'Não informada'}',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToContentRead() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ContentRead(widget.content),
    ));
  }

  void _showOptions() {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      builder: (context) {
        return MyCrudOptionsButtons(options: optionsButtons);
      },
    );
  }

  get optionsButtons => [
        MyOptionButton(
          title: 'Visualizar',
          pressedFunction: () {
            Navigator.of(context).pop();
            _navigateToContentRead();
          },
          icon: const Icon(Icons.remove_red_eye_outlined),
        ),
        MyOptionButton(
          title: 'Editar',
          pressedFunction: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RegisterContentPage(
                  title: 'Editar Conteúdo',
                  content: widget.content,
                ),
              ),
            );
          },
          icon: const Icon(Icons.edit_outlined),
        ),
        MyOptionButton(
          title: 'Deletar',
          pressedFunction: () {
            context.read<ContentsController>().deleteContent(widget.content);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.delete_forever_outlined),
        ),
      ];
}
