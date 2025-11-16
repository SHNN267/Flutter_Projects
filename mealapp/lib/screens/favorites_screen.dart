import "package:flutter/material.dart";
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/size_config.dart';
import 'package:provider/provider.dart';

import '../widgets/mealitems.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    List<Meal> favoratemeal =
        Provider.of<MealProvider>(context, listen: true).favoratemeal;
    if (favoratemeal == null || favoratemeal.isEmpty) {
      return SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lan.returntext('favorites_text').toString(),
              style: TextStyle(
                  color:
                      Provider.of<ThemesProvider>(context).tm == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      return Directionality(
        textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
        child: SafeArea(
          child: SizeConfig.orientation != Orientation.landscape
              ? ListView.builder(
                  itemBuilder: (ctx, i) {
                    return MealItems(
                      title: favoratemeal[i].title.toString(),
                      imageurl: favoratemeal[i].imageurl.toString(),
                      affordability: favoratemeal[i].affordability.toString(),
                      complexity: favoratemeal[i].complexity.toString(),
                      duration: favoratemeal[i].duration as int,
                      id: favoratemeal[i].id.toString(),
                    );
                  },
                  itemCount: favoratemeal.length,
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      childAspectRatio: 2 / 2.4,
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      mainAxisExtent: 400),
                  itemCount: favoratemeal.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MealItems(
                        id: favoratemeal[index].id.toString(),
                        title: favoratemeal[index].title.toString(),
                        imageurl: favoratemeal[index].imageurl.toString(),
                        affordability:
                            favoratemeal[index].affordability.toString(),
                        complexity: favoratemeal[index].complexity.toString(),
                        duration: favoratemeal[index].duration as int);
                  },
                ),
        ),
      );
    }
  }
}
