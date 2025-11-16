import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp/constants/colors/Mycolors.dart';
import 'package:gymapp/constants/routes/routes_screen.dart';
import 'package:gymapp/cubit/advirtesement_cubit/advirtesement_cubit.dart';
import 'package:gymapp/cubit/player_cubit/player_cubit.dart';
import 'package:gymapp/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseCubit>(create: (context) => DatabaseCubit()),
        BlocProvider<AdvertisementCubit>(
          create: (context) => AdvertisementCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
          appBarTheme: AppBarTheme(
            backgroundColor: MyColor.primary_color,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          scaffoldBackgroundColor: MyColor.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: MyColor.primary_color,
            brightness: Brightness.light,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: MyColor.primary_color,
            foregroundColor: MyColor.white,
          ),
        ),

        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: MyRoutes.routes,
      ),
    );
  }
}
