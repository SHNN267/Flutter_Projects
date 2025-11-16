import 'package:flutter/material.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:mealapp/screens/theme_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);
  Widget BuildListtile(String title, IconData icondata, Function() ontaphere,
          BuildContext context) =>
      ListTile(
        onTap: ontaphere,
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        leading: Icon(
          icondata,
          size: 21,
          color: Colors.grey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Theme.of(context).secondaryHeaderColor,
                alignment:
                    lan.isEN ? Alignment.centerLeft : Alignment.centerRight,
                child: Text(
                  lan
                      .returntext(
                        'drawer_name',
                      )
                      .toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BuildListtile(
                  lan.returntext('drawer_item1').toString(), Icons.restaurant,
                  () {
                Navigator.of(context).pushReplacementNamed(
                  TabsScreen.routename,
                );
              }, context),
              BuildListtile(
                  lan.returntext('drawer_item2').toString(), Icons.settings,
                  () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routName);
              }, context),
              BuildListtile(
                  lan.returntext('drawer_item3').toString(), Icons.color_lens,
                  () {
                Navigator.of(context)
                    .pushReplacementNamed(ThemeScreen.routename);
              }, context),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                indent: 3,
                endIndent: 3,
              ),
              Text(
                lan.returntext('drawer_switch_title').toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lan.returntext('drawer_switch_item2').toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Switch(
                      value:
                          Provider.of<LanguageProvider>(context, listen: true)
                              .isEN,
                      onChanged: (newVal) {
                        Provider.of<LanguageProvider>(context, listen: false)
                            .onchangeLanguage(newVal);
                      }),
                  Text(
                    lan.returntext('drawer_switch_item1').toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                indent: 3,
                endIndent: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
