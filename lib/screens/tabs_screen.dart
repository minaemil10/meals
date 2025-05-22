import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';


class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentIndex = 0;
  


  void _onChooseTab(var index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _selectedScreen(String name) async {
    Navigator.of(context).pop();
    if (name == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsprovider);
    final activeFilters = ref.watch(filtersprovider);
    var filteredmeals =
        meals.where((meal) {
          if (activeFilters[Filters.gluteenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (activeFilters[Filters.vageterian]! && !meal.isVegetarian) {
            return false;
          }
          if (activeFilters[Filters.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    Widget activeScreen = CategoriesScreen(
      filteredmeals: filteredmeals,
    );
    var title = 'Categories';

    if (_currentIndex == 1) {
      final favouriteMeals = ref.watch(favouritesprovider);
      activeScreen = MealsScreen(
        meals: favouriteMeals,
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
