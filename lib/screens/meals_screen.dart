import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals, required this.onFavouriteMeal});

  final String? title;

  final void Function(Meal) onFavouriteMeal;
  final List<Meal> meals;
  void chooseMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal,onFavouriteMeal: onFavouriteMeal,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget content =
        meals.isNotEmpty
            ? ListView.builder(
              itemCount: meals.length,
              itemBuilder:
                  (ctx, i) => MealItem(
                    meal: meals[i],
                    onChooseMeal: () {
                      chooseMeal(context, meals[i]);
                    },
                  ),
            )
            : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'oh ohh ... No meals Found',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    'Try choosing another category',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            );
    if (title == null) {
      return content;
    }
    return Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }
}
