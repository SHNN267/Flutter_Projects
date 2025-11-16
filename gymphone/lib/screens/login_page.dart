import 'package:flutter/material.dart';
import 'package:gymphone/constants/colos/Mycolors.dart';
import 'package:gymphone/constants/fonts/Myfonts.dart';
import 'package:gymphone/screens/player_details.dart';
import 'package:gymphone/utilis/connection_manager/connection_manager_app.dart';
import 'package:gymphone/utilis/connection_manager/response.dart';
import 'package:gymphone/utilis/models/player_model.dart';
import 'package:gymphone/widgets/helper_widgets/mybutton.dart';
import 'package:gymphone/widgets/helper_widgets/mytext_form_fild.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColor.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text("Login Player", style: MyFontStyle.mainTitle()),
            Image.asset("assets/images/logo.jpg", width: 200, height: 200),

            MyTextFormFild(
              controller: phone,
              keyboardType: TextInputType.number,
              enabledBorderColor: Colors.grey,
              labelText: "Enter your phone number",
              backgroundColor: MyColor.white,
              borderRadius: 0,
            ),
            SizedBox(height: 30),
            MyTextFormFild(
              controller: password,
              enabledBorderColor: Colors.grey,
              labelText: "enter your password",
              backgroundColor: MyColor.white,
              borderRadius: 0,
            ),
            SizedBox(height: 40),
            MyButton(
              text: "login",
              onPressed: () async {
                MyResponse response = await ConnectionFunctions.LoginPlayer(
                  phoneNumber: phone.text,
                  password: password.text,
                );
                Player player = response.body as Player;
                print(player.name);
                if (response.statuscode == 200 || response.statuscode == 201) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(player: player),
                    ),
                  );
                }
              },

              backgroundColor: Colors.black,
              width: 200,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
