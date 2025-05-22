import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.filteredmeals,
  });

  final List<Meal> filteredmeals;

  void _categorySelect(BuildContext context, Category category) {
    final filteredMeals =
        filteredmeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        ...availableCategories.map(
          (category) => CategoryCard(
            category: category,
            onCategoryselect: () {
              _categorySelect(context, category);
            },
          ),
        ),
      ],
    );
  }
}
