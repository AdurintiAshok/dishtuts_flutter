
import 'package:flutter/material.dart';

import '../model/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key,required this.category,required this.selectScreen});
  final void Function() selectScreen;
  final CategoryDataModel category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:selectScreen,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors:[
            category.color.withOpacity(1),
            category.color.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end:Alignment.bottomRight
    
          )
        ),
        child: Center(child: Text(category.title)),
    
      ),
    );
  }
}