import 'package:flutter/material.dart';
import 'package:maveshi/widgets/round_button.dart';

class OTPScreen extends StatefulWidget {
  static const routeName = '/otp';
  final String verificationId;
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Sign in'),
      ),
      body: Column(
        children: [
          Text(widget.verificationId),
          const Text('Enter the OTP code,we sent on'),
          const Text('3463526706'),
          //OTP
          RoundButton(title: 'Send', onPress: () {})
        ],
      ),
    );
  }
}
