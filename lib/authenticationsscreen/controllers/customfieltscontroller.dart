import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RegistrationController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  var isOtpLoading = false.obs;
  final Random _random = Random(); // Create a Random object for generating random numbers
  var randomNumber = 0.obs;

  void generateRandomNumber() {
    randomNumber.value = 100000 + _random.nextInt(900000); // Generates a random 4-digit number
  }


  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // Set login status to true
  }
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;
   final formKey = GlobalKey<FormState>();
   final formKey1 = GlobalKey<FormState>();
   final formKey2 = GlobalKey<FormState>();
   final formKey3 = GlobalKey<FormState>();

  var phoneNumberLength = 0.obs;

  static Future<void> savePhoneNumber({required String phone}) async {
    final prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString("user_phone", phone); // Save phone number

    if (isSaved) {
      print("Phone number saved successfully: $phone"); // ✅ Print success message
    } else {
      print("Failed to save phone number."); // ❌ Print failure message
    }
  }
  static Future<void> saveEmail({required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString("user_email", email); // Save email instead of phone

    if (isSaved) {
      print("Email saved successfully: $email"); // ✅ Success
    } else {
      print("Failed to save email."); // ❌ Failure
    }
  }
  static Future<void> saveGame({required String game}) async {
    final prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString("Game", game); // Save phone number

    if (isSaved) {
      print("Phone number saved successfully: $game"); // ✅ Print success message
    } else {
      print("Failed to save phone number."); // ❌ Print failure message
    }
  }

  static Future<String?> getGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("Game");
  }

  static Future<String?> getPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_phone");
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_email");
  }

  // ✅ Remove phone number (for logout)
  static Future<void> removePhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_phone");
  }
// Observable for phone number length
}

class LoginAuthController extends GetxController {

  var isLoggedIn = false.obs;
  RxString freezeStatus = "Normal!".obs;

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }}