import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maveshi/utils/colors.dart';
import 'package:maveshi/widgets/custom_nav_bar.dart';
import 'package:maveshi/widgets/round_button.dart';

import '../../../utils/utils.dart';

class SellYourAnimal extends StatefulWidget {
  static const routeName = '/seller-profile';
  // final Animal animalDetails;

  const SellYourAnimal({
    Key? key,
    required String animalType,
  }) : super(key: key);

  @override
  State<SellYourAnimal> createState() => _SellYourAnimalState();
}

class _SellYourAnimalState extends State<SellYourAnimal> {
  String _currentMessage = "";
  int selected = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

// ======================to get the location of the seller from device ===========================

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
          '${currentPlace.subLocality}  ${currentPlace.locality} , ${currentPlace.administrativeArea} , ${currentPlace.country}';
    });
  }

  final _animalList = ['Buffalo', 'sheep', 'cow', 'goat', 'bull', 'lamb'];

  String? _selectedVal = "";
  bool loading = false;
  String? country;
  String? state;
  String? city;
  int weight = 70;

  _SellYourAnimalState() {
    _selectedVal = _animalList[0];
  }
  File? image;

// ====================== picking image from camera =======================
  pickCameraImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) return;
    final imagePath = File(image.path);
    setState(() {
      this.image = imagePath;
    });
  }

//=================picking image from gallery======================================
  Future pickGalleryImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (image == null) return;
    final imagePath = File(image.path);
    setState(() {
      this.image = imagePath;
    });
  }

  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final priceController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    weightController.dispose();
    ageController.dispose();
    priceController.dispose();
    nameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
  }

//=============function for sending  data of the seller information to firestore=======================================
  final fireStore = FirebaseFirestore.instance.collection('SellYourAnimal');
  void liveStock() async {
    setState(() {
      loading = true;
    });
    FirebaseStorage fs = FirebaseStorage.instance;
    Reference ref =
        fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
    await ref.putFile(File(image!.path));
    String url = await ref.getDownloadURL();
    var uuid = FirebaseAuth.instance.currentUser?.uid;
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    await fireStore.add({
      'sellerName': nameController.text,
      'age': ageController.text.trim(),
      'phone': phoneController.text.trim(),
      'description': descriptionController.text,
      'price': priceController.text,
      'weight': weightController.text,
      'imagePath': url,
      'animalType': _selectedVal,
      'currentLocation': _currentMessage,
      'uid': uuid,
      "postDate": formattedDate
    }).then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Data Uploaded Successfully!');
      Navigator.pushNamed(context, CustomNavigationBar.routeName);
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sell your livestock',
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 250,
                      width: 500,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: image != null
                          ? Image.file(
                              image!,
                              height: 250,
                              width: 500,
                              fit: BoxFit.fill,
                            )
                          : const Center(
                              child: Text(
                              'No Image yet!',
                              style: TextStyle(fontFamily: 'Nunito'),
                            ))),

                  // Row for custom buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => pickGalleryImage(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xff2769ab),
                          ),
                          child: const Center(
                            child: Text(
                              'Gallery',
                              style: TextStyle(
                                  fontFamily: 'Nunito', color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => pickCameraImage(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xff2769ab),
                          ),
                          child: const Center(
                            child: Text(
                              'Camera',
                              style: TextStyle(
                                  fontFamily: 'Nunito', color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => _getCurrentLocation(),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all()),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xff2769ab),
                          ),
                          _currentMessage == ""
                              ? const Text('  Address getting')
                              : Text(
                                  _currentMessage,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.cable_outlined,
                            color: Color(0xff2769ab),
                          ),
                          const SizedBox(
                            width: 9,
                          ),
                          const Text(
                            'Animal',
                            style: TextStyle(fontFamily: 'Nunito'),
                          ),
                          const Spacer(),
                          DropdownButton(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(5),
                            icon: const Icon(Icons.add),
                            items: _animalList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                            fontFamily: 'Nunito'),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _selectedVal = val.toString();
                                },
                              );
                            },
                            value: _selectedVal,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 2,
                  ),

                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: weightController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.line_weight,
                            color: AppColour.primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Kg',
                          labelText: 'Weight in Kg'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: ageController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.access_time_rounded,
                            color: AppColour.primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Years',
                          labelText: 'Age in Years'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            LineIcons.calendar,
                            color: AppColour.primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Price',
                          labelText: 'Price(PKR)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.description,
                            color: AppColour.primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'For example: having any child,etc',
                          helperMaxLines: 3,
                          labelText: 'Description'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColour.primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'NAME',
                          helperMaxLines: 3,
                          labelText: 'Enter Name'),
                    ),
                  ),

                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.mobile_friendly_outlined,
                            color: AppColour.primaryColor,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'MOBILE NUMBER',
                          helperMaxLines: 3,
                          labelText: 'Enter Mobile Number'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  RoundButton(
                      loading: loading,
                      title: 'Save',
                      onPress: () {
                        liveStock();
                      })
                ]),
          ),
        )));
  }
}
