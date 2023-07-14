import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';

import '../model/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,this.title, required this.meals,required this.active});
  final bool active;
  final String? title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content =const Text("");
    if (meals.isEmpty && active) {
      content = const Center(
        child: Center(
          child: Text('OOps,No Items Here Add Some',style: TextStyle( color:Color.fromARGB(255, 233, 229, 229))),),
      );
    }
    else{
        content = const Center(
        child: Center(
          child: Text('OOps,No Items Here',style: TextStyle( color:Color.fromARGB(255, 8, 7, 7))),),
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
