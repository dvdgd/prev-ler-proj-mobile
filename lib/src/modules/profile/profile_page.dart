import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/src/modules/home/components/dark_mode_button.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/build_user_form.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _crmNumberController = TextEditingController();
  final _crmStateController = TextEditingController();
  final _selectedBornDateController = TextEditingController();
  final _occupationController = TextEditingController();

  void _serializeControllers(User user) {
    _emailController.text = user.email;
    _passwordController.text = user.password ?? '';
    _nameController.text = user.name;
    _bornDateController.text = DateFormat('dd/MM/yyyy').format(user.bornDate);
    _crmNumberController.text = user.medic?.crmNumber ?? '';
    _crmStateController.text = user.medic?.crmState ?? '';
    _selectedBornDateController.text =
        DateFormat('dd/MM/yyyy').format(user.bornDate);
    _occupationController.text = user.patient?.occupation ?? '';
  }

  _userForm(bool isMedic, BuildContext context) {
    var widgetList = <Widget>[];

    final baseUserForm = buildUserForm(
      context: context,
      emailController: _emailController,
      passwordController: _passwordController,
      nameController: _nameController,
      selectedBornDateController: _selectedBornDateController,
      bornDateController: _bornDateController,
      isEditing: true,
    );

    widgetList.addAll(baseUserForm);

    late final List<Widget> userTypeForm;
    if (isMedic) {
      userTypeForm = buildMedicForm(
        crmNumberController: _crmNumberController,
        crmStateController: _crmStateController,
        isEditing: true,
      );
    } else {
      userTypeForm = buildPatientForm(
        occupationController: _occupationController,
        isEditing: true,
      );
    }

    widgetList.addAll(userTypeForm);
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final user = controller.user;

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final isMedic = user.medic != null;
    final userForm = _userForm(isMedic, context);
    _serializeControllers(user);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Meu Perfil'),
        actions: const [DarkModeButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            ...userForm,
            const SizedBox(height: 40),
            CustomAsyncLoadingButton(
              text: 'Salvar',
              action: () => controller.updateUser(user),
            ),
          ],
        ),
      ),
    );
  }
}
