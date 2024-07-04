import 'package:flutter/material.dart';
import 'package:meals_app/providers/favourite_meal_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  //  List<Widget> activeScreen =  [
  //   CategoriesScreen(),
  //   MealsScreen(meals: [],onToggleFavouriteMeal: _ToggleFavouriteMeal,)
  // ];

  @override
  Widget build(BuildContext context) {
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
    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealProvider);
      activeScreen = MealsScreen(meals: favouriteMeals);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedPageIndex == 0 ? 'Categories' : 'Your Favourites',
        ),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal_sharp,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favourites',
          ),
        ],
      ),
      body: activeScreen,
    );
  }
}
