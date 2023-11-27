import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class InjuryFormPage extends StatefulWidget {
  final String title;
  final InjuryType? injury;

  const InjuryFormPage({
    super.key,
    this.injury,
    required this.title,
  });

  @override
  State<InjuryFormPage> createState() => _InjuryFormPageState();
}

class _InjuryFormPageState extends State<InjuryFormPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  late final User medic;
  late final InjuriesController controller;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = context.read<InjuriesController>();
    controller.addListener(_handleAuthStateChange);

    final user = context.read<UserController>().user;
    if (user == null || user.type == UserType.employee) {
      Navigator.of(Routes.navigatorKey.currentContext!)
          .pushReplacementNamed('/');
    } else {
      medic = user;
    }

    final injury = widget.injury;
    if (injury != null) serializeControllers(injury);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_handleAuthStateChange);
  }

  void serializeControllers(InjuryType injury) {
    _nameController.text = injury.name;
    _descriptionController.text = injury.description;
  }

  void _handleAuthStateChange() {
    if (controller.state == StateEnum.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sucesso!')),
      );
      Navigator.of(Routes.navigatorKey.currentContext!).pop();
    }

    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  InjuryType _getInjuryFromForm() {
    final name = _nameController.text;
    final description = _descriptionController.text;

    return InjuryType(
      idInjuryType: widget.injury?.idInjuryType ?? 0,
      companyId: medic.company?.cnpj ?? '',
      name: name,
      description: description,
      createdAt: widget.injury?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: PageTitle(title: widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextFormField(
                validator: (text) => text == null || text.isEmpty
                    ? 'Nome não pode ser vazio'
                    : null,
                controller: _nameController,
                labelText: 'Nome',
                prefixIcon: const Icon(Icons.text_fields),
              ),
              MyTextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Descrição não pode ser vazia';
                  }
                  return null;
                },
                controller: _descriptionController,
                labelText: 'Descrição',
                prefixIcon: const Icon(Icons.description),
                textInputType: TextInputType.multiline,
                maxLines: 5,
                maxLength: 2000,
              ),
              const SizedBox(height: 40),
              MyFilledLoadingButton(
                text: 'Salvar',
                action: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  if (widget.injury == null) {
                    return controller.create(_getInjuryFromForm());
                  }
                  return controller.update(_getInjuryFromForm());
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
