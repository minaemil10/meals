import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavouritesProviderNotifier extends StateNotifier<List<Meal>> {
  FavouritesProviderNotifier() : super([]);

  bool toggleFavouriteMeal(Meal meal) {
    final isFavourite = state.contains(meal);

    if (isFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouritesprovider = StateNotifierProvider((ref) {
  return FavouritesProviderNotifier();
});
