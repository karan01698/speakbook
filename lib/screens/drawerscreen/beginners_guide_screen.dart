import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakbook/constants/imagesconst.dart';
import '../../constants/appcolorsconst.dart';
import '../../widget/CustomerDrawerAppBar.dart';
import '../../widget/text_widget.dart';


class BeginnerGuideScreen extends StatelessWidget {
  const BeginnerGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomerDrawerAppBar(
        title: "Beginner's Guide",
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image stacked above container
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 60.h),
                    width: 360.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16.r),
                      border:
                          Border.all(color: AppColors.appBarColors, width: 2.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.4),
                          blurRadius: 12.r,
                          offset: Offset(0, 6.h),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(20.w, 2.h, 20.w, 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            child: ClipOval(
                              child: Image.asset(
                                AppImages.appLogo2,
                                height: 100.h,
                                width: 100.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        BalooSubtitleText(
                          text: "Start Here",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        SizedBox(height: 16.h),
                        BalooSubtitleText(
                          text:
                              "Welcome to the Beginner’s Guide! This guide will help you navigate through all the features of our platform. Get tips, tricks, and an overview of how everything works so you can get started with confidence.",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),


                      ],
                    ),
                  ),
                ),

                // Circular image in center

              ],
            ),

            SizedBox(height: 30.h),

            // Optional: More steps or tips
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  BalooSubtitleText(
                    text: "Quick Tips:",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                  SizedBox(height: 8.h),
                  BalooSubtitleText(
                    text:
                        "✓ Explore the menu\n✓ Customize your profile\n✓ Check daily updates",
                    fontSize: 25.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
