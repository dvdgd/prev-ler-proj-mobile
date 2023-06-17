import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';

class SliverPageSearchAppBar extends StatelessWidget {
  const SliverPageSearchAppBar({
    super.key,
    this.actions,
    this.bottom,
    this.title,
  });

  final List<Widget>? actions;
  final PreferredSize? bottom;
  final PageTitle? title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      title: title,
      actions: actions,
      bottom: bottom,
    );
  }
}
