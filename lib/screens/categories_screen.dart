import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/category.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavouriteMeal});

  final void Function(Meal meal) onToggleFavouriteMeal;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where(
          (meal) => meal.categories.contains(
            category.id,
          ),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavouriteMeal: onToggleFavouriteMeal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 3 / 2,
      ),
      children: [
        ...availableCategories.map(
          (category) => CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
        )
      ],
    );
  }
}
