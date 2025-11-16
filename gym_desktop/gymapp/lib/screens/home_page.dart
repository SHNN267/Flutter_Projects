import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp/constants/colors/Mycolors.dart';
import 'package:gymapp/constants/fonts/Myfonts.dart';
import 'package:gymapp/constants/strings/mystring.dart';
import 'package:gymapp/cubit/player_cubit/player_cubit.dart';
import 'package:gymapp/cubit/player_cubit/player_cubit_state.dart';
import 'package:gymapp/screens/player_details.dart';
import 'package:gymapp/screens/upload_image.dart';
import 'package:gymapp/utilis/models/player_model.dart';
import 'package:gymapp/widgets/helper_widget/mybutton.dart';
import 'package:gymapp/widgets/helper_widget/mytext_form_fild.dart';
import 'package:gymapp/widgets/widget_for_screens/player_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String page_route = "HomePage";

  // Text controllers
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController coach = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController hight = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController status = TextEditingController();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DatabaseCubit>().getAllPlayersCubit();
    });
  }

  // 🔹 Helper: show loading dialog
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  // 🔹 Helper: success message
  void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: MyFontStyle.normal(color: MyColor.white)),
        backgroundColor: MyColor.primary_color,
      ),
    );
  }

  // 🔹 Helper: error message
  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: MyFontStyle.normal(color: MyColor.white)),
        backgroundColor: MyColor.red,
      ),
    );
  }

  // 🔹 Helper: clear text fields
  void clearAllFields() {
    widget.name.clear();
    widget.password.clear();
    widget.age.clear();
    widget.phone.clear();
    widget.coach.clear();
    widget.gender.clear();
    widget.hight.clear();
    widget.weight.clear();
    widget.status.clear();
    widget.type.clear();
  }

  // 🔹 Helper: show add player dialog
  void showAddPlayerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Center(
          child: Text(
            MyStrings.add_new_player,
            style: MyFontStyle.mainTitle(color: MyColor.black),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              MyTextFormFild(
                labelText: MyStrings.enter_name,
                controller: widget.name,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_password,
                controller: widget.password,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_age,
                controller: widget.age,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_phone_number,
                controller: widget.phone,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_coach_name,
                controller: widget.coach,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_gender,
                controller: widget.gender,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_hight,
                controller: widget.hight,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_wight,
                controller: widget.weight,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_status,
                controller: widget.status,
              ),
              MyTextFormFild(
                labelText: MyStrings.enter_the_type,
                controller: widget.type,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButton(
                text: MyStrings.cancle,
                backgroundColor: MyColor.red,
                onPressed: () => Navigator.pop(context),
              ),
              MyButton(
                text: MyStrings.add,
                onPressed: () async {
                  if (widget.name.text.isNotEmpty &&
                      widget.password.text.isNotEmpty &&
                      widget.age.text.isNotEmpty &&
                      widget.phone.text.isNotEmpty &&
                      widget.coach.text.isNotEmpty &&
                      widget.gender.text.isNotEmpty &&
                      widget.hight.text.isNotEmpty &&
                      widget.weight.text.isNotEmpty &&
                      widget.status.text.isNotEmpty &&
                      widget.type.text.isNotEmpty) {
                    showLoadingDialog(context);
                    try {
                      await context.read<DatabaseCubit>().AddNewPlayerCubit(
                        name: widget.name.text.trim(),
                        age: widget.age.text.trim(),
                        phoneNumber: widget.phone.text.trim(),
                        coachName: widget.coach.text.trim(),
                        height: widget.hight.text.trim(),
                        weight: widget.weight.text.trim(),
                        gender: widget.gender.text.trim(),
                        type: widget.type.text.trim(),
                        situation: false,
                        status: widget.status.text.trim(),
                        password: widget.password.text.trim(),
                      );

                      await context.read<DatabaseCubit>().getAllPlayersCubit();

                      clearAllFields();
                      Navigator.pop(context); // close loading
                      Navigator.pop(context); // close dialog
                      showSuccessMessage(
                        context,
                        MyStrings.Player_added_successfully,
                      );
                    } catch (e) {
                      Navigator.pop(context);
                      showErrorMessage(
                        context,
                        MyStrings.Error_occurred_while_adding_player,
                      );
                    }
                  } else {
                    showErrorMessage(context, MyStrings.full_all_field);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyStrings.fittnessGym,
          style: MyFontStyle.mainTitle(color: MyColor.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AdvertisementScreen.page_route);
          },
          icon: Icon(Icons.campaign, size: 30, color: MyColor.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<DatabaseCubit, DataBaseState>(
          builder: (context, state) {
            final players = context.watch<DatabaseCubit>().globalAllPlayerList;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 15,
                childAspectRatio: 0.81,
              ),
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return PlayerCard(
                  onTap: () {},
                  age: player.age ?? "",
                  date: player.date ?? "",
                  gender: "",
                  height: player.height ?? "",
                  name: player.name ?? "",
                  weight: player.weight ?? "",
                  memberId: player.id ?? 1,
                  his_coch: player.coachName ?? "",
                  phoneNumber: player.phoneNumber ?? "",

                  deleteFunction: () async {
                    deletePlayerFunction(context, player);
                  },
                  more_details: () {
                    Navigator.pushNamed(
                      context,
                      PlayerDetails.page_route,
                      arguments: player,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => showAddPlayerDialog(context),
      ),
    );
  }

  void deletePlayerFunction(BuildContext context, Player player) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Do you want to delete this item ?",
          style: MyFontStyle.mainTitle(color: MyColor.black),
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
                  showLoadingDialog(context);
                  try {
                    await context.read<DatabaseCubit>().deletePlayer(
                      id: player.id!,
                    );
                    await context.read<DatabaseCubit>().getAllPlayersCubit();

                    Navigator.pop(context); // close loading
                    showSuccessMessage(context, MyStrings.add_player_sucsess);
                  } catch (e) {
                    showErrorMessage(context, MyStrings.error_while_deleting);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
