import 'package:flutter/material.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/category_meal_screen.dart';
import 'package:provider/provider.dart';

class CategoryItems extends StatelessWidget {
  final String? title;
  final String? id;
  final Color? color;
  const CategoryItems({Key? key, this.color, this.id, this.title})
      : super(key: key);

  List<Color> callcolor(Color color) {
    List<Color> colorscall = [
      color,
      color.withOpacity(0.1),
      color.withOpacity(0.2),
      color.withOpacity(0.3),
      color.withOpacity(0.4),
      color.withOpacity(0.5),
      color.withOpacity(0.6),
      color.withOpacity(0.7),
      color.withOpacity(0.8),
      color.withOpacity(0.9),
    ];
    return colorscall;
  }

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategorymealScreen.routename,
        arguments: {"id": id, "title": title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => selectCategory(context),
        splashColor: Theme.of(context).primaryColor,
        child: Material(
          borderRadius: BorderRadius.circular(15),
          elevation: Provider.of<ThemesProvider>(context).tm == ThemeMode.light
              ? 10
              : 5,
          shadowColor: color,
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: callcolor(color!),
                ),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ));
  }
}
