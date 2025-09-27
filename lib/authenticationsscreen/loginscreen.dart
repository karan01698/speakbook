import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speakbook/authenticationsscreen/registerscreen.dart';

import '../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/authenticationcontroller.dart';
import '../constants/appcolorsconst.dart';
import '../constants/apptextconst.dart';
import '../constants/imagesconst.dart';
import '../screens/home.dart';
import '../utils/responsivescreen.dart';
import '../utils/validator.dart';
import '../widget/reusable_button.dart';
import 'controllers/customfieltscontroller.dart';
import 'forgotscreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RegistrationController controller = Get.put(RegistrationController());
  final RegisterController registerController = Get.put(RegisterController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey, // ✅ wrap with Form
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Image.asset(
                      AppImages.appLogo2,
                      width: ResponsiveHelpers.w(170),
                      height: ResponsiveHelpers.h(180),
                    ),
                  ),

                  // Title
                  Center(
                    child: Text(
                      AppTexts.welcome,
                      style: GoogleFonts.baloo2(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Email field
                  CustomTextField(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    controller: emailController,
                    hintText: AppTexts.emailHint,
                    prefixIcon: const Icon(Icons.mail, size: 20),
                    prefixIconColor: AppColors.greencolor,
                    validator: Validators.validateEmail,
                  ),

                  const SizedBox(height: 15),

                  // Password field
                  Obx(
                        () => CustomTextField(
                      controller: passwordController,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      hintText: AppTexts.passwordHint,
                      obscureText: controller.obscurePassword.value,
                      prefixIcon: const Icon(Icons.lock, size: 20),
                      prefixIconColor: AppColors.greencolor,
                      suffixIconColor: AppColors.greencolor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                        ),
                        onPressed: () {
                          controller.obscurePassword.value =
                          !controller.obscurePassword.value;
                        },
                      ),
                      validator: Validators.validatePassword,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ForgotPasswordScreen(),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 200));
                      },
                      child: Text(
                        AppTexts.forgotPassword,
                        style: GoogleFonts.baloo2(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login button
                  Center(
                    child: Obx(
                          () => _buildActionButton(
                        text: isLoading.value
                            ? "Loading..."
                            : AppTexts.login, // ✅ fixed duplication
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading.value = true;

                            final user = loginUsers(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              token: 'SJELQJEHFOJLKDJ',

                            );

                            bool isLoggedIn =
                            await registerController.loginUser(user);

                            if (isLoggedIn) {
                              final authController =
                              Get.find<AuthControllersss>();
                              await authController.setLoggedIn(true);

                              Get.find<AppBarController>().login();
                              // Get.back();
                              Get.offAll(() => TranslateSpeakScreen());
                              controller.saveLoginState();
                              Get.snackbar("Success", "Login Successful!",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white);

                              await Future.delayed(
                                  const Duration(milliseconds: 800));
                              RegistrationController.saveEmail(
                                  email: emailController.text);}
                            // } else {
                            //   Get.snackbar("Error", "Login Failed!",
                            //       backgroundColor: Colors.red,
                            //       colorText: Colors.white);
                            // }

                            isLoading.value = false;
                          }
                        },
                        backgroundColor: AppColors.greencolor,
                        textColor: Colors.white,
                        width: ResponsiveHelpers.w(380),
                        height: ResponsiveHelpers.h(45),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Register Now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppTexts.dontHaveAccount,
                        style: GoogleFonts.baloo2(
                            fontSize: 14, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => Registerscreen(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 100));
                        },
                        child: Text(
                          AppTexts.registerNow,
                          style: GoogleFonts.baloo2(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Action button widget
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
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }
}
