import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/provider/favorite_provider.dart';
import 'package:meals/provider/meal_provider.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';

import '../provider/filter_provider.dart';
import 'categories.dart';
import 'mainDrawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _index = 0;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        selectionColor: Colors.black,
      ),
      duration: Duration(seconds: 2),
    ));
  }

  // final List<Meal> favouritemeals = [];
  void _selectedPage(int index) {
    setState(() {
      _index = index;
    });
  }

  _setScreen(String filters) async {
    Navigator.of(context).pop();
    if (filters == 'filters') {
      await Navigator.of(context).push<Map<NavigatorData, bool>>(
          MaterialPageRoute(builder: (ctx) => const Filters()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var availableMeals = ref.watch(filteredMeals);
    Widget activeScreen = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = "Categories";
    if (_index == 1) {
      final favoritemeal = ref.watch(favoriteProvider);
      activeScreen = MealsScreen(meals: favoritemeal);
      activePageTitle = "Your Favourites";
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 241, 241),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(setScreen: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourites"),
        ],
        onTap: _selectedPage,
        currentIndex: _index,
      ),
    );
  }
}
