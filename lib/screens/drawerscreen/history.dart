import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/appcolorsconst.dart';



class HistoryTransactionsScreen extends StatelessWidget {
  const HistoryTransactionsScreen({super.key});

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
          "Transactions",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.greencolor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TransactionCard(
            orderId: "DL14CF8351",
            date: "19th Feb 2025",
            amount: "1000",
            status: "Success",
          ),
          SizedBox(height: 12),
          TransactionCard(
            orderId: "DL14CF8351",
            date: "19th Feb 2025",
            amount: "1000",
            status: "Success",
          ),
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String amount;
  final String status;

  const TransactionCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side (Order ID + Date)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order ID",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "$orderId ($date)",
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),

          // Right Side (Amount + Status)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Rs $amount",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: const TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
