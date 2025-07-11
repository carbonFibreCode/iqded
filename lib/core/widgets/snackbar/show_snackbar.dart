import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.inter(
          color: colorScheme.onSecondary,
          fontWeight: FontWeight.w400,
        ),
      ),

      backgroundColor: isError ? colorScheme.error : colorScheme.secondary,

      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      margin: const EdgeInsets.all(10),
    ),
  );
}
