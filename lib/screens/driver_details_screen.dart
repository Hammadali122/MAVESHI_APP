import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maveshi/utils/fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/driver_model.dart';

class DriverDetailsScreen extends StatefulWidget {
  final DriverProfileModel driverDetails;
  const DriverDetailsScreen({Key? key, required this.driverDetails})
      : super(key: key);

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  //================for whatsapp chat============================
  whatsapp() async {
    var contact = widget.driverDetails.phone.toString();
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Assalam walikum ${widget.driverDetails.fullName.toString()}";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Assalam walikum ${widget.driverDetails.fullName.toString()}')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      const Text('WhatsApp is not installed.');
    }
  }

  //==============for direct call================================
  call() async {
    var contact = widget.driverDetails.phone.toString();

    var androidCallUrl = "tel:$contact";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi')}";

    try {
      if (Platform.isAndroid) {
        await launchUrl(Uri.parse(androidCallUrl));
      } else if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      }
    } on Exception {
      const Center(child: Text('Failed to launch WhatsApp or make a call.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2769ab),
        title: const Text("Driver Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      widget.driverDetails.profilePicture.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.driverDetails.fullName.toString(),
                    style: AppFonts.boldText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 29),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.driverDetails.address.toString(),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Seller Detail',
                          style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
                        ),
                      ),
                      const SizedBox(height: 0),
                      ListTile(
                        title: Text(
                            'Contact : ${widget.driverDetails.phone.toString()}'),
                      ),
                      const Divider(),
                      const SizedBox(height: 0),
                      ListTile(
                        title: Text(
                            'Car Type : ${widget.driverDetails.carType.toString()}'),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                            'Experience : ${widget.driverDetails.experience.toString()} year'),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => whatsapp(),
                            child: Card(
                              color: const Color(0xff2769ab),
                              elevation: 8,
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Image.asset(
                                  'assets/icons/whatsapp.png',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => call(),
                            child: const Card(
                              elevation: 8,
                              color: Color(0xff2769ab),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Card(
                            color: Color(0xff2769ab),
                            elevation: 8,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
