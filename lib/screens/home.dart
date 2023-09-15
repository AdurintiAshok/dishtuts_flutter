import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
   Home({super.key});
  List food=[
    "Burger",
    "Snacks",
    "Water",
    "Pizza"
  ];
  List nonveg=[
    "Chicken Burger",
    "Chicken Pizza"
  ];
  List<Color> bgColors=[
    Color(0xFFFBDCDA),
    Color(0xFFD4EEF3),
    Color(0xFFFAE6D5),
    Color(0xFFEFCFE7)

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Text("Ashok")
      ),
    );
  }
}