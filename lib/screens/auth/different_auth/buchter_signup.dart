import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maveshi/utils/utils.dart';
import 'package:maveshi/widgets/custom_nav_bar.dart';
import 'package:maveshi/widgets/round_button.dart';

import '../../../widgets/textfield_normal.dart';
import '../sign_in_screen.dart';

class ButcherSignUp extends StatefulWidget {
  static const routeName = 'butcher-signup';
  const ButcherSignUp({Key? key}) : super(key: key);

  @override
  State<ButcherSignUp> createState() => _ButcherSignUpState();
}

class _ButcherSignUpState extends State<ButcherSignUp> {
  final fireStore = FirebaseFirestore.instance.collection('butcher');
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final experienceController = TextEditingController();
  final memberController = TextEditingController();
  bool loading = false;
  File? image;
//this function is for to pick image from Camera
  pickCameraImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) return;
    final imagePath = File(image.path);
    setState(() {
      this.image = imagePath;
    });
  }

//this function is for picking from gallery
  Future bPickGalleryImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (image == null) return;
    final imagePath = File(image.path);
    setState(() {
      this.image = imagePath;
    });
  }

  Future<void> signUpButcher() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference ref = firebaseStorage
        .ref()
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(File(image!.path));
    String bPicUrl = await ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("butcherCollection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'fullName': fullNameController.text,
      'phone': phoneNumberController.text,
      'address': addressController.text,
      'experience': experienceController.text,
      'profilePicture': bPicUrl,
      // "isUser": false,
      // "isDriver": false,
      // "isButcher": true,
      // "isSeller": false,
      // "isDoctor": false,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Completed!');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CustomNavigationBar()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('As a butcher'.tr),
        ),
        body: currentUser == null
            ? Center(
                child: AlertDialog(
                    title: const Text("Attention!"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text('sign in'.tr))
                    ],
                    content: const Text(
                        'Sign In Please before joining as butcher!')),
              )
            : SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            image != null
                                ? CircleAvatar(
                                    backgroundColor: const Color(0xff2769ab),
                                    radius: 60,
                                    foregroundImage: FileImage(
                                      image!,
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Color(0xff2769ab),
                                    radius: 60,
                                    child: Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => bPickGalleryImage(),
                              child: Container(
                                height: 35,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xff2769ab),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => pickCameraImage(),
                              child: Container(
                                height: 35,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xff2769ab),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nunito'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: fullNameController,
                          labelText: 'name'.tr,
                          hintText: 'Full Name',
                          icon: Icons.person,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: phoneNumberController,
                          labelText: 'Phone',
                          hintText: 'Enter phone Number',
                          icon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: addressController,
                          labelText: 'Address',
                          hintText: 'Address',
                          icon: Icons.location_on,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: experienceController,
                          labelText: 'Experience',
                          hintText: 'Experience in Years',
                          icon: Icons.kayaking,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: memberController,
                          labelText: 'Team Or Individual',
                          hintText: 'Team Or Individual',
                          icon: Icons.location_on,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundButton(
                            loading: loading,
                            title: 'Register',
                            onPress: () {
                              setState(() {
                                loading = true;
                              });
                              signUpButcher();
                            })
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
