import 'package:flutter/material.dart';
import 'package:mealapp/2.2%20dummy_data.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/size_config.dart';
import '../models/meal.dart';

import 'package:provider/provider.dart';

import '../providers/meal_provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routName = "MealDetailScreen";

  const MealDetailScreen({Key? key}) : super(key: key);
  Widget buildsectiontitle(String text, BuildContext ctx) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: Theme.of(ctx).textTheme.titleSmall,
        ),
      );

  Widget buildcontainer(Widget child) => Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 220,
      width: 280,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: child);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var selectColr = Theme.of(context).secondaryHeaderColor;
    final MealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedmeal =
        DUMMY_MEALS.firstWhere((element) => element.id!.contains(MealId));
    final ingredients = lan.returntext('ingredients-$MealId') as List<String>;

    final steps = lan.returntext('steps-$MealId') as List<String>;

    return SafeArea(
      child: Directionality(
        textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(lan.returntext('meal-$MealId').toString()),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/10.1 a2.png'),
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        selectedmeal.imageurl.toString(),
                      ),
                    ),
                  ),
                ),
                if (SizeConfig.orientation == Orientation.portrait)
                  Column(
                    children: [
                      buildsectiontitle(
                          lan.returntext('Ingredients').toString(), context),
                      buildcontainer(ListView.builder(
                        itemCount: ingredients.length,
                        itemBuilder: (ctx, i) => Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(5)),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            ingredients[i].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )),
                    ],
                  ),
                if (SizeConfig.orientation == Orientation.portrait)
                  Column(
                    children: [
                      buildsectiontitle(
                          lan.returntext('Steps').toString(), context),
                      buildcontainer(ListView.builder(
                          itemCount: steps.length,
                          itemBuilder: (ctx, i) => Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      child: Text("#${(i + 1).toString()}"),
                                    ),
                                    title: Text(
                                      steps[i].toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ))),
                    ],
                  ),
                if (SizeConfig.orientation == Orientation.landscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          buildsectiontitle(
                              lan.returntext('Ingredients').toString(),
                              context),
                          buildcontainer(ListView.builder(
                            itemCount: ingredients.length,
                            itemBuilder: (ctx, i) => Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8),
                              child: Text(
                                ingredients[i].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.1,
                      ),
                      Column(
                        children: [
                          buildsectiontitle(
                              lan.returntext('Steps').toString(), context),
                          buildcontainer(ListView.builder(
                              itemCount: steps.length,
                              itemBuilder: (ctx, i) => Column(
                                    children: [
                                      ListTile(
                                        leading: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color:
                                                  Provider.of<ThemesProvider>(
                                                          context)
                                                      .secondryColor,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Text(
                                            '#${i + 1}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        title: Text(
                                          steps[i].toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                      const Divider()
                                    ],
                                  ))),
                        ],
                      ),
                    ],
                  )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Provider.of<MealProvider>(context, listen: false)
                .Togglefolters(MealId),
            child: Icon(Provider.of<MealProvider>(context, listen: true)
                    .ismealfavorate(MealId)
                ? Icons.star
                : Icons.star_border),
          ),
        ),
      ),
    );
  }
}
