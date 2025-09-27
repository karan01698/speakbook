import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speakbook/authenticationsscreen/sendsms.dart';

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
import 'loginscreen.dart';




class Registerscreen extends StatelessWidget {
  Registerscreen ({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final RegistrationController controller = Get.put(RegistrationController());

  final RegisterController controllerss = Get.put(RegisterController());
  final RxBool isLoading = false.obs;
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
                  padding: const EdgeInsets.only(left:70.0),
                  child: Image.asset(
                    AppImages.appLogo2,
                    width: ResponsiveHelpers.w(170),
                    height: ResponsiveHelpers.h(180),
                  ),
                ),
                // Title
                Center(
                  child: Text(
                    AppTexts.welcomeRegi,
                    style: GoogleFonts.baloo2(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        controller: nameController,
                        hintText: AppTexts.enterName,
                        prefixIcon: const Icon(Icons.person, size: 20),
                        prefixIconColor: AppColors.greencolor,
                        validator: Validators.validateName,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
                          ),
                        ),
                        validator: Validators.validateEmail,
                      ),

                      SizedBox(height: 15,),
                      CustomTextField(

                        controller: controller.otpController,
                        validator: (value) => Validators.validateOTP(
                            value, controller.randomNumber.toString()),
                        hintText: "OTP",
                        style: const TextStyle(fontWeight: FontWeight.bold,),
                      ),
                      const SizedBox(height: 15),

                      CustomTextField(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        prefixIcon: const Icon(Icons.phone_android_sharp, size: 20),
                        prefixIconColor: AppColors.greencolor,
                        controller: phoneController,
                        hintText: "Enter your mobile number",
                        keyboardType: TextInputType.phone,


                        validator: Validators.validatePhoneNumber,
                        onChanged: (value) {

                          controller.phoneNumberLength.value = value.length;
                        },
                      ),

                      const SizedBox(height: 15),
                      Obx(
                            () => CustomTextField(
                          controller: passwordController,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          hintText: AppTexts.passwordHint,
                          obscureText: controller.obscurePassword.value,
                          prefixIcon: const Icon(Icons.lock, size: 20),
                          suffixIconColor: AppColors.greencolor,
                          prefixIconColor: AppColors.greencolor,
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
                            () => CustomTextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: confirmPassController,
                          hintText: "Confirm Password",
                          obscureText: controller.obscureConfirmPassword.value,
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
                          validator: (value) => Validators
                              .validateConfirmPassword(value, passwordController.text),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  controller: dobController,
                  hintText: "Date of Birth",
                  style: const TextStyle(fontWeight: FontWeight.bold,),
                  prefixIcon: const Icon(Icons.calendar_today, size: 20),
                  prefixIconColor: AppColors.greencolor,
                  // readOnly: true, // ✅ prevent typing
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Colors.green, // header background color
                              onPrimary: Colors.white, // header text color
                              surface: Colors.black, // calendar background
                              onSurface: Colors.white, // calendar text color
                            ),
                            dialogBackgroundColor: Colors.black,
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      dobController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"; // ✅ format
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select your DOB";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Login button
                // Center(
                //   child:_buildActionButton(
                //     text: AppTexts.register,
                //     onPressed: () {
                //       if (controller.formKey.currentState!.validate()) {
                //         Get.to(() => TranslateSpeakScreen());
                //
                //
                //       }
                //
                //     },
                //     backgroundColor: AppColors.greencolor, // ✅ green button
                //     textColor: Colors.white,
                //
                //     width: ResponsiveHelpers.w(380),
                //     height: ResponsiveHelpers.h(45),
                //   ),
                // ),
                Center(
                  child: Obx(
                        () => _buildActionButton(

                      text: isLoading.value ? "Loading..." : AppTexts.register,
                      backgroundColor: AppColors.greencolor,
                      textColor: Colors.white,
                          width: ResponsiveHelpers.w(380),
                          height: ResponsiveHelpers.h(45),
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          isLoading.value = true;

                          final user = UserModel(
                            phone: phoneController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            email: emailController.text,
                            token: "SJELQJEHFOJLKDJ",
                            CPassword: confirmPassController.text,
                            dob: dobController.text,
                          );

                          try {
                            bool isRegistered = await controllerss.registerUser(user);

                            if (isRegistered) {
                              final authController = Get.put(AuthControllersss());
                              await authController.setLoggedIn(true);

                              Get.put(AppBarController()).login();
                              Get.snackbar("Success", "Registration Successful!",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white);

                              RegistrationController.saveEmail(
                                  email: emailController.text);

                              await Future.delayed(
                                  const Duration(milliseconds: 500));

                              Get.offAll(() => TranslateSpeakScreen());
                              controller.saveLoginState();
                            } else {
                              Get.snackbar("Error",
                                  "Alredy Register!.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            }
                          } catch (e) {
                            Get.snackbar("Error",
                                "Something went wrong: ${e.toString()}",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          } finally {
                            isLoading.value = false;
                          }
                        } else {
                          Get.snackbar("Error",
                              "Please fill in all fields correctly.",
                              backgroundColor: Colors.orange,
                              colorText: Colors.white);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppTexts.alreadyHave,
                      style: GoogleFonts.baloo2(fontSize: 14,color: Colors.white
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Get.to(()=>LoginScreen(),
                          transition: Transition.fadeIn, // 🔥 Smooth fade
                          duration: const Duration(milliseconds: 100),
                        );

                      },
                      child: Text(
                        AppTexts.login,
                        style: GoogleFonts.baloo2(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
      ),
      child: Icon(icon, color: color, size: 28),
    );
  }
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

