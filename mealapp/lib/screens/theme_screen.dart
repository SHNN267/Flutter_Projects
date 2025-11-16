import 'package:flutter/material.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  ThemeScreen({Key? key}) : super(key: key);
  static const routename = 'ThemeScreen';

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

int index2 = 0;

InkWell buildBoxColorTheme(
  int index,
  Color primaryColor,
  Color secondryColor,
  BuildContext context,
) {
  return InkWell(
    onTap: () async {
      Provider.of<ThemesProvider>(context, listen: false)
          .changeColorTheme(primaryColor, secondryColor);
      index2 = index;

      Navigator.of(context).pop();
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 140,
          height: 70,
          child: Column(
            children: [
              Container(
                height: 35,
                width: 70,
                color: primaryColor,
              ),
              Container(
                height: 35,
                width: 70,
                color: secondryColor,
              ),
            ],
          ),
        ),
        if (index2 == index ? true : false)
          Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.done,
                color: Colors.white,
              ))
      ],
    ),
  );
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, Color>> colorThemeList =
        Provider.of<ThemesProvider>(context).colorthemeList;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    double HS = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(lan.returntext('theme_appBar_title').toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold)),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: HS * 0.02,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                lan.returntext('theme_screen_title').toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: HS * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: lan.isEN ? Alignment.topLeft : Alignment.topRight,
                child: Text(
                  lan.returntext('theme_mode_title').toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(
              height: HS * 0.1,
            ),
            buildListTile(context, lan.returntext('light_theme').toString(),
                ThemeMode.light, Icons.sunny),
            buildListTile(context, lan.returntext('dark_theme').toString(),
                ThemeMode.dark, Icons.dark_mode),
            ListTile(
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 20,
                          height: 40,
                          color:
                              Provider.of<ThemesProvider>(context).primaryColor,
                        ),
                        Container(
                          width: 20,
                          height: 40,
                          color: Provider.of<ThemesProvider>(context)
                              .secondryColor,
                        )
                      ],
                    ),
                    const Icon(
                      Icons.done,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              title: Text(lan.returntext('chooseColorFilter').toString()),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor:
                            Theme.of(context).canvasColor.withOpacity(0.7),
                        title: Center(
                            child: Text(lan
                                .returntext('chooseColorFilter')
                                .toString())),
                        content: SizedBox(
                          width: 300,
                          height: 300,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: colorThemeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildBoxColorTheme(
                                  index,
                                  colorThemeList[index]['primary']!,
                                  colorThemeList[index]['secondry']!,
                                  context);
                            },
                          ),
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  RadioListTile<ThemeMode> buildListTile(
    BuildContext context,
    String title,
    ThemeMode themval,
    IconData icon,
  ) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Provider.of<ThemesProvider>(context).tm == ThemeMode.dark
            ? Colors.white
            : Colors.grey,
      ),
      value: themval,
      groupValue: Provider.of<ThemesProvider>(context, listen: true).tm,
      onChanged: (newval) {
        Provider.of<ThemesProvider>(context, listen: false)
            .changeThemeMode(newval!);
      },
      title: Text(title),
    );
  }
}
