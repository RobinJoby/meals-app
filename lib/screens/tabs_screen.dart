import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

import '../model/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String content) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(content),
      ),
    );
  }

  void _toggleFavouriteMeal(Meal meal) {
    final isFavourite = _favouriteMeals.contains(meal);
    if (isFavourite) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage('Meal removed from favourites');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showInfoMessage('Meal added to favourites');
    }
  }
  //  List<Widget> activeScreen =  [
  //   CategoriesScreen(),
  //   MealsScreen(meals: [],onToggleFavouriteMeal: _ToggleFavouriteMeal,)
  // ];

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavouriteMeal: _toggleFavouriteMeal,
    );
    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
          meals: _favouriteMeals, onToggleFavouriteMeal: _toggleFavouriteMeal);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedPageIndex == 0 ? 'Categories' : 'Your Favourites',
        ),
      ),
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
