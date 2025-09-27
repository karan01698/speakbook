import 'package:flutter/material.dart';
import '../../widget/CustomerDrawerAppBar.dart';
import '../../widget/text_widget.dart';


class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomerDrawerAppBar(
        title: "Terms & Conditions",
        showBackButton: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BalooSubtitleText(
            text:
            'By using this app, you agree to our terms and conditions:\n\n'
                '1. Users must be 18 or older.\n'
                '2. Do not misuse the platform.\n'
                '3. We reserve the right to suspend any account violating the rules.\n'
                '4. Data usage is governed by our privacy policy.\n\n'
                'Please read all terms carefully before using the app.',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
