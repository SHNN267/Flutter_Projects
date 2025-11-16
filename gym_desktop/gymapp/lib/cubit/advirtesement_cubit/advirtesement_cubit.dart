import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp/cubit/advirtesement_cubit/adviritesment_cubit_state.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  AdvertisementCubit() : super(AdvertisementInitial());

  final String apiUrl =
      "http://mohammedgym22.pythonanywhere.com/advertisements/create-advert/";

  Future<void> uploadAdvertisement({
    required String title,
    required String content,
    required bool isActive,
    required File imageFile,
  }) async {
    emit(AdvertisementLoading());

    try {
      final uri = Uri.parse(apiUrl);
      final request = http.MultipartRequest('POST', uri);

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

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AdvertisementSuccess(responseBody.body));
      } else {
        emit(
          AdvertisementError(
            "Failed: ${response.statusCode} | ${responseBody.body}",
          ),
        );
      }
    } catch (e) {
      emit(AdvertisementError(e.toString()));
    }
  }

  // ========== 1️⃣ Get All Advertisements ==========
  Future<void> getAllAdvertisements() async {
    emit(AdvertisementLoading());
    final url = Uri.parse("${apiUrl}get_all_advertisment/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        emit(AdvertisementSuccess(data.toString()));
      } else {
        emit(
          AdvertisementError(
            "Failed to get advertisements: ${response.statusCode} | ${response.body}",
          ),
        );
      }
    } catch (e) {
      emit(AdvertisementError(e.toString()));
    }
  }

  // ========== 2️⃣ Delete Advertisement ==========
  Future<void> deleteAdvertisement(int id) async {
    emit(AdvertisementLoading());
    final url = Uri.parse("${apiUrl}info/$id/");

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200 || response.statusCode == 204) {
        emit(AdvertisementSuccess("Advertisement deleted successfully."));
      } else {
        emit(
          AdvertisementError(
            "Failed to delete: ${response.statusCode} | ${response.body}",
          ),
        );
      }
    } catch (e) {
      emit(AdvertisementError(e.toString()));
    }
  }
}
