import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';

class MySearchBar extends StatelessWidget {
  final Function() action;
  final String hintText;
  final TextEditingController searchController;

  const MySearchBar({
    super.key,
    required this.action,
    required this.hintText,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      hintText: hintText,
      controller: searchController,
      suffixIcon: IconButton(
        icon: const Icon(Icons.search),
        onPressed: action,
      ),
    );
  }
}
