import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final TextEditingController controller;

  const CustomDropdownButton({super.key, required this.controller});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonFormField<String>(
          value: _getDropdownMenuItems()[0],
          items: _getDropdownMenuItems()
              .map((estado) => DropdownMenuItem<String>(
                    value: estado,
                    child: Text(estado),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _dropdownValue = newValue;
                widget.controller.text = newValue;
              });
            }
          },
          decoration: const InputDecoration(
            hintText: 'Selecione um estado',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.map_outlined),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  List<String> _getDropdownMenuItems() {
    return [
      'AC',
      'AL',
      'AP',
      'AM',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MT',
      'MS',
      'MG',
      'PA',
      'PB',
      'PR',
      'PE',
      'PI',
      'RJ',
      'RN',
      'RS',
      'RO',
      'RR',
      'SC',
      'SP',
      'SE',
      'TO'
    ];
  }
}
