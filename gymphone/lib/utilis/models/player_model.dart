import 'package:gymphone/constants/api/api_keys.dart';

class Player {
  final int? id;
  final String? name;
  final String? age;
  final String? phoneNumber;
  final String? height;
  final String? weight;
  final String? coachName;
  final String? date;
  final List<String>? chest;
  final List<String>? biceps;
  final List<String>? triceps;
  final List<String>? back;
  final List<String>? abs;
  final List<String>? shoulders;
  final List<String>? legs;
  final List<String>? mealPlan;
  final String? type;
  final bool? situation;

  Player({
    this.coachName,
    this.date,
    this.chest,
    this.biceps,
    this.triceps,
    this.back,
    this.abs,
    this.shoulders,
    this.legs,
    this.mealPlan,
    this.type,
    this.situation,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.phoneNumber,
    required this.id,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json[API_Keys.id] ?? 0,
      name: json[API_Keys.name] ?? "",
      age: json[API_Keys.age] ?? "",
      phoneNumber: json[API_Keys.phone_number] ?? "",
      height: json[API_Keys.height] ?? "",
      weight: json[API_Keys.weight] ?? "",
      coachName: json[API_Keys.coach_name] ?? "",
      date: json[API_Keys.date] ?? "",
      chest: List<String>.from(json[API_Keys.chest] ?? []),
      biceps: List<String>.from(json[API_Keys.biceps] ?? []),
      triceps: List<String>.from(json[API_Keys.triceps] ?? []),
      back: List<String>.from(json[API_Keys.back] ?? []),
      abs: List<String>.from(json[API_Keys.abs] ?? []),
      shoulders: List<String>.from(json[API_Keys.shoulders] ?? []),
      legs: List<String>.from(json[API_Keys.legs] ?? []),
      mealPlan: List<String>.from(json[API_Keys.meal_plan] ?? []),
      type: json[API_Keys.type] ?? "",
      situation: json[API_Keys.situation] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      API_Keys.id: id,
      API_Keys.name: name,
      API_Keys.age: age,
      API_Keys.phone_number: phoneNumber,
      API_Keys.height: height,
      API_Keys.weight: weight,
      API_Keys.coach_name: coachName,
      API_Keys.date: date,
      API_Keys.chest: chest,
      API_Keys.biceps: biceps,
      API_Keys.triceps: triceps,
      API_Keys.back: back,
      API_Keys.abs: abs,
      API_Keys.shoulders: shoulders,
      API_Keys.legs: legs,
      API_Keys.meal_plan: mealPlan,
      API_Keys.type: type,
      API_Keys.situation: situation,
    };
  }
}
