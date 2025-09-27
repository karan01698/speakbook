import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appcolorsconst.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const AppText(
      this.text, {
        super.key,
        this.fontSize = 16,
        this.color = Colors.black,
        this.fontWeight = FontWeight.normal,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.baloo2(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}



class AppTexts {
  static const String welcome = "Welcome back! Glad to see you!";

  static const String emailHint = "Enter your email";
  static const String passwordHint = "Enter your password";
  static const String forgotPassword = "Forgot Password?";
  static const String login = "Sign In";
  static const String orLoginWith = "Or New User?";
  static const String orRegisterWith = "Or Register with";
  static const String dontHaveAccount = "Don’t have an account?";
  static const String registerNow = "Sign Up Now";
  static const String enterName = "Enter Your Name";
  static const String register = "Sign Up";
  static const String loginNow = "Sign In Now";
  static const String alreadyHave = "Already have an account?";
  static const String welcomeRegi = "Already Register to get started";
  static const String subs = "SUBSCRIPTION";

}
class AppTextStyles {
  static TextStyle title = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle subtitle = TextStyle(fontSize: 16, color: Colors.grey);
  static TextStyle code = GoogleFonts.baloo2(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2,color: AppColors.getotp);
  static const TextStyle heading = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const TextStyle body = TextStyle(fontSize: 16, height: 1.6);
}