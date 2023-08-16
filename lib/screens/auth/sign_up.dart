import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';
import 'package:maveshi/screens/bottom_nav_bar_screens/profile_screen.dart';
import 'package:maveshi/utils/fonts.dart';
import 'package:maveshi/widgets/round_button.dart';

import '../../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  final fireStore = FirebaseFirestore.instance.collection('user');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _currentMessage = "";
  //=======================================USER-LOCATION===================================================

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark currentPlace = placeMarks[0];

    setState(() {
      _currentMessage =
          '${currentPlace.subLocality}  ${currentPlace.locality} , ${currentPlace.administrativeArea} ';
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  //=======================================SIGN UP USER===================================================
  void signUp() {
    try {
      setState(() {
        loading = true;
      });
      var fullName = userNameController.text.trim();
      var email = emailController.text.trim();
      var password = passwordController.text.trim();
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((error) {
        final currentUser = FirebaseAuth.instance.currentUser?.uid;

        fireStore
            .doc(currentUser)
            .set({
              'UserName': fullName,
              'UserEmail': email,
              'TimeCreation': DateTime.now().year,
              "location": _currentMessage,
              'UserId': currentUser,
              "isUser": true,
              "isDriver": false,
              "isButcher": false,
              "isSeller": false,
              "isDoctor": false,
            })
            .then((value) => {
                  setState(() {
                    loading = false;
                  }),
                  Utils().toastMessage('Profile Completed!'),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()))
                })
            .onError((error, stackTrace) {
              setState(() {
                loading = false;
              });
              return Utils().toastMessage(error.toString());
            });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils().toastMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils().toastMessage('The account already exists for that email.');
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
    String _password = '';
    String _confirmPassword = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'sign up'.tr,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "getting started".tr,
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "seem your are new here!".tr,
                        style: AppFonts.normalText,
                      ),
                      Text(
                        "let's setup your profile".tr,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: "name".tr,
                            prefixIcon: const Icon(Icons.person)),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'enter your name'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'email'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
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
                        decoration: InputDecoration(
                            labelText: _currentMessage ?? "",
                            hintText: _currentMessage,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            prefixIcon: const Icon(Icons.location_on)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'password'.tr,
                            prefixIcon: const Icon(Icons.lock_open),
                            suffixIcon: GestureDetector(
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please confirm your password'.tr;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // TextFormField(
                      //   obscureText: _obscureText,
                      //   controller: confirmPasswordController,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(14)),
                      //     labelText: 'Confirm password',
                      //     prefixIcon: const Icon(Icons.lock_open),
                      //     suffixIcon: GestureDetector(
                      //       child: Icon(
                      //         _obscureText
                      //             ? Icons.visibility
                      //             : Icons.visibility_off,
                      //       ),
                      //       onTap: () {
                      //         setState(() {
                      //           _obscureText = !_obscureText;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Password must be six characters!';
                      //     }
                      //     if (value == _password) {
                      //       return 'Passwords do not match';
                      //     }
                      //     return null;
                      //   },
                      //   onSaved: (value) {
                      //     _confirmPassword = _password;
                      //   },
                      // ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                  loading: loading,
                  title: 'sign up'.tr,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already have an account'.tr),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Text('sign in'.tr),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
