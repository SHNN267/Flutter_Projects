import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/size_config.dart';
import 'package:mealapp/widgets/mealitems.dart';
import 'package:provider/provider.dart';

class CategorymealScreen extends StatefulWidget {
  static const routename = "CategorymealScreen";

  const CategorymealScreen({Key? key}) : super(key: key);

  @override
  State<CategorymealScreen> createState() => _CategorymealScreenState();
}

String? categorytitle;
List<Meal>? displayedMeal;
String? categoryid;

class _CategorymealScreenState extends State<CategorymealScreen> {
  removeitems(String mealid) {
    setState(() {
      displayedMeal!.removeWhere((meal) => meal.id!.contains(mealid));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final List<Meal> avaiableMeals =
        Provider.of<MealProvider>(context).avaiableMeals;
    Map routearg =
        ModalRoute.of(context)!.settings.arguments as Map<String?, String?>;
    categoryid = routearg["id"];

    categorytitle = routearg["title"];
    displayedMeal = avaiableMeals.where(
      (meal) {
        return meal.categories!.contains(categoryid);
      },
    ).toList();
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              categorytitle.toString(),
            ),
            centerTitle: true,
          ),
          body: SizeConfig.orientation != Orientation.landscape
              ? ListView.builder(
                  itemBuilder: (ctx, i) {
                    return MealItems(
                      title: lan.returntext('meal-$categoryid').toString(),
                      imageurl: displayedMeal![i].imageurl.toString(),
                      affordability: displayedMeal![i].affordability.toString(),
                      complexity: displayedMeal![i].complexity.toString(),
                      duration: displayedMeal![i].duration as int,
                      id: displayedMeal![i].id.toString(),
                    );
                  },
                  itemCount: displayedMeal!.length,
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      childAspectRatio: 2 / 2.4,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 400),
                  itemCount: displayedMeal!.length,
                  itemBuilder: (BuildContext context, int i) {
                    return MealItems(
                      title: displayedMeal![i].id.toString(),
                      imageurl: displayedMeal![i].imageurl.toString(),
                      affordability: displayedMeal![i].affordability.toString(),
                      complexity: displayedMeal![i].complexity.toString(),
                      duration: displayedMeal![i].duration as int,
                      id: displayedMeal![i].id.toString(),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
