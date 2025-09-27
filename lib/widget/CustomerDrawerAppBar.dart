import 'package:flutter/material.dart';

import 'package:speakbook/widget/text_widget.dart';



import '../constants/appcolorsconst.dart'; // Replace with actual path

class CustomerDrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomerDrawerAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      backgroundColor: AppColors.appBarColors,
      centerTitle: true,
      title: BalooSubtitleText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
