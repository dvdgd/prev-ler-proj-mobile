import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/injuries/components/injury_card.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/shared/ui/components/auth_medic_add_button.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/components/sliver_center_text.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class InjuryPage extends StatefulWidget {
  const InjuryPage({super.key});

  @override
  State<InjuryPage> createState() => _InjuryPageState();
}

class _InjuryPageState extends State<InjuryPage> {
  late final InjuriesController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<InjuriesController>();
    controller.addListener(_handleStateChange);
    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchAllInjuries();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_handleStateChange);
  }

  void _handleStateChange() {
    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InjuriesController>();

    final injuries = controller.injuries;
    final state = controller.state;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAllInjuries();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _appBar,
            if (injuries.isEmpty && state != StateEnum.loading)
              const SliverCenterText(
                message: 'Não existem lesões a serem exibidas.',
              ),
            if (injuries.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: injuries.length,
                    itemBuilder: (context, index) =>
                        InjuryCard(injuryType: injuries[index]),
                  )
                ]),
              ),
          ],
        ),
      ),
      bottomNavigationBar:
          state == StateEnum.loading ? const LinearProgressIndicator() : null,
    );
  }

  SliverAppBar get _appBar => SliverAppBar(
        floating: true,
        pinned: true,
        snap: false,
        title: const PageTitle(title: 'Lesões'),
        actions: [
          AuthMedicAddButton(
            onPressed: () =>
                Navigator.of(Routes.navigatorKey.currentContext!).pushNamed(
              '/injuries/register',
            ),
          ),
        ],
      );
}
