import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/injuries/components/injury_card.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/ui/components/auth_medic_add_button.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:prev_ler/src/shared/ui/components/my_search_app_bar.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class InjuryPage extends StatefulWidget {
  const InjuryPage({super.key});

  @override
  State<InjuryPage> createState() => _InjuryPageState();
}

class _InjuryPageState extends State<InjuryPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final controller = context.read<InjuriesController>();
    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchAllInjuries();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InjuriesController>();
    final idMedic = context.read<UserController>().user?.medic?.idMedic;

    final injuries = controller.injuries;
    final userInjuries = injuries.where((i) => i.idMedic == idMedic).toList();
    final otherInjuries = injuries.where((i) => i.idMedic != idMedic).toList();

    final state = controller.state;
    final errorMessage = controller.errorMessage;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAllInjuries();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _appBar,
            if (state == StateEnum.error)
              SliverFillRemaining(
                child: Center(child: Text(errorMessage)),
              ),
            if (injuries.isEmpty)
              const SliverFillRemaining(
                child: Center(
                    child: Text('Não existem conteúdos a serem exibidos.')),
              ),
            if (userInjuries.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Minhas Lesões',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userInjuries.length,
                    itemBuilder: (context, index) =>
                        InjuryCard(injuryType: userInjuries[index]),
                  )
                ]),
              ),
            if (otherInjuries.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  if (idMedic != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Outras Lesões',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: otherInjuries.length,
                    itemBuilder: (context, index) =>
                        InjuryCard(injuryType: otherInjuries[index]),
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
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              throw UnimplementedError(
                'Filter button is not implemented yet!',
              );
            },
          ),
          AuthMedicAddButton(
            onPressed: () => Navigator.of(context).pushNamed(
              '/injuries/register',
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: MySearchBar(
            action: () {},
            hintText: "Buscar lesão",
            searchController: _searchController,
          ),
        ),
      );
}
