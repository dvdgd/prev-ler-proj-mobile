import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:provider/provider.dart';

class UserHello extends StatefulWidget {
  const UserHello({super.key});

  @override
  State<UserHello> createState() => _UserHelloState();
}

class _UserHelloState extends State<UserHello> {
  @override
  void initState() {
    super.initState();

    final controller = context.read<UserController>();
    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchUser();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();

    final name = controller.user?.name;
    final textName = name?.split(' ')[0] ?? '';

    return PageTitle(
      title: textName.isNotEmpty ? 'Olá, $textName!' : 'Loading...',
    );
  }
}
