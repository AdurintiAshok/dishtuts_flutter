import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/widgets/meal_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../screens/meal_item_data.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key,required this.meals});
    // final void Function(Meal meal) favouriteMeal;
  final Meal meals;
  String get complexityData
  {
    return meals.complexity.name[0].toUpperCase()+meals.complexity.name.substring(1);
  }
   String get Affordability
  {
    return meals.affordability.name[0].toUpperCase()+meals.affordability.name.substring(1);
  }
   getItemData(BuildContext context)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealItemData(meals:meals)));
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      clipBehavior: Clip.hardEdge,
      elevation:10,
      child: InkWell(
        onTap:()
        {
          getItemData(context);
        },
        child:Stack(
          children: [
            FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(meals.imageUrl),fit: BoxFit.cover,),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: 
            Container(
              color: Color.fromARGB(255, 80, 70, 70),
              padding: EdgeInsets.symmetric(horizontal:44,vertical:6),
              child:Column(
                children: [
                  Text(meals.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color:  Colors.white,fontSize: 20,
                  fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MealTrait(icon: Icons.schedule, duration:'${meals.duration} min'),
                      SizedBox(width:10,),
                        MealTrait(icon: Icons.work, duration:complexityData),
                        SizedBox(width: 10,),
                        MealTrait(icon: Icons.attach_money, duration:Affordability),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}