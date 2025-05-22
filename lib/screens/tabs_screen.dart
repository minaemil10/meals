import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

const Map<Filters, bool> kinitialfilters = {
  Filters.gluteenFree: false,
  Filters.vageterian: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentIndex = 0;
  final List<Meal> favouriteMeals = [];
  Map<Filters, bool> _activeFilters = kinitialfilters;

  void showModelFavourite(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavouriteMeal(Meal meal) {
    final isFavourite = favouriteMeals.contains(meal);
    if (isFavourite) {
      setState(() {
        favouriteMeals.remove(meal);
      });
      showModelFavourite('Meal removed From Favourites');
    } else {
      setState(() {
        favouriteMeals.add(meal);
      });
      showModelFavourite('Meal Added to Favourites');
    }
  }

  void _onChooseTab(var index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _selectedScreen(String name) async {
    Navigator.of(context).pop();
    if (name == 'filters') {
      var result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(activeFilters: _activeFilters),
        ),
      );
      setState(() {
        _activeFilters = result ?? kinitialfilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsprovider);
    var filteredmeals =
        meals.where((meal) {
          if (_activeFilters[Filters.gluteenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_activeFilters[Filters.vageterian]! && !meal.isVegetarian) {
            return false;
          }
          if (_activeFilters[Filters.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    Widget activeScreen = CategoriesScreen(
      onFavouriteMeal: _toggleFavouriteMeal,
      filteredmeals: filteredmeals,
    );
    var title = 'Categories';

    if (_currentIndex == 1) {
      activeScreen = MealsScreen(
        meals: favouriteMeals,
        onFavouriteMeal: _toggleFavouriteMeal,
      );
      title = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: MainDrawer(onChooseScreen: _selectedScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onChooseTab,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
      ),
    );
  }
}
