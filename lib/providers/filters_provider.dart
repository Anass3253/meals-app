import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });

  void setFilters(Map<Filters, bool> choosenFlters) {
    state = choosenFlters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
  (ref) => FiltersNotifier(),
);

final filtteredMealsProvider = Provider(
  (ref) {
    const meals = dummyMeals;
    final activeFilters = ref.watch(filtersProvider);
    return meals.where(
      (meal) {
        if (activeFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (activeFilters[Filters.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (activeFilters[Filters.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();
  },
);
