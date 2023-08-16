import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:maveshi/screens/auth/sign_up.dart';
import 'package:maveshi/widgets/admin_screen.dart';
import 'package:maveshi/widgets/custom_nav_bar.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {
    try {
      setState(() {
        loading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
        Utils().toastMessage(value.user!.email.toString());
        if (emailController.text == "admin@gmail.com" ||
            passwordController.text == "112233") {
          //===================== return admin page================
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminScreen()));
        } else {
          //====================== return Home screen================
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CustomNavigationBar()));
        }
      }).onError((error, stack) {
        setState(() {
          loading = false;
        });
        Utils().toastMessage(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils().toastMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils().toastMessage('Wrong password provided for that user.');
      } else {
        Utils().toastMessage('Error: ${e.message}');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('sign in'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "let's sign you in".tr,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "welcome back you have been missed!".tr,
                style: const TextStyle(fontSize: 15),
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
                            labelText: 'email'.tr,
                            prefixIcon: const Icon(Icons.alternate_email)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'enter your email'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: obscureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'password'.tr,
                            prefixIcon: const Icon(Icons.lock_open),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            )),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'please confirm your password"';
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
                  title: 'sign in'.tr,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  }),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                  child: Text('forgot password'.tr),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account".tr),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: Text('register'.tr),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // InkWell(
              //   onTap: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => const LoginWithPhoneNum()));
              //   },
              //   child: Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(40),
              //         border: Border.all(color: Colors.black)),
              //     child: const Center(
              //       child: Text('Login With Phone'),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
