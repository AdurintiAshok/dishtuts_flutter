import 'package:flutter/material.dart';
import 'package:meals/model/category.dart';
import 'package:meals/screens/meals.dart';

import '../data/categorydata.dart';
import '../model/meal.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget{
  const CategoriesScreen({super.key,required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
   late AnimationController _animationController;
   @override
  void initState() {
    _animationController=AnimationController(vsync:this,
    duration: const Duration(milliseconds:300 ),
    lowerBound: 0,
  upperBound: 1,

  );
  _animationController.forward();
    super.initState();
  }
  void  selectScreen(BuildContext context,CategoryDataModel categoryDataModel)
  {
    final filteredMeals=widget.availableMeals.where((meal) =>meal.categories.contains(categoryDataModel.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealsScreen(title:categoryDataModel.title, meals:filteredMeals)));
    
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
        
      ),
    
    builder: (ctx,child)=> Padding(padding: EdgeInsets.only(top:100 - _animationController.value*100),child: child,),);
  }
}