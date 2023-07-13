import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';
import 'package:meals/screens/meals.dart';

import '../data/categorydata.dart';
import '../model/meal.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.availableMeals});

  final List<Meal> availableMeals;
  void  selectScreen(BuildContext context,CategoryDataModel categoryDataModel)
  {
    final filteredMeals=availableMeals.where((meal) =>meal.categories.contains(categoryDataModel.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealsScreen(title:categoryDataModel.title, meals:filteredMeals)));
    
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:1.5,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        children: [
          
          for (final category in availableCategories)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryItem(
                category: category,
                selectScreen:()
                {
                   selectScreen(context,category);
                },
              ),
            )
        ],
      
    );
  }
}