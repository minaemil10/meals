import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filters { gluteenFree, lactoseFree, vageterian, vegan }

class FiltersProviderNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersProviderNotifier()
    : super({
        Filters.gluteenFree: false,
        Filters.vageterian: false,
        Filters.lactoseFree: false,
        Filters.vegan: false,
      });
  void setAllFilters(Map<Filters, bool> filters) => state = filters;
  void setFilter(Filters filter, bool isSet) {
    state = {...state, filter: isSet};
  }
}

final filtersprovider = StateNotifierProvider((ref) {
  return FiltersProviderNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsprovider);
  final activeFilters = ref.watch(filtersprovider);
  return meals.where((meal) {
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
});
