import 'dart:convert';
import 'dart:io';

import 'package:gymapp/constants/strings/mystring.dart';
import 'package:gymapp/utilis/connection_manager/response.dart';
import 'package:gymapp/utilis/models/advirtisement.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AdvertConnectionFunction {
  static const baseURL = "http://mohammedgym22.pythonanywhere.com";

  // get all advert
  static Future<MyResponse> getAllAdvertisements() async {
    var response = await http.get(
      Uri.parse("$baseURL/advertisements/create-advert/"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Advertisement> advertisementsList = [];

      for (var element in data) {
        Advertisement ad = Advertisement.fromJson(element);
        advertisementsList.add(ad);
      }

      return MyResponse(statusCode: 200, body: advertisementsList);
    } else {
      throw Exception(MyStrings.error_in_connection);
    }
  }

  // upload advertisement

  static Future<MyResponse> uploadAdvertisement({
    required String title,
    required String content,
    required bool isActive,
    required File imageFile,
  }) async {
    var uri = Uri.parse("$baseURL/advertisements/create-advert/");

    try {
      var request = http.MultipartRequest('POST', uri);

      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['is_active'] = isActive.toString();

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("success upload");
        return MyResponse(statusCode: response.statusCode, body: data);
      } else {
        return MyResponse(
          statusCode: response.statusCode,
          body: "Upload failed: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception(MyStrings.error_in_connection);
    }
  }

  // delete advert
  static Future<MyResponse> deleteAdvertisement({required int id}) async {
    try {
      final deleteURL = Uri.parse("$baseURL/advertisements/info/$id/");
      final response = await http.delete(deleteURL);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return MyResponse(
          statusCode: response.statusCode,
          body: "Advertisement deleted successfully",
        );
      } else {
        return MyResponse(
          statusCode: response.statusCode,
          body: "Failed to delete advertisement",
        );
      }
    } catch (e) {
      return MyResponse(statusCode: 500, body: e.toString());
    }
  }
}
