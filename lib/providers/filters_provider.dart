import 'package:flutter_riverpod/flutter_riverpod.dart';

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
