import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemesProvider with ChangeNotifier {
  MaterialColor primaryColor = Colors.pink;
  MaterialColor secondryColor = Colors.amber;
  var tm = ThemeMode.light;
  String modethme = 'Light';

  changeColorTheme(Color primary, Color secondry) async {
    primaryColor = toMaterialColr(primary.value);
    secondryColor = toMaterialColr(secondry.value);
    SharedPreferences setColorTheme = await SharedPreferences.getInstance();
    setColorTheme.setString('primary', primary.value.toString());
    setColorTheme.setString('secondry', secondry.value.toString());
    notifyListeners();
  }

  getColortheme() async {
    SharedPreferences setColorTheme = await SharedPreferences.getInstance();
    String P = setColorTheme.getString('primary') ?? '0xFF884A39';
    String S = setColorTheme.getString('secondry') ?? '0xFFF9E0BB';
    for (int i = 0; i < colorthemeList.length; i++) {
      if (colorthemeList[i]["primary"]!.value.toString().contains(P)) {
        primaryColor = toMaterialColr(colorthemeList[i]["primary"]!.value);
      }
      if (colorthemeList[i]["secondry"]!.value.toString().contains(S)) {
        secondryColor = toMaterialColr(colorthemeList[i]["secondry"]!.value);
      }
    }
    notifyListeners();
  }

  List<Map<String, Color>> colorthemeList = [
    {"primary": const Color(0xFF884A39), "secondry": const Color(0xFFF9E0BB)},
    {"primary": const Color(0xFF0079FF), "secondry": const Color(0xFFFF0060)},
    {"primary": const Color(0xFF116D6E), "secondry": const Color(0xFFCD1818)},
    {"primary": const Color(0xFFB70404), "secondry": const Color(0xFFFFE569)},
    {"primary": const Color(0xFF025464), "secondry": const Color(0xFF62B6B7)},
    {"primary": const Color(0xFF0C134F), "secondry": const Color(0xFF85586F)},
    {"primary": const Color(0xFF1A120B), "secondry": const Color(0xFFE5E5CB)},
    {"primary": const Color(0xFFE91E63), "secondry": const Color(0xFFFFC107)},
    {"primary": const Color(0xFF2192FF), "secondry": const Color(0xFFFDFF00)},
  ];

  MaterialColor toMaterialColr(colorVal) => MaterialColor(
        colorVal,
        <int, Color>{
          50: const Color(0xFFFCE4EC),
          100: const Color(0xFFF8BBD0),
          200: const Color(0xFFF48FB1),
          300: const Color(0xFFF06292),
          400: const Color(0xFFEC407A),
          500: Color(colorVal),
          600: const Color(0xFFD81B60),
          700: const Color(0xFFC2185B),
          800: const Color(0xFFAD1457),
          900: const Color(0xFF880E4F),
        },
      );

  changeThemeMode(ThemeMode mode) async {
    tm = mode;
    getThmeMode(mode);

    SharedPreferences preferencesThemeMode =
        await SharedPreferences.getInstance();

    modethme = (mode == ThemeMode.dark) ? 'Dark' : 'Light';
    preferencesThemeMode.setString('M', modethme);

    notifyListeners();
  }

  getThmeMode(ThemeMode themeparameter) {
    if (themeparameter == ThemeMode.light) {
      modethme = 'Light';
    } else if (themeparameter == ThemeMode.dark) {
      modethme = 'Dark';
    } else {
      modethme = 'System';
    }
  }

  getThemeModeshared() async {
    SharedPreferences preferencesThemeMode =
        await SharedPreferences.getInstance();

    modethme = preferencesThemeMode.getString('M') ?? 'Light';
    if (modethme == 'Light') {
      tm = ThemeMode.light;
    } else if (modethme == 'Dark') {
      tm = ThemeMode.dark;
    } else {
      tm = ThemeMode.system;
    }

    notifyListeners();
  }
}
