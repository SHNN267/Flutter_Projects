import 'package:flutter/material.dart';
import 'package:gymapp/screens/home_page.dart';
import 'package:gymapp/screens/player_details.dart';
import 'package:gymapp/screens/upload_image.dart';
import 'package:gymapp/screens/view_advertisement.dart';

class MyRoutes {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
        HomePage.page_route: (context) => HomePage(),
        PlayerDetails.page_route: (context) => PlayerDetails(),
        AdvertisementScreen.page_route: (context) => AdvertisementScreen(),
        ViewAdvertisement.page_route: (context) => ViewAdvertisement(),
      };
}
