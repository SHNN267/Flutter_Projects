import 'package:flutter/material.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routName = "Filters";

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersState();
}

class _FiltersState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final Map<String?, bool?> filters =
        Provider.of<MealProvider>(context, listen: false).filters;
    SwitchListTile buildSwitchListTile(String title, String subtitle,
            bool buttonswitch, dynamic function) =>
        SwitchListTile(
          value: buttonswitch,
          onChanged: function,
          title: Text(title, style: Theme.of(context).textTheme.titleMedium),
          subtitle:
              Text(subtitle, style: Theme.of(context).textTheme.titleSmall),
        );
    return Directionality(
      textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(lan.returntext('filters_appBar_title').toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "RobotoCondensed",
                    fontWeight: FontWeight.bold)),
          ),
          body: Center(
              child: Column(
            children: [
              Container(
                alignment:
                    lan.isEN ? Alignment.centerLeft : Alignment.centerRight,
                padding: const EdgeInsets.all(20),
                child: Text(
                  lan.returntext('filters_screen_title').toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  buildSwitchListTile(
                      lan.returntext('Gluten-free').toString(),
                      lan.returntext('Gluten-free-sub').toString(),
                      filters['gluten']!, (val1) {
                    setState(() {
                      filters['gluten'] = val1;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setfelters();
                  }),
                  buildSwitchListTile(
                      lan.returntext('Lactose-free').toString(),
                      lan.returntext('Lactose-free_sub').toString(),
                      filters['lactose']!, (val) {
                    setState(() {
                      filters['lactose'] = val;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setfelters();
                  }),
                  buildSwitchListTile(
                      lan.returntext('Vegetarian').toString(),
                      lan.returntext('Vegetarian-sub').toString(),
                      filters['vegetarian']!, (val) {
                    setState(() {
                      filters['vegetarian'] = val;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setfelters();
                  }),
                  buildSwitchListTile(
                      lan.returntext('Vegan').toString(),
                      lan.returntext('Vegan-sub').toString(),
                      filters['vegan']!, (val) {
                    setState(() {
                      filters['vegan'] = val;
                    });
                    Provider.of<MealProvider>(context, listen: false)
                        .setfelters();
                  }),
                ],
              ))
            ],
          )),
          drawer: MainDrawer(),
        ),
      ),
    );
  }
}
