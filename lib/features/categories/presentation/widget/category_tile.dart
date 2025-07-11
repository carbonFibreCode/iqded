import 'package:flutter/material.dart';
import 'package:iqded/core/theme/app_colors.dart';

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

   const CategoryTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(65, 41, 120, 255),
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 170,
        width: 170,
        decoration: BoxDecoration(
          color: AppColors.buttonBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.buttonBlue : AppColors.textWhite,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(43, 41, 120, 255),
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(icon, size: 45, color: Colors.white),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
