
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakbook/authenticationsscreen/loginscreen.dart';

class AuthControllersss extends GetxController {
  var isLoggedIn = false.obs;


  @override
  void onInit() {
    super.onInit();
    _loadLoginState(); // ✅ Load state at startup
  }

  Future<void> _loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    isLoggedIn.value = value;
  }

  Future<void> logout() async {
    // await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().signOut();
    // await GoogleSignIn().disconnect();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // ✅ Save logout state
    await prefs.clear();

    // await prefs.remove('isLoggedIn');
    isLoggedIn.value = false; // ✅ Update state
    Get
        .find<AppBarController>()
        .isLoggedIn
        .value =
    false; // ✅ Sync AppBar state
Get.offAll(LoginScreen());

  }

}

class AppBarController extends GetxController {
  var isLoggedIn = false.obs;

  // void checkActiveControllers() {
  //   print("Checking active controllers...");
  //
  //   if (Get.isRegistered<RegisterController>()) {
  //     print("✅ RegisterController is running.");
  //   }
  //   if (Get.isRegistered<AuthControllersss>()) {
  //     print("✅ AuthControllersss is running.");
  //   }
  //   if (Get.isRegistered<TabControllerssX>()) {
  //     print("✅ TabControllerssX is running.");
  //   }
  //   if (Get.isRegistered<AppBarController>()) {
  //     print("✅ AppBarController is running.");
  //   }
  //   if (Get.isRegistered<PopularGamesController>()) {
  //     print("✅ PopularGamesController is running.");
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    // checkActiveControllers();
    // if (Get.isRegistered<RegisterController>()) {
    //   print("Hello World");
    // } else {
    //   print("RegisterController is not registered");
    // }

    try {
      isLoggedIn.value = Get.find<AuthControllersss>().isLoggedIn.value;
    } catch (e) {
      print("Error finding AuthControllersss: $e");
    }
  }

  void login() {
    isLoggedIn.value = true;
    Get.find<AuthControllersss>().setLoggedIn(true);
  }

  void logout() {
    isLoggedIn.value = false;
    Get.find<AuthControllersss>().setLoggedIn(false);
  }
}
