import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/components/content_card.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/ui/components/auth_medic_add_button.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_loading_sliver.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_search_app_bar.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_silver_page_app_bar.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ContentsPage extends StatefulWidget {
  const ContentsPage({super.key});

  @override
  State<ContentsPage> createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> {
  @override
  void initState() {
    super.initState();

    final controller = context.read<ContentsController>();
    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchAllContents();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ContentsController>();
    final idMedic = context.read<UserController>().user?.medic?.idMedic;

    final contents = controller.contents;
    final userContents = contents.where((c) => c.idMedic == idMedic).toList();
    final otherContents = contents.where((c) => c.idMedic != idMedic).toList();

    final state = controller.state;
    final errorMessage = controller.errorMessage;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchAllContents(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _appBar,
            if (state == StateEnum.loading) const MyLoadingSliver(),
            if (state == StateEnum.error)
              SliverFillRemaining(
                child: Center(child: Text(errorMessage)),
              )
            else if (contents.isEmpty)
              _noContentsSliver,
            if (userContents.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Meus: ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userContents.length,
                    itemBuilder: (context, index) => ContentCard(
                      content: userContents[index],
                    ),
                  ),
                ]),
              ),
            if (otherContents.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  if (idMedic != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Outros: ',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: otherContents.length,
                    itemBuilder: (context, index) => ContentCard(
                      content: otherContents[index],
                    ),
                  )
                ]),
              )
          ],
        ),
      ),
    );
  }

  SliverFillRemaining get _noContentsSliver => const SliverFillRemaining(
        child: Center(child: Text('Não existem conteúdo para serem exibidos.')),
      );

  SliverPageSearchAppBar get _appBar => SliverPageSearchAppBar(
        title: const PageTitle(title: 'Conteúdos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {},
          ),
          AuthMedicAddButton(
            onPressed: () => Navigator.of(context).pushNamed(
              '/contents/register',
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: MySearchBar(
            hintText: 'Buscar Conteúdo',
            searchController: TextEditingController(),
            action: () {},
          ),
        ),
      );
}
