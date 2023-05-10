import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/entities/user.dart';
import 'package:prev_ler/pages/auths/build_user_form.dart';
import 'package:prev_ler/service/auth_service.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/page_title.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _crmNumberController = TextEditingController();
  final _crmStateController = TextEditingController();
  final _selectedBornDateController = TextEditingController();
  final _occupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Meu Perfil'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          var data = ref.watch(authDataProvider);

          return data.when(
            data: (user) => _buildBody(user),
            error: (_, __) => const Text('Error'),
            loading: () => const CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  SingleChildScrollView _buildBody(User user) {
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
      child: Container(
        color: Colors.white,
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
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildOptionsButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildOptionsButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CustomButton(
            buttonColor: Colors.pink,
            text: 'Cancelar',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: CustomButton(
            text: 'Salvar',
            onTap: () {},
          ),
        ),
      ],
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
}
