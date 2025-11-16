import 'dart:convert';

import 'package:gymphone/utilis/connection_manager/response.dart';
import 'package:gymphone/utilis/models/advirtisement.dart';
import 'package:gymphone/utilis/models/player_model.dart';
import 'package:http/http.dart' as http;

class ConnectionFunctions {
  static const String baseURL = "http://mohammedgym22.pythonanywhere.com/main";

  // ✅ Login Player Function (with nested "player" in response)
  static Future<MyResponse> LoginPlayer({
    required String phoneNumber,
    required String password,
  }) async {
    var loginURL = Uri.parse("$baseURL/login-player/");

    Map<String, dynamic> body = {
      "phone_number": phoneNumber,
      "password": password,
    };

    try {
      var response = await http.post(
        loginURL,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // ✅ Extract the player object from the response
        var playerJson = data["player"];
        Player player = Player.fromJson(playerJson);

        return MyResponse(statuscode: 200, body: player);
      } else {
        print("❌ Login failed: ${response.body}");
        throw Exception("login failed");
      }
    } catch (e) {
      print("⚠️ Exception during login: $e");
      throw Exception("error during login");
    }
  }

  static const baseURL2 = "http://mohammedgym22.pythonanywhere.com";

  // get all advert
  static Future<MyResponse> getAllAdvertisements() async {
    var response = await http.get(
      Uri.parse("$baseURL2/advertisements/create-advert/"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Advertisement> advertisementsList = [];

      for (var element in data) {
        Advertisement ad = Advertisement.fromJson(element);
        advertisementsList.add(ad);
      }

      return MyResponse(statuscode: 200, body: advertisementsList);
    } else {
      throw Exception("erron in advertisment");
    }
  }
}
