import 'package:flutter/material.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';

import '../../../widgets/round_button.dart';

class ResetEmailSentScreen extends StatefulWidget {
  static const routeName = 'reset-email-screen';
  const ResetEmailSentScreen({Key? key}) : super(key: key);

  @override
  State<ResetEmailSentScreen> createState() => _ResetEmailSentScreenState();
}

class _ResetEmailSentScreenState extends State<ResetEmailSentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Reset Email Sent",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "We have sent all requires instruction to your mail.",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
                title: 'Go To Login',
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
