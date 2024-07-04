import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

const kInitialFilter = {
  Filter.gluttenFree: false,
  Filter.lactosFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

enum Filter {
  gluttenFree,
  lactosFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(kInitialFilter);

  void changeFilter(Filter filter, bool newValue) {
    state = {...state, filter: newValue};
  }

  void changeFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final filters = ref.watch(filtersProvider);
    final availableMeals = meals.where(
      (meal) {
        if (filters[Filter.gluttenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (filters[Filter.lactosFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (filters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      },
    ).toList();
    return availableMeals;
  },
);
