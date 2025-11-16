import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp/constants/strings/mystring.dart';
import 'package:gymapp/cubit/player_cubit/player_cubit_state.dart';
import 'package:gymapp/utilis/connection_manager/player_connection/connection_function.dart';
import 'package:gymapp/utilis/connection_manager/response.dart';
import 'package:gymapp/utilis/models/player_model.dart';

class DatabaseCubit extends Cubit<DataBaseState> {
  DatabaseCubit() : super(GetAllPlayerState());
  List<Player> globalAllPlayerList = [];

  Future<void> getAllPlayersCubit() async {
    MyResponse response = await ConnectionFunctions.GetAllPlayers();
    if (response.statusCode == 200) {
      globalAllPlayerList = response.body as List<Player>;
      emit(GetAllPlayerState());
    } else {
      emit(ErrorDatabaseState(MyStrings.erro_in_connection));
    }
  }

  /////
  Future<void> AddNewPlayerCubit({
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
    MyResponse response = await ConnectionFunctions.AddPlayer(
      name: name,
      age: age,
      phoneNumber: phoneNumber,
      coachName: coachName,
      height: height,
      weight: weight,
      gender: gender,
      type: type,
      situation: situation,
      status: status,
      password: password,
    );
    if (response.statusCode == 200) {
      emit(AddNewPlayerState());
      emit(GetAllPlayerState());
    } else {
      emit(ErrorWhenAddPlayer());
    }
  }

  /////
  Future<void> deletePlayer({required int id}) async {
    ConnectionFunctions.deletePlayerFromID(id: id);
    emit(RemovePlayerState());
  }

  Future<void> editPlayerCubit({
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
    MyResponse response = await ConnectionFunctions.EditPlayer(
      id: id,
      age: age,
      coachName: coachName,
      height: height,
      name: name!,
      abs: abs,
      back: back,
      biceps: biceps,
      chest: chest,
      date: date,
      legs: legs,
      mealPlan: mealPlan,
      phoneNumber: phoneNumber,
      shoulders: shoulders,
      situation: situation,
      triceps: triceps,
      type: type,
      weight: weight,
    );
    if (response.statusCode == 200) {
      emit(EditPlayerState());
      print("true editing");
    } else {
      emit(ErrorWhenEditPlayer());
      print("false editing");
    }
  }

  ////
  Future<Player> GetPlayerFromHisIDCubit({required id}) async {
    MyResponse response = await ConnectionFunctions.GetPlayerFromID(id: id);
    if (response.statusCode == 200) {
      emit(GetPlayerFromHisIDState());
    } else {
      emit(ErrorWhenGetPlayerFromHisID());
    }
    return response.body as Player;
  }
}
