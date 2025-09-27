import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakbook/screens/home.dart';
import 'authenticationsscreen/controllers/customfieltscontroller.dart';
import 'authenticationsscreen/splashscreen.dart';
import 'backend/authenticanapi/controllerapi/registerapicontroller.dart';
import 'backend/authenticationcontroller.dart';
import 'firebase_options.dart';

void main() async{

  // Get.put(LoginAuthController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() =>LoginAuthController(),fenix: true);
  Get.put(AuthControllersss());
  Get.lazyPut(() => RegisterController(), fenix: true);

  Get.lazyPut(() => AppBarController(), fenix: true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Run the app with the correct condition
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // ✅ set your Figma/Design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // home: SplashScreen(),
          home: isLoggedIn ? TranslateSpeakScreen() : SplashScreen(),
        );
      },
    );
  }
}
