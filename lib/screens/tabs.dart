import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meals/provider/favorite_provider.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';

import '../provider/filter_provider.dart';
import 'categories.dart';
import 'mainDrawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
   TabsScreen({super.key,required this.useremail});
  final String useremail;
  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _index = 0;



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
      activeScreen = MealsScreen(meals: favoritemeal,active:true);
      activePageTitle = "Your Favourites";
    }

    return Scaffold(
      backgroundColor:const  Color.fromARGB(255, 12, 14, 17),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(setScreen: _setScreen,useremail:widget.useremail),
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
