import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class InjuryDropdownButton extends StatefulWidget {
  const InjuryDropdownButton({
    super.key,
    required this.injuryTypeController,
    this.idInjuryType,
    this.validator,
  });

  final int? idInjuryType;
  final TextEditingController injuryTypeController;
  final String? Function(int?)? validator;

  @override
  State<InjuryDropdownButton> createState() => _InjuryDropdownButtonState();
}

class _InjuryDropdownButtonState extends State<InjuryDropdownButton> {
  late final InjuriesController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<InjuriesController>();
    controller.addListener(_handleAuthStateChange);
    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchAllInjuries();
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(_handleAuthStateChange);
    super.dispose();
  }

  void _handleAuthStateChange() {
    if (controller.state == StateEnum.error) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<InjuriesController>();
    final injuries = controller.injuries;

    if (controller.state == StateEnum.loading ||
        controller.state == StateEnum.idle) {
      return const CustomTextField(
        prefixIcon: Icon(Icons.healing_outlined),
        hintText: 'Loading...',
        enable: false,
      );
    }

    if (injuries.isEmpty) {
      return const CustomTextField(
        prefixIcon: Icon(Icons.healing_outlined),
        hintText: 'Cadastre um Tipo de Lesão primeiro.',
        enable: false,
      );
    }

    return CustomDropdownButton(
      validator: widget.validator,
      controller: widget.injuryTypeController,
      prefixIcon: const Icon(Icons.healing_outlined),
      hintText: 'Selecionar Lesão',
      initValue: widget.idInjuryType,
      list: [
        for (var item in injuries)
          DropdownMenuItem<int>(
            value: item.idInjuryType,
            child: Text(
              item.name,
            ),
          ),
      ],
    );
  }
}
