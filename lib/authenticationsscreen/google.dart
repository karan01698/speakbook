
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/authenticationcontroller.dart';
import '../screens/home.dart';
import 'controllers/customfieltscontroller.dart';

class  GoogleSignInController extends GetxController {
  var user = Rxn<User>();
  var mailss = "".obs;
  final RegisterController controllerss = Get.put(RegisterController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  void onInit() {
    super.onInit();

    _auth.idTokenChanges().listen((User? user) async {
      if (user != null) {
        final token = await user.getIdToken();
        print("🔄 Initial Firebase Token: $token");
      }
    });
  }


  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        // clientId: "437953463717-kd2gsdouad06o6lonh5cmq3uu99f6vam.apps.googleusercontent.com",
      );
      await _googleSignIn.signOut(); // Ensure the picker appears
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("❌ User canceled Google Sign-In");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
          credential);
      user.value = userCredential.user;

      print("✅ Google Sign-In Successful! User: ${user.value?.email}");
      Get.find<AppBarController>().login();
      controller.saveLoginState();

      // ✅ Add this guard to prevent multiple executions
      bool alreadyHandled = false;

      _auth.authStateChanges().listen((User? firebaseUser) async {
        if (alreadyHandled) return;
        alreadyHandled = true;

        user.value = firebaseUser;
        if (firebaseUser != null) {
          print("✅ User Logged In: ${firebaseUser.email}");
          await saveLoginState();
          await saveEmailToPreferences(firebaseUser.email);

          final newUser = UserModel(
            phone: firebaseUser.email ?? "",
            password: "",

            name: firebaseUser.displayName ?? "",
            email: firebaseUser.email ?? "",

            token: "SJELQJEHFOJLKDJ", CPassword: "", dob: '',

          );

          print("📌 Registering user in backend...");
          bool isLoggedIn = await controllerss.registerUser(newUser);

          if (isLoggedIn) {
            final authController = Get.find<AuthControllersss>();
            await authController.setLoggedIn(true);
            Get.find<AppBarController>().login();
            RegistrationController.saveEmail(
                email: firebaseUser.email ?? "");
            Get.snackbar("Registered", "Registered Successfully",
                backgroundColor: Colors.green, colorText: Colors.white);
            Get.offAll(() => TranslateSpeakScreen());

            await Future.delayed(Duration(milliseconds: 300));
          } else {
            RegistrationController.saveEmail(
                email: firebaseUser.email ?? "");
            Get.snackbar("Registered", "Registered Successfully",
                backgroundColor: Colors.green, colorText: Colors.white);
            Get.offAll(() => TranslateSpeakScreen());
          }
        } else {
          print("❌ No authenticated user found.");
        }
      });
    } catch (e) {
      print('❌ Error signing in with Google: $e');
      Get.snackbar("Sign-In Error", "Something went wrong. Please try again.");
    }
  }

  // ✅ Save login state
  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  // ✅ Save user email
  Future<void> saveEmailToPreferences(String? email) async {
    if (email != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
    }
  }

  // ✅ Sign out
  // Future<void> signOut() async {
  //   await _auth.signOut();
  //   await _googleSignIn.signOut();
  //   user.value = null;
  //   Get.offAll(() => SplashScreen()); // Navigate to splash screen
  // }

  // // ✅ Retrieve stored email
  // Future<void> getEmailFromPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   mailss.value = prefs.getString('email') ?? "No email found";
  // }


}