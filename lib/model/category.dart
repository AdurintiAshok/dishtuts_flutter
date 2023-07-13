import 'package:flutter/material.dart';
class CategoryDataModel
{
  CategoryDataModel({required this.id,required this.title, this.color=Colors.amber});
  final String id;
  final String title;
  final Color color;

}