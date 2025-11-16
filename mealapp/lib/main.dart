import 'package:flutter/material.dart';
import 'package:mealapp/providers/language_provider.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/categories_screens.dart';
import 'package:mealapp/screens/category_meal_screen.dart';
import 'package:mealapp/screens/filters_screen.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';
import 'package:mealapp/screens/tabs_screen.dart';
import 'package:mealapp/screens/theme_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MealProvider>(
      create: (ctx) => MealProvider(),
    ),
    ChangeNotifierProvider<ThemesProvider>(
      create: (ctx) => ThemesProvider(),
    ),
    ChangeNotifierProvider<LanguageProvider>(
      create: (ctx) => LanguageProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeAnimationCurve: Curves.linear,
      themeMode: Provider.of<ThemesProvider>(context).tm,

      theme: ThemeData(
          primarySwatch: Provider.of<ThemesProvider>(
            context,
          ).primaryColor,
          secondaryHeaderColor: Provider.of<ThemesProvider>(
            context,
          ).secondryColor,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          cardColor: const Color(0xFFFAFAFC),
          buttonColor: Colors.white,
          textTheme: ThemeData.light().textTheme.copyWith(
              bodySmall: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(255, 50, 50, 1),
              ),
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(255, 50, 50, 1),
              ),
              titleMedium: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold),
              titleSmall: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black))),
      //darktheme
      darkTheme: ThemeData(
          primarySwatch: Provider.of<ThemesProvider>(
            context,
          ).primaryColor,
          secondaryHeaderColor:
              Provider.of<ThemesProvider>(context).secondryColor,
          canvasColor: const Color.fromRGBO(14, 22, 33, 1),
          cardColor: const Color.fromRGBO(35, 34, 39, 1),
          buttonColor: Colors.white,
          textTheme: ThemeData.dark().textTheme.copyWith(
              bodySmall: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(255, 50, 50, 1),
              ),
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(255, 50, 50, 1),
              ),
              titleMedium: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold),
              titleSmall: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white))),

      debugShowCheckedModeBanner: false,
      home: TabsScreen(),
      routes: {
        ThemeScreen.routename: (context) => ThemeScreen(),
        CategoriesScreens.routenamee: (context) => CategoriesScreens(),
        FiltersScreen.routName: (context) => const FiltersScreen(),
        TabsScreen.routename: (context) => TabsScreen(),
        CategorymealScreen.routename: (context) => const CategorymealScreen(),
        MealDetailScreen.routName: ((context) => const MealDetailScreen())
      },
    );
  }
}
