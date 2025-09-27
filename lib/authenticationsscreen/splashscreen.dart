import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/appcolorsconst.dart';
import '../constants/apptextconst.dart';
import '../constants/imagesconst.dart';
import '../screens/welcomescreen.dart';
import '../utils/responsivescreen.dart';
// ✅ make sure this exists
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/imagesconst.dart';
import '../screens/welcomescreen.dart';
import '../utils/responsivescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Logo scale animation (from 0 -> 1)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // smooth pop-out from center
    );

    // Navigate to AuthScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() =>  AuthScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // ✅ plain white background
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            AppImages.appLogo2, // ✅ your logo
            width: ResponsiveHelpers.w(300),
            height: ResponsiveHelpers.h(250),
          ),
        ),
      ),
    );
  }
}
