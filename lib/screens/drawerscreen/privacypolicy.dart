import 'package:flutter/material.dart';
import '../../widget/CustomerDrawerAppBar.dart';
import '../../widget/text_widget.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomerDrawerAppBar(
        title: "Privacy Policy",
        showBackButton: false,
      ),

      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BalooSubtitleText(
            text: 'Your privacy is important to us.\n\n'
                'We collect minimal data to provide better services.\n'
                '- No personal data is sold.\n'
                '- Data is encrypted and stored securely.\n'
                '- You have the right to request deletion of your data.\n\n'
                'Contact us for any privacy-related concerns.',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
