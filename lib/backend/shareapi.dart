import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class ShareModel {
  final int id;
  final String logo;
  final String message;
  final String number;

  ShareModel({
    required this.id,
    required this.logo,
    required this.message,
    required this.number,
  });

  factory ShareModel.fromJson(Map<String, dynamic> json) {
    return ShareModel(
      id: json['id'] ?? 0,
      logo: json['Logo'] ?? '',
      message: json['Message'] ?? '',
      number: json['Number'] ?? '',
    );
  }
}
 // adjust path as needed

class ShareControllerapi extends GetxController {
  var shareList = <ShareModel>[].obs;

  final String apiUrl =
      'https://speakbook.in/APIs/APIs.asmx/Share?token=BETLAJDNDNDBARKXTER';

  @override
  void onInit() {
    fetchShareData();
    super.onInit();
  }

  void fetchShareData() async {
    try {

      final response = await http.get(Uri.parse(apiUrl));

      print("Status Code: ${response.statusCode}");
      print("Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonString =
        response.body.replaceAll(RegExp(r'^<string.*?>|<\/string>$'), '');

        final List<dynamic> data = jsonDecode(jsonString);
        shareList.value = data.map((e) => ShareModel.fromJson(e)).toList();
      } else {
        print("API Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
// class ShareScreen extends StatelessWidget {
//   final ShareControllerapi controller = Get.put(ShareControllerapi());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Share Info"), backgroundColor: Colors.green),
//       body: Obx(() {
//         if (controller.shareList.isEmpty) {
//           return Center(child: Text("No data"));
//         }
//
//         return ListView.builder(
//           padding: EdgeInsets.all(12),
//           itemCount: controller.shareList.length,
//           itemBuilder: (context, index) {
//             final item = controller.shareList[index];
//             return Card(
//               child: ListTile(
//                 title: Text(item.message),
//                 subtitle: Text("Number: ${item.number}"),
//                 leading: item.logo.isNotEmpty
//                     ? Image.network(item.logo)
//                     : Icon(Icons.image),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
