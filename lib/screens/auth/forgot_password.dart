import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maveshi/screens/auth/different_auth/reset_email_sent.dart';
import 'package:maveshi/utils/utils.dart';

import '../../widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = 'forgot-password-screen';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  void resetPassword() {
    setState(() {
      loading = true;
    });
    _auth.sendPasswordResetEmail(email: emailController.text).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Email has been sent your mail...');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
      Navigator.pushNamed(context, ResetEmailSentScreen.routeName);
    });
  }

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
              "Forgot Password",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Enter your email to reset your password.",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.alternate_email)),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter Email plz';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
                loading: loading,
                title: 'Reset Password',
                onPress: () {
                  resetPassword();
                }),
          ],
        ),
      ),
    );
  }
}
