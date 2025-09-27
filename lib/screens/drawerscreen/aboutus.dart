import 'package:flutter/material.dart';
import '../../widget/CustomerDrawerAppBar.dart';
import '../../widget/text_widget.dart';



class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomerDrawerAppBar(
        title: "About Us",
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BalooSubtitleText(
            text: "Welcome to our app!\n\n"
                "We are committed to providing the best service and experience to our users. "
                "Our mission is to bring value through innovation and dedication.\n\n"
                "Thank you for being part of our journey!",
            fontSize: 18,

            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
