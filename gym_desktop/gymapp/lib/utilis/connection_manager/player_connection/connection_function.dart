import 'dart:convert';

import 'package:gymapp/constants/api/api_keys.dart';
import 'package:gymapp/constants/strings/mystring.dart';
import 'package:gymapp/utilis/connection_manager/response.dart';
import 'package:gymapp/utilis/models/player_model.dart';
import 'package:http/http.dart' as http;

class ConnectionFunctions {
  static const baseURL = "http://mohammedgym22.pythonanywhere.com/main";
  static Future<MyResponse> GetAllPlayers() async {
    var jsonData = await http.get(Uri.parse("$baseURL/players/"));
    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);
      List<Player> PlayerListFromAPI = [];
      for (var element in data) {
        Player player = Player.fromJson(element);
        PlayerListFromAPI.add(player);
      }
      return MyResponse(statusCode: 200, body: PlayerListFromAPI);
    } else {
      throw Exception(MyStrings.error_in_connection);
    }
  }

  // Get Player From His ID

  static Future<MyResponse> GetPlayerFromID({required int id}) async {
    var jsonData = await http.get(Uri.parse("$baseURL/player/$id/"));
    if (jsonData.statusCode == 200) {
      var data = jsonDecode(jsonData.body);
      Player player = Player.fromJson(data);
      return MyResponse(statusCode: 200, body: player);
    } else {
      throw Exception(MyStrings.error_in_connection);
    }
  }

  // add player fucntion

  static Future<MyResponse> AddPlayer({
    required String name,
    required String age,
    required String phoneNumber,
    required String coachName,
    required String height,
    required String weight,
    required String gender,
    required String type,
    required bool situation,
    required String status,
    required String password,
  }) async {
    var url = Uri.parse("$baseURL/add-player/");
    Map<String, dynamic> body = {
      API_Keys.name: name,
      API_Keys.age: age,
      API_Keys.phone_number: phoneNumber,
      API_Keys.coach_name: coachName,
      API_Keys.height: height,
      API_Keys.weight: weight,
      API_Keys.gender: gender,
      API_Keys.type: type,
      API_Keys.situation: situation,
      API_Keys.status: status,
      API_Keys.password: password,
    };
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Player newPlayer = Player.fromJson(
        data,
      ); // Assuming API returns the created player
      return MyResponse(statusCode: response.statusCode, body: newPlayer);
    } else {
      throw Exception("Error adding player: ${response.body}");
    }
  }

  static Future<void> deletePlayerFromID({required int id}) async {
    final dleteURL = Uri.parse("$baseURL/delete/$id/");
    final response = await http.delete(dleteURL);
    if (response.statusCode == 200) {
      print("delete completed");
    } else {
      throw Exception("problem in delete");
    }
  }

  static Future<MyResponse> EditPlayer({
    required int id,
    String? name,
    String? date,
    String? age,
    String? phoneNumber,
    String? coachName,
    String? height,
    String? weight,
    List<String>? chest,
    List<String>? biceps,
    List<String>? triceps,
    List<String>? back,
    List<String>? abs,
    List<String>? shoulders,
    List<String>? legs,
    List<String>? mealPlan,
    String? type,
    bool? situation,
  }) async {
    final url = Uri.parse("$baseURL/update-player/$id/");

    Map<String, dynamic> body = {};

    if (name != null) body[API_Keys.name] = name;
    if (date != null) body[API_Keys.date] = date;
    if (age != null) body[API_Keys.age] = age;
    if (phoneNumber != null) body[API_Keys.phone_number] = phoneNumber;
    if (coachName != null) body[API_Keys.coach_name] = coachName;
    if (height != null) body[API_Keys.height] = height;
    if (weight != null) body[API_Keys.weight] = weight;
    if (chest != null) body[API_Keys.chest] = chest;
    if (biceps != null) body[API_Keys.biceps] = biceps;
    if (triceps != null) body[API_Keys.triceps] = triceps;
    if (back != null) body[API_Keys.back] = back;
    if (abs != null) body[API_Keys.abs] = abs;
    if (shoulders != null) body[API_Keys.shoulders] = shoulders;
    if (legs != null) body[API_Keys.legs] = legs;
    if (mealPlan != null) body[API_Keys.meal_plan] = mealPlan;
    if (type != null) body[API_Keys.type] = type;

    if (situation != null) body[API_Keys.situation] = situation;

    var response = await http.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Player updatedPlayer = Player.fromJson(data);
      return MyResponse(statusCode: response.statusCode, body: updatedPlayer);
    } else {
      throw Exception("Error editing player: ${response.body}");
    }
  }

  // log in fucntion
  // static Future<MyResponse> LoginPlayer({
  //   required String phoneNumber,
  //   required String password,
  // }) async {
  //   var url = Uri.parse("$baseURL/login-player/");

  //   Map<String, dynamic> body = {
  //     "phone_number": phoneNumber,
  //     "password": password,
  //   };

  //   var response = await http.post(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(body),
  //   );

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     return MyResponse(statusCode: response.statusCode, body: data);
  //   } else {
  //     throw Exception("Error logging in: ${response.body}");
  //   }
  // }
}
