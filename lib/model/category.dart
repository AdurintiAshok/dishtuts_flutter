import 'package:flutter/material.dart';
class CategoryDataModel
{
  CategoryDataModel({required this.id,required this.title, this.color=const Color.fromARGB(255, 230, 196, 75)});
  final String id;
  final String title;
  final Color color;

}