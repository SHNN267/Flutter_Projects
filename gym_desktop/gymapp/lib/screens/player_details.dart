import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp/constants/api/api_keys.dart';
import 'package:gymapp/constants/colors/Mycolors.dart';
import 'package:gymapp/constants/fonts/Myfonts.dart';
import 'package:gymapp/constants/strings/mystring.dart';
import 'package:gymapp/cubit/player_cubit/player_cubit.dart';
import 'package:gymapp/global/helper_functions.dart';
import 'package:gymapp/utilis/models/player_model.dart';
import 'package:gymapp/widgets/helper_widget/mybutton.dart';
import 'package:gymapp/widgets/helper_widget/mytext_form_fild.dart';

class PlayerDetails extends StatefulWidget {
  PlayerDetails({super.key});

  @override
  State<PlayerDetails> createState() => _PlayerDetailsState();
  static const page_route = "PlayerDetails";
  final TextEditingController name = TextEditingController();
  final TextEditingController hight = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController coach = TextEditingController();
  final TextEditingController bi = TextEditingController();
  final TextEditingController tri = TextEditingController();
  final TextEditingController chest = TextEditingController();
  final TextEditingController back = TextEditingController();
  final TextEditingController shoulders = TextEditingController();
  final TextEditingController legs = TextEditingController();
  final TextEditingController meal = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController abs = TextEditingController();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  @override
  Widget build(BuildContext context) {
    final player = ModalRoute.of(context)!.settings.arguments as Player;
    List<List<String>> custumList = [
      ?player.chest,
      ?player.back,
      ?player.triceps,
      ?player.biceps,
      ?player.shoulders,
      ?player.legs,
      ?player.mealPlan,
    ];

    List<String> nameList = [
      "chest",
      "back",
      "triceps",
      "biceps",
      "shoulders",
      "legs",
      "meal_plan",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyStrings.detailes,
          style: MyFontStyle.mainTitle(color: MyColor.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: 7,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.6,
          ),
          itemBuilder: (context, index) {
            List<String> exercises = custumList[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              color: Colors.amber[50],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      nameList[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: exercises.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                exercises[i],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: floatingActionForEditPlayer(context, player),
    );
  }

  MyButton floatingActionForEditPlayer(BuildContext context, Player player) {
    return MyButton(
      backgroundColor: Colors.black,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                MyStrings.edit_program,
                style: MyFontStyle.mainTitle(color: MyColor.black),
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    MyTextFormFild(
                      labelText: API_Keys.name,
                      controller: widget.name,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.height,
                      controller: widget.hight,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.weight,
                      controller: widget.weight,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.phone_number,
                      controller: widget.phone,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.age,
                      controller: widget.age,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.coach_name,
                      controller: widget.coach,
                    ),

                    // Workout sections (split by '-')
                    MyTextFormFild(
                      labelText: API_Keys.chest,
                      controller: widget.chest,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.biceps,
                      controller: widget.bi,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.triceps,
                      controller: widget.tri,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.back,
                      controller: widget.back,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.shoulders,
                      controller: widget.shoulders,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.legs,
                      controller: widget.legs,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.abs,
                      controller: widget.abs,
                    ),

                    // Other info
                    MyTextFormFild(
                      labelText: API_Keys.meal_plan,
                      controller: widget.meal,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.type,
                      controller: widget.type,
                    ),
                    MyTextFormFild(
                      labelText: API_Keys.date,
                      controller: widget.date,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    text: MyStrings.cancle,
                    backgroundColor: MyColor.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  MyButton(
                    text: MyStrings.ok,
                    onPressed: () async {
                      HelperFunctions.showLoadingDialog(context);
                      try {
                        await context.read<DatabaseCubit>().editPlayerCubit(
                          id: player.id!,
                          legs: widget.legs.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.legs.text.toString(),
                                )
                              : player.legs,
                          chest: widget.chest.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.chest.text.toString(),
                                )
                              : player.chest,
                          biceps: widget.bi.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.bi.text.toString(),
                                )
                              : player.biceps,
                          back: widget.back.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.back.text.toString(),
                                )
                              : player.back,
                          triceps: widget.tri.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.tri.text.toString(),
                                )
                              : player.triceps,
                          shoulders: widget.shoulders.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.shoulders.text.toString(),
                                )
                              : player.shoulders,
                          mealPlan: widget.meal.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.meal.text.toString(),
                                )
                              : player.mealPlan,
                          abs: widget.abs.text.toString().isNotEmpty
                              ? HelperFunctions.splitByDash(
                                  widget.abs.text.toString(),
                                )
                              : player.abs,
                          situation: false,
                          type: widget.type.text.isNotEmpty
                              ? widget.type.text.toString()
                              : player.type,

                          age: widget.age.text.isNotEmpty
                              ? widget.age.text.toString()
                              : player.age,
                          coachName: widget.coach.text.isNotEmpty
                              ? widget.coach.text.toString()
                              : player.coachName,
                          date: widget.date.text.isNotEmpty
                              ? widget.date.text.toString()
                              : player.date,
                          height: widget.hight.text.isNotEmpty
                              ? widget.hight.text.toString()
                              : player.height,
                          name: widget.name.text.isNotEmpty
                              ? widget.name.text.toString()
                              : player.name,
                          phoneNumber: widget.phone.text.isNotEmpty
                              ? widget.phone.text.toString()
                              : player.phoneNumber,
                          weight: widget.weight.text.isNotEmpty
                              ? widget.weight.text.toString()
                              : player.weight,
                        );

                        ///
                        await context
                            .read<DatabaseCubit>()
                            .getAllPlayersCubit();

                        Navigator.pop(context); // close loading
                        HelperFunctions.showSuccessMessage(
                          context,
                          MyStrings.player_editing_sucsessfuly,
                        );
                      } catch (e) {
                        HelperFunctions.showErrorMessage(
                          context,
                          MyStrings.error_while_editing,
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
      text: MyStrings.edit_program,
      width: 200,
      height: 75,
      border: BorderSide(color: MyColor.white, width: 3),
    );
  }
}
