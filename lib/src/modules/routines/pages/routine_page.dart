import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/routines/components/routine_card.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_controller.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/components/sliver_center_text.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_silver_page_app_bar.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class RoutinesPage extends StatefulWidget {
  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  late final RoutinesController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<RoutinesController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchAll();
    });
    controller.addListener(_handleChangeState);
  }

  @override
  void dispose() {
    controller.removeListener(_handleChangeState);
    super.dispose();
  }

  _handleChangeState() {
    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutinesController>();
    final routines = controller.routines;
    final state = controller.state;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAll();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _appBar,
            if (routines.isEmpty && state != StateEnum.loading)
              const SliverCenterText(
                message: 'Não existem rotinas para serem exibidas.',
              ),
            if (routines.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: routines.length,
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: RoutineCard(routine: routines[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar:
          state == StateEnum.loading ? const LinearProgressIndicator() : null,
    );
  }

  SliverPageSearchAppBar get _appBar => SliverPageSearchAppBar(
        title: const PageTitle(title: 'Rotinas'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(Routes.navigatorKey.currentContext!).pushNamed(
              '/routines/register',
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      );
}
