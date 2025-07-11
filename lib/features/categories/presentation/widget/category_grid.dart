import 'package:flutter/material.dart';
import 'package:iqded/features/categories/domain/categoryDataModel/category_data_model.dart';
import 'package:iqded/features/categories/presentation/widget/category_tile.dart';

class CategoryGridSliver extends StatelessWidget {
  final List<Category> categories;
  final int? selectedIndex;
  final ValueChanged<int> onCategorySelected;
  const CategoryGridSliver({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final category = categories[index];
        return CategoryTile(
          icon: category.icon,
          label: category.label,
          onTap: () => onCategorySelected(index),
          isSelected: selectedIndex == index,
        );
      }, childCount: categories.length),
    );
  }
}
