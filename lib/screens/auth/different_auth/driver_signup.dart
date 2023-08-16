import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maveshi/screens/bottom_nav_bar_screens/home_page.dart';
import 'package:maveshi/widgets/round_button.dart';

import '../../../utils/utils.dart';
import '../../../widgets/textfield_normal.dart';
import '../sign_in_screen.dart';

class DriverSignUp extends StatefulWidget {
  static const routeName = 'driver-signup';
  const DriverSignUp({Key? key}) : super(key: key);

  @override
  State<DriverSignUp> createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {
  bool loading = false;
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final experienceController = TextEditingController();
  final carTypeController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    experienceController.dispose();
    carTypeController.dispose();
  }

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
  Future dPickGalleryImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (image == null) return;
    final imagePath = File(image.path);
    setState(() {
      this.image = imagePath;
    });
  }

  driverSignUp() async {
    setState(() {
      loading = true;
    });
    final fireStore =
        FirebaseFirestore.instance.collection('DriversCollection');
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference ref = firebaseStorage
        .ref()
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(File(image!.path));
    String url = await ref.getDownloadURL();
    setState(() {
      loading = true;
    });
    var diverId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("DriverCollection").doc(diverId).set({
      'fullName': fullNameController.text,
      'phone': phoneNumberController.text,
      'address': addressController.text,
      'experience': experienceController.text,
      'carType': carTypeController.text,
      'profilePicture': url,
      "isUser": false,
      "isDriver": true,
      "isButcher": false,
      "isSeller": false,
      "isDoctor": false,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Uploaded!');
      Navigator.pushNamed(context, HomeScreen.routeName);
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
          title: const Text('As a Driver'),
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
                          child: const Text('Sign In'))
                    ],
                    content:
                        const Text('Sign In Please before joining as driver!')),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            image != null
                                ? CircleAvatar(
                                    radius: 60,
                                    foregroundImage: FileImage(image!),
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
                              onTap: () => dPickGalleryImage(),
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
                          labelText: 'Name',
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
                          controller: carTypeController,
                          labelText: 'Car',
                          hintText: 'Dyna or Suzuki etc',
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
                        RoundButton(
                            loading: loading,
                            title: 'Register',
                            onPress: () {
                              driverSignUp();
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
