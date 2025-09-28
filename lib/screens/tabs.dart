import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int activeScreenIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      activeScreenIndex = index;
    });
  }

  void _selectedScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    final availableMeal = ref.watch(filtteredMealsProvider);


    Widget activePage = CategoriesScreen(
      availableMeals: availableMeal,
    );

    
    var activePagetitle = 'Categories';



    if (activeScreenIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePagetitle = 'Your Favorites';
    }
    return Scaffold(
      drawer: MainDrawer(selectedScreen: _selectedScreen),
      appBar: AppBar(
        title: Text(activePagetitle),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeScreenIndex,
        onTap: _selectedPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
