import 'package:flutter/material.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

class SearchBar extends StatelessWidget {
  final Function() action;
  final String hintText;
  final TextEditingController searchController;

  const SearchBar({
    super.key,
    required this.action,
    required this.hintText,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomTextField(
        hintText: hintText,
        controller: searchController,
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: action,
        ),
      ),
    );
  }
}
