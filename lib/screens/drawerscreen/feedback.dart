import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../authenticationsscreen/controllers/customfieltscontroller.dart';
import '../../backend/authenticanapi/apiservices/registerapiservices.dart';

class FeedbackModel {
  final int id;
  final String email;
  final String rating;
  final String query;
  final String profileImage;
  final String reply;

  FeedbackModel({
    required this.id,
    required this.email,
    required this.rating,
    required this.query,
    required this.profileImage,
    required this.reply,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['Id'] ?? 0,
      email: json['Email'] ?? '',
      rating: json['Rating'] ?? '',
      query: json['Query'] ?? '',
      profileImage: json['ProfileImage'] ?? '',
      reply: json['Reply'] ?? '',
    );
  }
}

// =================== FEEDBACK CONTROLLER ===================
class FeedbackController extends GetxController {
  var feedbackList = <FeedbackModel>[].obs;
  var isLoading = false.obs;

  final String baseUrl = "https://speakbook.in/APIs/APIs.asmx";
  final String token = "SJELQJEHFOJLKDJ";

  // Fetch Feedbacks
  Future<void> fetchFeedbacks() async {
    try {
      isLoading.value = true;
      String? email = await RegistrationController.getEmail();
      if (email == null || email.isEmpty) return;

      final url = Uri.parse("$baseUrl/ShowFeedback?token=$token&Email=$email");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        feedbackList.value =
            data.map((e) => FeedbackModel.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Add Feedback
  Future<void> addFeedback(String rating, String query) async {
    if (query.trim().isEmpty) {
      Get.snackbar("Error", "Feedback cannot be empty");
      return;
    }

    try {
      String? email = await RegistrationController.getEmail();
      if (email == null || email.isEmpty) return;

      final url = Uri.parse("$baseUrl/Addfeedback");
      final response = await http.post(
        url,
        body: {
          "token": token,
          "Email": email,
          "rating": rating,
          "query": query,
          "Reply": "",
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        Get.snackbar("Success", res["Message"],
            backgroundColor: Colors.green, colorText: Colors.white);
        fetchFeedbacks();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Update Feedback
  Future<void> updateFeedback(int id, String rating, String query) async {
    try {
      String? email = await RegistrationController.getEmail();
      if (email == null || email.isEmpty) return;

      final url = Uri.parse("$baseUrl/UpdateFeedbacks");
      final response = await http.post(
        url,
        body: {
          "token": token,
          "Email": email,
          "rating": rating,
          "query": query,
          "Id": id.toString(),
        },
      );

      print("✏️ Update Response: ${response.body}");

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        Get.snackbar("Updated", res["Message"],
            backgroundColor: Colors.blue, colorText: Colors.white);
        fetchFeedbacks();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Delete Feedback
  Future<void> deleteFeedback(int id) async {
    try {
      final url = Uri.parse("$baseUrl/DeletesFeedbacks");
      final response =
      await http.post(url, body: {"token": token, "Id": id.toString()});

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        Get.snackbar("Deleted", res["Message"],
            backgroundColor: Colors.red, colorText: Colors.white);
        fetchFeedbacks();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}


// =================== FEEDBACK SCREEN ===================
class FeedbackScreen extends StatelessWidget {
  final FeedbackController controller = Get.put(FeedbackController());
  final TextEditingController queryController = TextEditingController();
  final RxInt selectedRating = 0.obs;

  FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchFeedbacks();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Feedback", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Feedback Input Box
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: queryController,
                maxLines: 5,
                maxLength: 250,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Write your feedback here (max 250 words)",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Star Rating
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    selectedRating.value = index + 1;
                  },
                  icon: Icon(
                    Icons.star,
                    size: 40,
                    color: (selectedRating.value >= index + 1)
                        ? Colors.yellow
                        : Colors.grey,
                  ),
                );
              }),
            );
          }),

          // Submit Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {
                if (selectedRating.value == 0) {
                  Get.snackbar("Error", "Please select rating",
                      backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }
                controller.addFeedback(
                  selectedRating.value.toString(),
                  queryController.text,
                );

                // ✅ Reset after submit
                selectedRating.value = 0;
                queryController.clear();
              },
              child: const Text("Submit Feedback"),
            ),
          ),

          const Divider(color: Colors.green),

          // Feedback List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.green));
              }

              if (controller.feedbackList.isEmpty) {
                return const Center(
                    child: Text("No Feedback yet",
                        style: TextStyle(color: Colors.white)));
              }

              return ListView.builder(
                itemCount: controller.feedbackList.length,
                itemBuilder: (context, index) {
                  final item = controller.feedbackList[index];
                  int apiRating = int.tryParse(item.rating) ?? 0;

                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ==== USER FEEDBACK ====
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: (item.profileImage.isNotEmpty)
                                    ? NetworkImage(item.profileImage)
                                    : const AssetImage(
                                    "assets/images/user_placeholder.png")
                                as ImageProvider,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _ExpandableText(
                                  text: item.query,
                                  textStyle:
                                  const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),

                          // Rating
                          if (apiRating > 0)
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    Icons.star,
                                    size: 20,
                                    color: (i < apiRating)
                                        ? Colors.yellow
                                        : Colors.grey,
                                  );
                                }),
                              ),
                            ),

                          // Email
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Email: ${item.email}",
                                style: const TextStyle(color: Colors.white70)),
                          ),

                          const SizedBox(height: 6),

                          // ==== ADMIN REPLY (if available) ====
                          if (item.reply.isNotEmpty)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  backgroundImage:
                                  const AssetImage("assets/logo2.png"),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: _ExpandableText(
                                      text: "Reply: ${item.reply}",
                                      textStyle: const TextStyle(
                                          color: Colors.greenAccent),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          // ==== ACTION BUTTONS ====
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Edit Button
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  final editController = TextEditingController(
                                      text: item.query);
                                  final RxInt editRating = (apiRating).obs;

                                  Get.defaultDialog(
                                    title: "Edit Feedback",
                                    content: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.green, width: 2),
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: TextField(
                                            controller: editController,
                                            maxLines: 5,
                                            maxLength: 250,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                              hintText: "Update feedback",
                                              hintStyle: TextStyle(
                                                  color: Colors.black54),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        // Stars
                                        Obx(() {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: List.generate(5, (i) {
                                              return IconButton(
                                                onPressed: () {
                                                  editRating.value = i + 1;
                                                },
                                                icon: Icon(
                                                  Icons.star,
                                                  size: 30,
                                                  color: (editRating.value >=
                                                      i + 1)
                                                      ? Colors.yellow
                                                      : Colors.grey.shade300,
                                                  shadows: const [
                                                    Shadow(
                                                        color: Colors.green,
                                                        blurRadius: 1)
                                                  ],
                                                ),
                                              );
                                            }),
                                          );
                                        }),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text("Cancel",
                                            style:
                                            TextStyle(color: Colors.red)),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        onPressed: () {
                                          if (editRating.value == 0) {
                                            Get.snackbar("Error",
                                                "Please select rating before update",
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white);
                                            return;
                                          }
                                          controller.updateFeedback(
                                              item.id,
                                              editRating.value.toString(),
                                              editController.text);
                                          editController.clear();
                                          Get.back();
                                        },
                                        child: const Text("Update"),
                                      )
                                    ],
                                  );
                                },
                              ),
                              // Delete Button
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "Confirm Delete",
                                    middleText:
                                    "Do you want to delete this feedback?",
                                    textCancel: "No",
                                    textConfirm: "Yes",
                                    confirmTextColor: Colors.white,
                                    buttonColor: Colors.red,
                                    onConfirm: () {
                                      Get.back();
                                      controller.deleteFeedback(item.id);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ================== Expandable Text Widget ==================
class _ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  const _ExpandableText(
      {Key? key, required this.text, required this.textStyle})
      : super(key: key);

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  bool expanded = false;
  static const int limit = 100;

  @override
  Widget build(BuildContext context) {
    final bool showButton = widget.text.length > limit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          expanded
              ? widget.text
              : (widget.text.length > limit
              ? "${widget.text.substring(0, limit)}..."
              : widget.text),
          style: widget.textStyle,
        ),
        if (showButton)
          InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Text(
              expanded ? "Show Less" : "Show More",
              style: const TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ),
      ],
    );
  }
}