import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';

import '../model/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,this.title, required this.meals});
    // final void Function(Meal meal) favouriteMeal;
  final String? title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content = Text("Empty");
    if (meals.isEmpty) {
      content = const Center(
        child: Center(
          child: Text('OOps,No Items Here',style: TextStyle(color: Colors.white),),
        ),
      );
    }
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(meals: meals[index]));
    }

    if(title==null)
    {
      return content;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content
    );
  }
}
