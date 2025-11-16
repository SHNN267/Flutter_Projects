import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/providers/meal_provider.dart';
import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/screens/categories_screens.dart';
import 'package:mealapp/screens/favorites_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routename = "TabsScreen";
  List<Meal>? favoratemeal;
  bool onchangetheme = false;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

List<Map<String, Object>>? _pages;

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndexpage = 0;
  void _selecpage(int value) {
    setState(() {
      _selectedIndexpage = value;
    });
  }

  @override
  void didChangeDependencies() {
    Provider.of<MealProvider>(context, listen: false).editCategory();
    Provider.of<MealProvider>(context, listen: false).getFilters();
    Provider.of<ThemesProvider>(context, listen: false).getColortheme();

    var lan2 = Provider.of<LanguageProvider>(context, listen: true);
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemesProvider>(context, listen: false).getThemeModeshared();
    Provider.of<LanguageProvider>(context, listen: false).getDataLanguage();

    _pages = [
      {
        "page": CategoriesScreens(),
        "title": lan2.returntext('categories').toString()
      },
      {
        "page": FavoritesScreen(),
        "title": lan2.returntext('your_favorites').toString()
      }
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEN ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(_pages![_selectedIndexpage]["title"].toString()),
          ),
          body: _pages![_selectedIndexpage]["page"] as Widget,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndexpage,
            selectedItemColor: Theme.of(context).secondaryHeaderColor,
            unselectedItemColor: Colors.white,
            onTap: _selecpage,
            items: [
              BottomNavigationBarItem(
                label: lan.returntext('categories').toString(),
                icon: const Icon(Icons.category),
              ),
              BottomNavigationBarItem(
                label: lan.returntext('your_favorites').toString(),
                icon: const Icon(Icons.star),
              ),
            ],
            backgroundColor: Theme.of(context).primaryColor,
          ),
          drawer: MainDrawer(),
        ),
      ),
    );
  }
}
