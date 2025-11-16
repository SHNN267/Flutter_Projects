import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';

class MealItems extends StatelessWidget {
  const MealItems(
      {@required this.imageurl,
      // @required this.removeitem,
      this.id,
      @required this.affordability,
      @required this.complexity,
      @required this.duration,
      this.title});
  final String? imageurl, title, id;
  final int? duration;
  final String? complexity;
  final String? affordability;
  // final Function removeitem;

  void SelectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.routName, arguments: id);
    //   .then((value) {
    // if (value != null) removeitem(value);
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    ThemeMode mode = Provider.of<ThemesProvider>(context).tm;
    return InkWell(
      onTap: () => SelectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Hero(
                    tag: id.toString(),
                    child: InteractiveViewer(
                      child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/10.1 a2.png'),
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            imageurl.toString(),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 10,
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    color: Colors.black.withOpacity(0.3),
                    child: Text(
                      lan.returntext('meal-$id').toString(),
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: mode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        duration.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                          lan
                              .returntext(
                                'min',
                              )
                              .toString(),
                          style: Theme.of(context).textTheme.titleSmall)
                    ],
                  ),
                  Row(children: [
                    Icon(Icons.work,
                        color: mode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      lan.returntext(complexity!).toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ]),
                  Row(children: [
                    Icon(
                      Icons.attach_money,
                      color:
                          mode == ThemeMode.dark ? Colors.white : Colors.black,
                    ),
                    Text(
                      lan.returntext(affordability!).toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
