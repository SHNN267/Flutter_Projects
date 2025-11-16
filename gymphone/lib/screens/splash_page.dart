import 'package:flutter/material.dart';
import 'package:gymphone/screens/login_page.dart';

class SplashScreen extends StatelessWidget {
  Future<void> _navigateToHome(BuildContext context) async {
    // Wait 3 seconds (simulate loading or initialization)
    await Future.delayed(Duration(seconds: 3));

    // Navigate to HomePage and remove SplashScreen from stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Start the future once when widget builds
    _navigateToHome(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.jpg", width: 300, height: 300),
            SizedBox(height: 20),
            Text(
              "Welcome in Fitness GYM",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
