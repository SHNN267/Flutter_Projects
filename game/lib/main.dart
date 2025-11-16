import 'package:flutter/material.dart';
import 'package:game/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF00061a),
          shadowColor: const Color(0xFF001456),
          splashColor: const Color(0xFF4169e8),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
