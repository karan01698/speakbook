import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


import '../../../authenticationsscreen/controllers/customfieltscontroller.dart';
import '../../credential.dart';
import '../authencatemodals/registermodals.dart';

class ApiService {
  static const String baseUrl =
      "https://speakbook.in/APIs/APIs.asmx";
  static const String token = "SJELQJEHFOJLKDJ";

  // Register User API
  static Future<Map<String, dynamic>> registerUser(Map<String, String> data) async {
    print(data);
    final Uri url = Uri.parse(

        "https://speakbook.in/APIs/APIs.asmx/Register?token=${ApiConstants
            .token}");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  //login services
  static Future<Map<String, dynamic>> LoginUser(Map<String, String> data) async {
    final Uri url = Uri.parse(
        "https://speakbook.in/APIs/APIs.asmx/Loginsuser?token=${ApiConstants.token}");

    try {
      print("🔹 Sending Login Request: $data"); // ✅ Print Data Before Sending

      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      print("🔹 API Response: ${response.body}"); // ✅ Print API Response

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to login. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

// forgotpassword

  static Future<Map<String, dynamic>> forgotPasswordServices(Map<String, String> data) async {
    final Uri url = Uri.parse(
        "https://speakbook.in/APIs/APIs.asmx/ForgotPassword?token=${ApiConstants.token}");

    try {
      print("🔹 Sending Login Request: $data"); // ✅ Print Data Before Sending

      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      print("🔹 API Response: ${response.body}"); // ✅ Print API Response

      if (response.statusCode == 200) {

        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to update your password. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  /// updateAPi
  static Future<Map<String, dynamic>> UpdateregUser(
      Map<String, String> data) async {
    final Uri url = Uri.parse(
          "https://speakbook.in/APIs/APIs.asmx/UpdateProfile?token=${ApiConstants
            .token}");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  static Future<Map<String, dynamic>> InsertBet(
      Map<String, String> data) async {
    final Uri url = Uri.parse(
        "https://speakbook.in/APIs/APIs.asmx/InsertBet?token=${ApiConstants
            .token}");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to bet. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }

  static Future<Map<String, dynamic>> UpdateBalanceServices(
      Map<String, String> data) async {
    String? phone = await RegistrationController
        .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      print("No saved phone number found.");

    }

    final Uri url = Uri.parse(
        "https://speakbook.in/APIs/APIs.asmx/UpdateBalance?token=${ApiConstants
            .token}&phone");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }


/// withdraw services
  static Future<Map<String, dynamic>>withdrawBalanceServices(
      Map<String, String> data) async {
    String? phone = await RegistrationController
        .getPhoneNumber(); // 🔹 Get saved phone number
    if (phone == null || phone.isEmpty) {
      print("No saved phone number found.");

    }

    final Uri url = Uri.parse(
        "https://speakbook.in/APIs/APIs.asmx/InsertTransactions?token=${ApiConstants
            .token}&phone");

    try {
      final response = await http.post(
        url,
        body: data, // Sending form-urlencoded data
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": "Failed to register. Status Code: ${response.statusCode}"
        };
      }
    } catch (e) {
      return {"error": "Something went wrong: $e"};
    }
  }











  /// get mthod

  // Fetch user profile WITHOUT headers
  static Future<UserProfile?> fetchUserProfile() async {
    try {
      String? email = await RegistrationController
          .getEmail(); // 🔹 Get saved phone number
      if (email == null || email.isEmpty) {
        print("No saved phone number found.");
        return null;
      }
      final url = Uri.parse(
          "https://speakbook.in/APIs/APIs.asmx/ShowProfile?token=SJELQJEHFOJLKDJ&Email=$email");
      print("https://speakbook.in/APIs/APIs.asmx/ShowProfile?token=SJELQJEHFOJLKDJ&Phone=$email");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
        json.decode(response.body); // ✅ FIX: Parse as List
        if (jsonData.isNotEmpty) {
          return UserProfile.fromJson(
              jsonData.first); // ✅ Extract the first object
        } else {
          print("No user found");
          return null;
        }
      } else {
        print("Failed to load profile: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }

// Fetch user profile WITHOUT headers
//   static Future<GetBetProfileModal?> fetchBetProfile() async {
//     try {
//       String? phone = await RegistrationController
//           .getPhoneNumber(); // 🔹 Get saved phone number
//       if (phone == null || phone.isEmpty) {
//         print("No saved phone number found.");
//         return null;
//       }
//       final url = Uri.parse(
//           "https://speakbook.in/APIs/APIs.asmx/GetBet?token=BETLAJDNDNDBARKXTER&Game=aviator&Phone=$phone"
//       );
//
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(
//             response.body); // ✅ FIX: Parse as List
//         if (jsonData.isNotEmpty) {
//           return GetBetProfileModal.fromJson(
//               jsonData.first); // ✅ Extract the first object
//         } else {
//           print("No user found");
//           return null;
//         }
//       } else {
//         print("Failed to load profile: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching user profile: $e");
//       return null;
//     }


  static const String apiUrl = "https://speakbook.in/APIs/APIs.asmx/GetQR?token=BETLAJDNDNDBARKXTER";

  static Future<List<QRModel>> fetchQRData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dealer = prefs.getString('dealer') ?? '';
    print("hellow dealer $dealer");

    final Uri uri = Uri.parse(
        "https://speakbook.in/APIs/APIs.asmx/GetQR?token=BETLAJDNDNDBARKXTER&dealer=$dealer");
print("https://speakbook.in/APIs/APIs.asmx/GetQR?token=BETLAJDNDNDBARKXTER&dealer=$dealer");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return QRModel.fromJsonList(response.body); // Make sure this method exists
    } else {
      throw Exception("Failed to load QR data");
    }
  }
}



