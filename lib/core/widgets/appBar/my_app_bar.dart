import 'package:flutter/material.dart';
import 'package:iqded/core/theme/app_colors.dart';

class MyAppBar extends StatelessWidget {
  final Widget abTitle;
  const MyAppBar({super.key, required this.abTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.scaffoldBlack,
      elevation: 0,
      title: abTitle
    );
  }
}
