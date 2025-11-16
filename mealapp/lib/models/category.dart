import 'package:flutter/material.dart';

class Category {
  final String? title, id;
  Color? color;
  Category({this.color = Colors.orange, @required this.id, this.title});
}
