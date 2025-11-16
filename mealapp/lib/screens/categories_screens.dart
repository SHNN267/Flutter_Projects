import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mealapp/2.2%20dummy_data.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../widgets/categor_items.dart';

class CategoriesScreens extends StatefulWidget {
  CategoriesScreens({Key? key}) : super(key: key);
  static const routenamee = "CategoriesScreens";

  @override
  State<CategoriesScreens> createState() => _CategoriesScreensState();
}

@override
class _CategoriesScreensState extends State<CategoriesScreens> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: GridView(
            padding: const EdgeInsets.all(25),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            children: Provider.of<MealProvider>(context)
                .avaibleCategory
                .map((e) => CategoryItems(
                      color: e.color as Color,
                      title: lan.returntext('cat-${e.id}').toString(),
                      id: e.id.toString(),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
