import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../authenticationsscreen/google.dart';
import '../authenticationsscreen/loginscreen.dart';
import '../authenticationsscreen/registerscreen.dart';
import '../constants/appcolorsconst.dart';
import '../constants/imagesconst.dart';
import '../utils/responsivescreen.dart';
import '../widget/reusable_button.dart';


class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  GoogleSignInController googleController= Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Top image


        Stack(
        children: [
        // 🔹 Background Image
        Container(
        height: ResponsiveHelpers.h(500),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(AppImages.welcomeBackgournd),
            fit: BoxFit.cover,
          ),
        ),
      ),

      // 🔹 Black Overlay
      Container(
        height: ResponsiveHelpers.h(500),
        width: double.infinity,
        color: Colors.black.withOpacity(0.7),
      ),

      // 🔹 Logo Bilkul Top Center
      Positioned(
        top: ResponsiveHelpers.h(-60),
        left: ResponsiveHelpers.h(-20),
        right: 0,
        child: Image.asset(
          AppImages.appLogo2,
          width: ResponsiveHelpers.w(500),
          height: ResponsiveHelpers.h(300),
          fit: BoxFit.contain,
        ),
      ),

      // 🔹 Texts (center me)
      Positioned(
        top: ResponsiveHelpers.h(280), // logo ke neeche thoda gap
        left: 0,
        right: 0,
        child: Column(
          children: [
            Text(
              "India's Number #1",
              style: GoogleFonts.poppins(
                fontSize: ResponsiveHelpers.sp(28),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "AI Text to Speech",
              style: GoogleFonts.poppins(
                fontSize: ResponsiveHelpers.sp(22),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      ],
    ),


    SizedBox(height: 20,),
            /// Buttons
            Column(
              children: [
                _buildActionButton(
                  text: "Welcome Back! Sign In",
                  onPressed: () {
                   Get.to(()=>LoginScreen());
                  },
                  backgroundColor: AppColors.greencolor, // ✅ green button
                  textColor: Colors.white,

                  width: ResponsiveHelpers.w(350),
                  height: ResponsiveHelpers.h(50),

                ),
                SizedBox(height: ResponsiveHelpers.h(20)),
                _buildActionButton(
                  text: "New User? Sign Up",
                  onPressed: () {
                    Get.to(()=>Registerscreen());
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                  width: ResponsiveHelpers.w(350),
                  height: ResponsiveHelpers.h(50),
                ),
                SizedBox(height: ResponsiveHelpers.h(20)),
                ReusableButton(
                  onPressed: () {

                    googleController.signInWithGoogle(); // existing mobile method


                  },
                  text: "Sign In With Google",
                  textColor: AppColors.white,
                  backgroundColor: Colors.black,
                  width: ResponsiveHelpers.w(350),
                  height: ResponsiveHelpers.h(50),
                  borderRadius: 25,
                  fontFamily: GoogleFonts.poppins().fontFamily,

borderColor: Colors.white,
                  borderWidth: 3,
                  imagePath: AppImages.googleIcon,
                ),
                SizedBox(height: ResponsiveHelpers.h(16)),

              ],
            ),
            SizedBox(height: ResponsiveHelpers.h(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    Color? borderColor,
    double? width,
    double? height,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ReusableButton(
        text: text,
        isShimmer: true,
        shimmerDuration: const Duration(seconds: 3),
        onPressed: onPressed,
        width: width ?? 100,
        height: height ?? 30,
        borderRadius: 25,
        fontSize: 17,
        backgroundColor: backgroundColor,
        textColor: textColor,
        borderColor: borderColor ?? Colors.transparent,
        borderWidth: borderColor != null ? 1 : 0,
        icon: icon,
        fontFamily: GoogleFonts.poppins().fontFamily, // ✅ Baloo2
      ),
    );
  }
}
