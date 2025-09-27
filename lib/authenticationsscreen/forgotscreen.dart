import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speakbook/authenticationsscreen/sendsms.dart';

import '../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/otpapi.dart';
import '../constants/appcolorsconst.dart';
import '../constants/apptextconst.dart';
import '../constants/imagesconst.dart';
import '../screens/home.dart';
import '../utils/responsivescreen.dart';
import '../utils/validator.dart';
import '../widget/reusable_button.dart';
import 'controllers/customfieltscontroller.dart';
import 'loginscreen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final RegistrationController controller = Get.put(RegistrationController());
  final RegisterController registerController = Get.put(RegisterController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
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
                    "Forgot Password",
                    style: GoogleFonts.baloo2(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // -------------------------------
                      // Name Field removed
                      // -------------------------------

                      CustomTextField(
                        style: const TextStyle(fontWeight: FontWeight.bold,),
                        controller: emailController,
                        hintText: "Enter Your Email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.mail, size: 20),
                        prefixIconColor: AppColors.greencolor,
                        suffixIcon: IntrinsicHeight(
                            child: Obx(
                                  () => ReusableButton(
                                isShimmer: true,
                                shimmerDuration: const Duration(seconds: 3),
                                borderColor: Colors.black,
                                onPressed: () async {
                                  controller.generateRandomNumber();
                                  String otp = controller.randomNumber.toString();
                                  print("dkdkdkd$otp");
                                  await sendSms(emailController.text, otp);
                                },
                                text: controller.isOtpLoading.value ? "Sending..." : "Get OTP",
                                backgroundColor: AppColors.appBarColors,
                                height: double.infinity,
                                width: 80,
                                fontSize: 12,
                              ),
                            ),),

                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(

                        controller: controller.otpController,
                        validator: (value) =>
                            Validators.validateOTP(
                                value, controller.randomNumber.toString()),
                        hintText: "OTP",
                        style: const TextStyle(fontWeight: FontWeight.bold,),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                            () =>
                            CustomTextField(
                              controller: passwordController,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
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
                      Obx(
                            () =>
                            CustomTextField(
                              controller: confirmPassController,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                              hintText: "Confirm Password",
                              obscureText: controller.obscureConfirmPassword
                                  .value,
                              prefixIcon: const Icon(Icons.lock, size: 20),
                              prefixIconColor: AppColors.greencolor,
                              suffixIconColor: AppColors.greencolor,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscureConfirmPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                ),
                                onPressed: () {
                                  controller.obscureConfirmPassword.value =
                                  !controller.obscureConfirmPassword.value;
                                },
                              ),
                              validator: (value) =>
                                  Validators.validateConfirmPassword(
                                      value, passwordController.text),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Reset Password button
                Center(
                  child: _buildActionButton(
                    text: "Reset Password",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final user = forgotPasswordModal(
                          email: emailController.text,
                          password: passwordController.text,
                          token: "SJELQJEHFOJLKDJ",
                        );
                        await registerController.forgotPasswordController(user);
                        Get.offAll(() => LoginScreen());
                      }
                    },
                    backgroundColor: AppColors.greencolor,
                    textColor: Colors.white,
                    width: ResponsiveHelpers.w(380),
                    height: ResponsiveHelpers.h(45),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
        fontFamily: GoogleFonts
            .poppins()
            .fontFamily,
      ),
    );
  }
}