import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqded/core/theme/app_colors.dart';

class AppStyleButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;
  final Size minSize;
  const AppStyleButton({super.key, required this.icon, required this.text, required this.onPressed, required this.minSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.scaffoldBlack,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: minSize,
      ),
      icon: icon,
      label: Text(
        text,
        style: GoogleFonts.inter(
          color: AppColors.textWhite,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
