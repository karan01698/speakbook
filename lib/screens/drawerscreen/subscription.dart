import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pushable_button/pushable_button.dart';
import 'package:speakbook/constants/appcolorsconst.dart';

import '../../constants/apptextconst.dart';
import '../../constants/imagesconst.dart';
import '../../utils/responsivescreen.dart';
import '../../widget/text_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Row (Back + User Info)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Image.asset(
                      AppImages.appLogo2,
                      width: ResponsiveHelpers.w(130),
                      height: ResponsiveHelpers.h(110),
                    ),
                  ),
                  // User Info
                ],
              ),
            ),

            const SizedBox(height: 2),

            // Subscription Card
            Expanded(
              child: SingleChildScrollView(
                child: Container(

                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                   color: AppColors.greencolor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(

                    children: [
                      const Icon(Icons.emoji_events,
                          size: 120, color: Colors.white),
                      const SizedBox(height: 12),
                      Text(
                        "3 Months Subscription",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.white70),
                      const SizedBox(height: 8),
                      Text(
                        "Please subscribe to unlock the benefits.",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // White Box Details
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "BENEFITS",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Unlimited access to all questions of Theory Test without ADs for 3 Months",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Divider(height: 24),
                            Text(
                              "DURATION",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "3 Months Subscription",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Divider(height: 24),
                            Text(
                              "PRICE",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "\$4.99",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Subscribe Button
                      PushableButton(
                        // onPressed: () => Get.to(() => RegisterScreen()),
                        height: 40,
                        elevation: 8,
                        hslColor: HSLColor.fromAHSL(1.0, 120, 1.0, 0.37),
                        shadow: BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                        // onPressed: () => Get.to(() => RegisterScreen()),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.notifications, // 🔔 bell icon
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(width: 6), // thoda gap icon aur text ke beech
                            BalooSubtitleText(
                              text: AppTexts.subs,
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
