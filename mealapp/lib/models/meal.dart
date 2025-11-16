import 'package:flutter/cupertino.dart';

class Meal {
  final String? id, title, imageurl;
  final List<String>? steps;
  final List<String>? ingredients;
  final List<String>? categories;
  final int? duration;
  final String? complexity;
  final String? affordability;
  final bool? isGlutenFree, isLactosefree, isVegan, isVvegetarian;
  Meal(
      {@required this.duration,
      @required this.affordability,
      @required this.categories,
      @required this.complexity,
      @required this.id,
      @required this.imageurl,
      @required this.ingredients,
      @required this.isGlutenFree,
      @required this.isLactosefree,
      @required this.isVegan,
      @required this.isVvegetarian,
      @required this.steps,
      @required this.title});
}
