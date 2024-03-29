import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/contents/pages/content_datails_page.dart';
import 'package:prev_ler/src/modules/contents/pages/content_form_page.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/ui/components/crud_options_buttons.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_option_button.dart';
import 'package:prev_ler/src/shared/utils/check_user_permission.dart';
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
    final medic = userController.user;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: MyCard(
          padding: const EdgeInsets.all(20),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onTap: () {
            final ableToEdit =
                returnTrueIfUserCouldCreateContents(userController.user);

            if (medic == null || !ableToEdit) {
              return _navigateToContentRead();
            }

            return _showOptions();
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToContentRead() {
    Navigator.of(Routes.navigatorKey.currentContext!).push(MaterialPageRoute(
      builder: (_) => ContentDetailsPage(widget.content),
    ));
  }

  void _showOptions() {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      builder: (context) {
        return CrudOptionsButtons(options: optionsButtons);
      },
    );
  }

  get optionsButtons => [
        MyOptionButton(
          title: 'Visualizar',
          pressedFunction: () {
            Navigator.of(Routes.navigatorKey.currentContext!).pop();
            _navigateToContentRead();
          },
          icon: const Icon(Icons.remove_red_eye_outlined),
        ),
        MyOptionButton(
          title: 'Editar',
          pressedFunction: () {
            Navigator.of(Routes.navigatorKey.currentContext!).pop();
            Navigator.of(Routes.navigatorKey.currentContext!).push(
              MaterialPageRoute(
                builder: (_) => ContentFormPage(
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
            Navigator.of(Routes.navigatorKey.currentContext!).pop();
          },
          icon: const Icon(Icons.delete_forever_outlined),
        ),
      ];
}
