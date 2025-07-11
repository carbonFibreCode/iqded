
import 'package:flutter/material.dart';
import 'package:iqded/core/AppStrings/app_strings.dart';
import 'package:iqded/core/theme/app_colors.dart';

class DropDownLevel extends StatelessWidget {
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  const DropDownLevel({super.key, required this.selectedItem, required this.onChanged});

  

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      textAlign: TextAlign.center,
      dropdownMenuEntries: const [
        DropdownMenuEntry(
          value: AppStrings.easy,
          label: AppStrings.easy,
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.correctGreen),
          ),
        ),
        DropdownMenuEntry(
          value: AppStrings.medium,
          label: AppStrings.medium,
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.buttonBlue),
          ),
        ),
        DropdownMenuEntry(
          value: AppStrings.hard,
          label: AppStrings.hard,
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.wrongRed),
          ),
        ),
        
      ],
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.buttonBlue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
      ),
      hintText: AppStrings.chooseLevel,
      initialSelection: selectedItem,
      onSelected: onChanged,
      width: 200,
      menuStyle: const MenuStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
        ),
        backgroundColor: WidgetStatePropertyAll(AppColors.scaffoldBlack),
        shadowColor: WidgetStatePropertyAll(AppColors.buttonBlue),
        elevation: WidgetStatePropertyAll(6),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 0)),
        fixedSize: WidgetStatePropertyAll(Size(200, 150)),
        visualDensity: VisualDensity(vertical: 0),
        
      ),
    );
  }
}
