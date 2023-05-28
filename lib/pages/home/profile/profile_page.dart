import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/entities/user.dart';
import 'package:prev_ler/pages/auths/build_user_form.dart';
import 'package:prev_ler/pages/auths/login_page.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/services/darkmode_notifier.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/page_title.dart';

class ProfilePage extends ConsumerWidget {
  ProfilePage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _crmNumberController = TextEditingController();
  final _crmStateController = TextEditingController();
  final _selectedBornDateController = TextEditingController();
  final _occupationController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final authData = ref.watch(authDataProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Meu Perfil'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(darkModeProvider.notifier).toggle();
            },
            icon: darkMode
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.light_mode_outlined),
          ),
          IconButton(
            onPressed: () => _logoutAndNavigateToLoginPage(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: authData.when(
        error: (_, __) => const Text('Error'),
        loading: () => const CircularProgressIndicator(),
        data: (user) {
          final isMedic = user.medic != null;
          final userTypeForm = isMedic
              ? buildMedicForm(
                  crmNumberController: _crmNumberController,
                  crmStateController: _crmStateController,
                  isEditing: true,
                )
              : buildPatientForm(
                  occupationController: _occupationController,
                  isEditing: true,
                );

          _serializeControllers(user);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                ...buildUserForm(
                  context: context,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  nameController: _nameController,
                  selectedBornDateController: _selectedBornDateController,
                  bornDateController: _bornDateController,
                  isEditing: true,
                ),
                ...userTypeForm,
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomButton(
                    text: 'Salvar',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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

  Future<void> _logoutAndNavigateToLoginPage(BuildContext context) async {
    await AuthService().logout();

    if (context.mounted) {
      await _navigateToLoginPage(context);
    }
  }

  Future<void> _navigateToLoginPage(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }
}
