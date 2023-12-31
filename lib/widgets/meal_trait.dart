import 'package:flutter/material.dart';

class MealTrait extends StatelessWidget {
  const MealTrait({super.key,required this.icon, required this.duration});
  final IconData icon;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,size:17,),
        const SizedBox(width:4,),
        Text(duration,style:const TextStyle(color: Colors.white),)
      ],
    );
  }
}