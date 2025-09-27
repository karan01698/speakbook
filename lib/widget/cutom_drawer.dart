import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speakbook/backend/authenticanapi/apiservices/registerapiservices.dart';
import 'package:url_launcher/url_launcher.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/authenticationcontroller.dart';
import '../constants/appcolorsconst.dart';
import '../screens/drawerscreen/aboutus.dart';
import '../screens/drawerscreen/beginners_guide_screen.dart';
import '../screens/drawerscreen/feedback.dart';
import '../screens/drawerscreen/history.dart';
import '../screens/drawerscreen/privacypolicy.dart';
import '../screens/drawerscreen/profile.dart';
import '../screens/drawerscreen/subscription.dart';
import '../screens/drawerscreen/terms&condtions.dart';
import '../screens/drawerscreen/transationscreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speakbook/backend/authenticanapi/apiservices/registerapiservices.dart';
import '../backend/authenticanapi/controllerapi/registerapicontroller.dart';
import '../backend/authenticationcontroller.dart';
import '../constants/appcolorsconst.dart';
import '../screens/drawerscreen/aboutus.dart';
import '../screens/drawerscreen/beginners_guide_screen.dart';
import '../screens/drawerscreen/history.dart';
import '../screens/drawerscreen/privacypolicy.dart';
import '../screens/drawerscreen/profile.dart';
import '../screens/drawerscreen/subscription.dart';
import '../screens/drawerscreen/terms&condtions.dart';
import '../screens/drawerscreen/transationscreen.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final AuthControllersss authController = Get.find<AuthControllersss>();

  @override
  Widget build(BuildContext context) {
    final RegisterController userController = Get.put(RegisterController());

    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ✅ Header with API + Obx
          FutureBuilder(
            future: ApiService.fetchUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading state
                return UserAccountsDrawerHeader(
                  decoration:
                      const BoxDecoration(color: AppColors.appBarColors),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    backgroundImage: const AssetImage("assets/logo2.png"),
                  ),
                  accountName: const Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  accountEmail: const Text(
                    "Please wait",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                );
              } else if (snapshot.hasError) {
                // Error state
                return UserAccountsDrawerHeader(
                  decoration:
                      const BoxDecoration(color: AppColors.appBarColors),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    backgroundImage: const AssetImage("assets/logo2.png"),
                  ),
                  accountName: const Text(
                    "Guest User",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  accountEmail: const Text(
                    "Error loading profile",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                );
              } else {
                // ✅ Data loaded successfully
                return Obx(() {
                  final user = userController.userProfile.value;
                  return UserAccountsDrawerHeader(
                    decoration:
                        const BoxDecoration(color: AppColors.appBarColors),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.grey[900], // ✅ always grey bg
                      backgroundImage:
                          (user?.Images != null && user!.Images!.isNotEmpty)
                              ? NetworkImage(user.Images!)
                              : const AssetImage("assets/logo2.png")
                                  as ImageProvider,
                    ),
                    accountName: Text(
                      user?.name ?? "Guest User",
                      style: GoogleFonts.baloo2(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      user?.email ?? "No email",
                      style: GoogleFonts.baloo2(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                });
              }
            },
          ),

          // Drawer Items
          _buildDrawerItem(Icons.person, "Profile", onTap: () {
            Get.to(() => ProfileScreen());
          }),
          _buildDrawerItem(Icons.subscriptions, "Subscription", onTap: () {
            Get.to(() => SubscriptionScreen());
          }),
          // _buildDrawerItem(Icons.account_balance_wallet, "Transactions",
          //     onTap: () {
          //       Get.to(() => NewFastTagsScreen());
          //     }),
          _buildDrawerItem(Icons.history, "Transactions", onTap: () {
            Get.to(() => HistoryTransactionsScreen());
          }),

          const Divider(color: Colors.white38),

          _buildDrawerItem(Icons.menu_book, "Beginner's Guide", onTap: () {
            Get.to(() => BeginnerGuideScreen());
          }),
          // _buildDrawerItem(Icons.info_outline, "About Us", onTap: () {
          //   Get.to(() => AboutUsScreen());
          // }),
          // _buildDrawerItem(Icons.privacy_tip, "Privacy Policy", onTap: () {
          //   Get.to(() => PrivacyPolicyScreen());
          // }),
          _buildDrawerItem2(
            Icons.description,
            "Privacy Policy",
            url: "https://speakbook.in/#policy",
          ),
          _buildDrawerItem2(
            Icons.description,
            "About Us",
            url: "https://speakbook.in/#about",
          ),
          _buildDrawerItem2(
            Icons.description,
            "Terms & Conditions",
            url: "https://speakbook.in/#terms",
          ),
          _buildDrawerItem(Icons.description, "FeedBack", onTap: () {
            Get.to(() => FeedbackScreen());
          }),

          Obx(() {
            return authController.isLoggedIn.value
                ? _buildDrawerItem(Icons.exit_to_app, "Logout", onTap: () {
                    _showLogoutDialog(context, authController);
                  })
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  // correct import

  _buildDrawerItem2(IconData icon, String title, {required String url}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.cardColor),
      title: Text(title, style: const TextStyle(color: Colors.white),),
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication, // opens in browser
          );
        } else {
          Get.snackbar("Error", "Could not launch $url");
        }
      },
    );
  }

  Widget _buildDrawerItem(IconData icon, String title,
      {required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.cardColor),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(
      BuildContext context, AuthControllersss authController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                Get.back(); // Close drawer
                authController.logout(); // Logout user
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
