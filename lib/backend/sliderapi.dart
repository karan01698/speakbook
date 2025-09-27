import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



import 'credential.dart';
import 'package:flutter/material.dart';

class SliderController extends GetxController {
  var banners = <String>[].obs;
  var Qrcode = <String>[].obs;
  RxInt currentIndex = 0.obs;
  late PageController pageController;
  Timer? autoScrollTimer;
  // Observable list to store banner images

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
    pageController = PageController();
    startAutoScroll();
  }
  void startAutoScroll() {
    autoScrollTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (banners.isNotEmpty) {
        int nextPage = currentIndex.value + 1;
        if (nextPage >= banners.length) {
          nextPage = 0; // Loop back to first slide
        }
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        currentIndex.value = nextPage;
      }
    });
  }
  @override
  void onClose() {
    autoScrollTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
  Future<void> fetchBanners() async {
    const String apiUrl = "https://speakbook.in/APIs/APIs.asmx/Banners?token=${ApiConstants.token}";
    const String token = "BETLAJDNDNDBARKXTER"; // Your token

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        // headers: {
        //   "Authorization": "Bearer $token",
        //   "Content-Type": "application/x-www-form-urlencoded",
        // },
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          banners.assignAll(jsonResponse.map((item) => item["Banner1"].toString()).toList());
        } else {
          Get.snackbar("Error", "Invalid response format");
        }
      } else {
        Get.snackbar("Error", "Failed to load banners: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  // Future<void> QrCode() async {
  //   const String apiUrl = "https://speakbook.in/APIs/APIs.asmx/GetQR?token=${ApiConstants.token}";
  //
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     print("Response Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(response.body);
  //
  //       // Check if jsonResponse is a List or Map
  //       if (jsonResponse is List) {
  //         // If it's a list, extract QR1 values
  //         Qrcode.assignAll(jsonResponse.map((item) => item["QR1"].toString()).toList());
  //       } else if (jsonResponse is Map && jsonResponse.containsKey("data")) {
  //         // If it's a Map, extract the list from "data" key
  //         var dataList = jsonResponse["data"];
  //         if (dataList is List) {
  //           Qrcode.assignAll(dataList.map((item) => item["QR1"].toString()).toList());
  //         } else {
  //           Get.snackbar("Error", "Invalid response structure");
  //         }
  //       } else {
  //         Get.snackbar("Error", "Unexpected response format");
  //       }
  //     } else {
  //       Get.snackbar("Error", "Failed to load QR codes: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong: $e");
  //   }
  // }

}











