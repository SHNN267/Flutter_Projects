import 'package:flutter/material.dart';
import 'package:mealapp/2.2%20dummy_data.dart';
import 'package:mealapp/models/category.dart';
import 'package:mealapp/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealProvider with ChangeNotifier {
  Map<String?, bool?> filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };
  List<Category> avaibleCategory = [];

  List<Meal> avaiableMeals = DUMMY_MEALS;
  List<Meal> favoratemeal = [];
  List<String> prefsMealId = [];
  List<String> newfavorite = [];

  void Togglefolters(String mealid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final existingindex =
        favoratemeal.indexWhere((meal) => meal.id!.contains(mealid));
    if (existingindex >= 0) {
      favoratemeal.removeAt(existingindex);
      prefsMealId.remove(mealid);
    } else {
      favoratemeal
          .add(DUMMY_MEALS.firstWhere((meal) => meal.id!.contains(mealid)));
      prefsMealId.add(mealid);
    }

    preferences.setStringList('prefsMealId', prefsMealId);

    notifyListeners();
  }

  bool ismealfavorate(String mealid) {
    return favoratemeal.any((meal) => meal.id!.contains(mealid));
  }

  void editCategory() {
    List<Category> ac = [];
    avaiableMeals.forEach((meal) {
      meal.categories!.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((element) => element.id!.contains(catId))) {
              ac.add(cat);
            }
          }
        });
      });
    });
    avaibleCategory = ac;
  }

  void setfelters() async {
    avaiableMeals = DUMMY_MEALS.where((meal) {
      if (filters["gluten"]! && !meal.isGlutenFree!) {
        return false;
      }
      if (filters["lactose"]! && !meal.isLactosefree!) {
        return false;
      }
      if (filters["vegan"]! && !meal.isVegan!) {
        return false;
      }
      if (filters["vegetarian"]! && !meal.isVvegetarian!) {
        return false;
      }
      return true;
    }).toList();
    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("gluten", filters["gluten"]!);
    preferences.setBool("lactose", filters["lactose"]!);
    preferences.setBool("vegan", filters["vegan"]!);
    preferences.setBool("vegetarian", filters["vegetarian"]!);
  }

  void getFilters() {
    avaiableMeals = DUMMY_MEALS.where((meal) {
      if (filters["gluten"]! && meal.isGlutenFree!) {
        return false;
      }
      if (filters["lactose"]! && meal.isLactosefree!) {
        return false;
      }
      if (filters["vegan"]! && !meal.isVegan!) {
        return false;
      }
      if (filters["vegetarian"]! && meal.isVvegetarian!) {
        return false;
      }
      return true;
    }).toList();
    notifyListeners();
  }

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    filters["gluten"] = preferences.getBool('gluten') ?? false;
    filters["lactose"] = preferences.getBool('lactose') ?? false;
    filters["vegan"] = preferences.getBool('vegan') ?? false;
    filters["vegetarian"] = preferences.getBool('vegetarian') ?? false;
    newfavorite = preferences.getStringList('prefsMealId') ?? [];

    for (String mealId in newfavorite) {
      final existingindex =
          favoratemeal.indexWhere((meal) => meal.id!.contains(mealId));
      if (existingindex < 0) {
        favoratemeal.add(
            DUMMY_MEALS.firstWhere((element) => element.id!.contains(mealId)));
      }
    }

    notifyListeners();
  }
}
