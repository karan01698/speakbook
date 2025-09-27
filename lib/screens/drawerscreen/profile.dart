import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../authenticationsscreen/controllers/customfieltscontroller.dart';
import '../../backend/authenticanapi/authencatemodals/registermodals.dart';
import '../../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../../constants/appcolorsconst.dart';
import '../../constants/imagesconst.dart';
import '../../utils/responsivescreen.dart';
import '../../utils/validator.dart';
import '../../widget/reusable_button.dart';

//
// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});
//   final RegisterController controllerss = Get.put(RegisterController());
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final RegisterController userController = Get.put(RegisterController());
//   final RegistrationController controller = Get.put(RegistrationController());
//
//   final Rx<File?> profileImage = Rx<File?>(null);
//   final RxString base64Image = ''.obs;
//   Future<void> _pickImage(BuildContext context) async {
//     final ImagePicker picker = ImagePicker();
//
//     await showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.black87,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) {
//         return Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo, color: Colors.white),
//               title: const Text("Choose from Gallery",
//                   style: TextStyle(color: Colors.white)),
//               onTap: () async {
//                 final picked = await picker.pickImage(source: ImageSource.gallery);
//                 if (picked != null) {
//                   profileImage.value = File(picked.path);
//
//                   // ✅ Base64 banaya gallery ke liye
//                   final bytes = await picked.readAsBytes();
//                   base64Image.value = base64Encode(bytes);
//
//                   print("Gallery Base64 length: ${base64Image.value.length}");
//                 }
//                 Get.back();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.camera_alt, color: Colors.white),
//               title: const Text("Take Photo",
//                   style: TextStyle(color: Colors.white)),
//               onTap: () async {
//                 final picked = await picker.pickImage(source: ImageSource.camera);
//                 if (picked != null) {
//                   profileImage.value = File(picked.path);
//
//                   // ✅ Base64 banaya camera ke liye
//                   final bytes = await picked.readAsBytes();
//                   base64Image.value = base64Encode(bytes);
//
//                   print("Camera Base64 length: ${base64Image.value.length}");
//                 }
//                 Get.back();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _selectDOB(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000, 1, 1),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//             colorScheme: const ColorScheme.dark(
//               primary: AppColors.greencolor,
//               surface: Colors.black,
//               onSurface: Colors.white,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       dobController.text =
//       "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//
//                 // Profile Image
//                 Stack(
//                   children: [
//                     Obx(
//                           () => CircleAvatar(
//                         radius: 65,
//                         backgroundColor: Colors.grey.shade800,
//                         backgroundImage: profileImage.value != null
//                             ? FileImage(profileImage.value!)
//                             : AssetImage(AppImages.appLogo2) as ImageProvider,
//                       ),
//                     ),
//                     Positioned(
//                       left: 0,
//                       bottom: 0,
//                       child: InkWell(
//                         onTap: () => _pickImage(context),
//                         child: CircleAvatar(
//                           backgroundColor: AppColors.greencolor,
//                           radius: 20,
//                           child: const Icon(Icons.camera_alt,
//                               size: 20, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 Form(
//                   key: controller.formKey,
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         controller: nameController,
//                         hintText: "Enter Name",
//                         prefixIcon: const Icon(Icons.person, size: 20),
//                         prefixIconColor: AppColors.greencolor,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         validator: Validators.validateName,
//                       ),
//                       const SizedBox(height: 15),
//                       CustomTextField(
//                         controller: emailController,
//                         hintText: "Enter Email",
//                         prefixIcon: const Icon(Icons.mail, size: 20),
//                         prefixIconColor: AppColors.greencolor,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         validator: Validators.validateEmail,
//                       ),
//                       const SizedBox(height: 15),
//                       CustomTextField(
//                         controller: phoneController,
//                         hintText: "Enter Phone",
//                         prefixIcon: const Icon(Icons.phone, size: 20),
//                         prefixIconColor: AppColors.greencolor,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         validator: Validators.validatePhoneNumber,
//                       ),
//                       const SizedBox(height: 15),
//                       GestureDetector(
//                         onTap: () => _selectDOB(context),
//                         child: AbsorbPointer(
//                           child: CustomTextField(
//                             controller: dobController,
//                             hintText: "Select DOB",
//                             prefixIcon:
//                             const Icon(Icons.calendar_today, size: 20),
//                             prefixIconColor: AppColors.greencolor,
//                             style:
//                             const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 // Save Button
//                 _buildActionButton(
//                   text: "Save Profile",
//                   onPressed: () {
//                     if (controller.formKey.currentState!.validate()) {
//                       final user = UpdateUserModal(
//                         phone: phoneController.text,
//                         name: nameController.text,
//                         email: emailController.text,
//                         token: 'SJELQJEHFOJLKDJ', dob: dobController.text, images: base64Image.value,
//                         // profileImage: imageController.selectedImage.value?.path, // Pass image path if selected
//                       );
// print("allimages ${base64Image.value}");
//                       RegistrationController.saveEmail(email: emailController.text.toString());
//                       controllerss.UpdateUsercon(user);
//                       Get.back();
//                     } else {
//                       print("Form Validation Failed");
//                     }
//                   },
//                   backgroundColor: AppColors.greencolor,
//                   textColor: Colors.white,
//                   width: ResponsiveHelpers.w(380),
//                   height: ResponsiveHelpers.h(45),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildActionButton({
//   required String text,
//   required VoidCallback onPressed,
//   required Color backgroundColor,
//   required Color textColor,
//   IconData? icon,
//   Color? borderColor,
//   double? width,
//   double? height,
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 6),
//     child: ReusableButton(
//       text: text,
//       isShimmer: true,
//       shimmerDuration: const Duration(seconds: 3),
//       onPressed: onPressed,
//       width: width ?? 100,
//       height: height ?? 30,
//       borderRadius: 25,
//       fontSize: 17,
//       backgroundColor: backgroundColor,
//       textColor: textColor,
//       borderColor: borderColor ?? Colors.transparent,
//       borderWidth: borderColor != null ? 1 : 0,
//       icon: icon,
//       fontFamily: GoogleFonts.poppins().fontFamily,
//     ),
//   );
// }
class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RegisterController userController = Get.put(RegisterController());
  final RegistrationController controller = Get.put(RegistrationController());
  final RegisterController controllerss = Get.put(RegisterController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final Rx<File?> profileImage = Rx<File?>(null);
  final RxString base64Image = ''.obs;

  late Worker _userWorker; // 👈 Worker store karne ke liye

  @override
  void initState() {
    super.initState();

    _userWorker = once(userController.userProfile, (user) {
      if (user != null) {
        nameController.text = user.name ?? "";
        emailController.text = user.email ?? "";
        phoneController.text = user.phone ?? "";
        dobController.text = user.DOB ?? "";
      }
    });
  }

  @override
  void dispose() {
    // ✅ Worker dispose karna zaroori hai
    _userWorker.dispose();

    // ✅ Controllers bhi dispose karo
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();

    super.dispose();
  }

  // ✅ Image Picker
  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.white),
              title: const Text("Choose from Gallery",
                  style: TextStyle(color: Colors.white)),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  profileImage.value = File(picked.path);

                  final bytes = await picked.readAsBytes();
                  base64Image.value = base64Encode(bytes);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text("Take Photo",
                  style: TextStyle(color: Colors.white)),
              onTap: () async {
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  profileImage.value = File(picked.path);

                  final bytes = await picked.readAsBytes();
                  base64Image.value = base64Encode(bytes);
                }
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDOB(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.greencolor,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      dobController.text =
      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ✅ Profile Image
                Stack(
                  children: [
                    Obx(() {
                      final user = userController.userProfile.value;
                      return CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage: profileImage.value != null
                            ? FileImage(profileImage.value!)
                            : (user?.Images != null &&
                            user!.Images!.isNotEmpty)
                            ? NetworkImage(user.Images!)
                            : AssetImage(AppImages.appLogo2)
                        as ImageProvider,
                      );
                    }),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () => _pickImage(context),
                        child: CircleAvatar(
                          backgroundColor: AppColors.greencolor,
                          radius: 20,
                          child: const Icon(Icons.camera_alt,
                              size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        hintText: "Enter Name",
                        prefixIcon: const Icon(Icons.person, size: 20),
                        prefixIconColor: AppColors.greencolor,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        validator: Validators.validateName,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: emailController,
                        hintText: "Enter Email",
                        prefixIcon: const Icon(Icons.mail, size: 20),
                        prefixIconColor: AppColors.greencolor,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: phoneController,
                        hintText: "Enter Phone",
                        prefixIcon: const Icon(Icons.phone, size: 20),
                        prefixIconColor: AppColors.greencolor,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        validator: Validators.validatePhoneNumber,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => _selectDOB(context),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: dobController,
                            hintText: "Select DOB",
                            prefixIcon:
                            const Icon(Icons.calendar_today, size: 20),
                            prefixIconColor: AppColors.greencolor,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ✅ Save Button
                _buildActionButton(
                  text: "Save Profile",
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      final user = UpdateUserModal(
                        phone: phoneController.text,
                        name: nameController.text,
                        email: emailController.text,
                        dob: dobController.text,
                        images: base64Image.value.isNotEmpty
                            ? base64Image.value
                            : "",
                        token: 'SJELQJEHFOJLKDJ',
                      );

                      RegistrationController.saveEmail(
                          email: emailController.text.toString());
                      controllerss.UpdateUsercon(user);
                      // userController.UpdateUsercon(user).then((_) {
                      //   userController.fetchUserProfile();
                      // });

                      Get.back();
                    } else {
                      print("Form Validation Failed");
                    }
                  },
                  backgroundColor: AppColors.greencolor,
                  textColor: Colors.white,
                  width: ResponsiveHelpers.w(380),
                  height: ResponsiveHelpers.h(45),
                ),
              ],
            ),
          ),
        ),
      ),
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
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  );
}