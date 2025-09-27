import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/appcolorsconst.dart';
import '../../utils/validator.dart';


class NewFastTagsScreen extends StatelessWidget {
  NewFastTagsScreen({super.key});

  final nameController = TextEditingController();
  final contactController = TextEditingController();

  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pinController = TextEditingController();
  final stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "New Fast Tags",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.greencolor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Price Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      // Text("For Private Vehicle",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Pre Loaded Amount"),
                      Text("Rs 100"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Tag Cost"),
                      Text("Rs 199"),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Total Payable",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Rs 299",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Input Fields using CustomTextField
            CustomTextField(
              controller: nameController,
              hintText: "Enter Name",
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: contactController,
              hintText: "Contact Number",
              keyboardType: TextInputType.phone,
            ),


            const SizedBox(height: 12),
            CustomTextField(
              controller: emailController,
              hintText: "Email ID",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: addressController,
              hintText: "Enter H. No / Apt / Flat",
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: cityController,
              hintText: "Area/City",
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: pinController,
              hintText: "Pin Code",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: stateController,
              hintText: "State",
            ),

            const SizedBox(height: 20),

            // Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greencolor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Handle Pay action
                },
                child: const Text(
                  "Pay Rs 299",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
