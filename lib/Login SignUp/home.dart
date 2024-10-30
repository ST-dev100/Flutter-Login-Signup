import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/Login%20SignUp/Login.dart';
import 'package:loginsignup/Login%20SignUp/Widgets/button.dart';
import 'package:loginsignup/Services/authentication.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center the children horizontally
          children: [
            Text(
              "Congratulations! You have successfully logged in.",
              textAlign: TextAlign.center, // Center the text
              style: TextStyle(fontSize: 20), // Add some styling to the text
            ),
            const SizedBox(height: 20), // Add some space between the text and button
            MyButton(
              onTab: () async {
                await AuthService().signOut(); // Call signOut method
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              text: "Logout",
            ),
          ],
        ),
      ),
    );
  }
}
