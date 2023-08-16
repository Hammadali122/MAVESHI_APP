import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maveshi/models/butcher_profile_model.dart';
import 'package:maveshi/utils/fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ButcherDetailScreen extends StatefulWidget {
  static const routeName = '/Product-detail';
  final ButcherProfile butcherDetails;

  const ButcherDetailScreen({
    Key? key,
    required this.butcherDetails,
  }) : super(key: key);

  @override
  State<ButcherDetailScreen> createState() => _ButcherDetailScreenState();
}

class _ButcherDetailScreenState extends State<ButcherDetailScreen> {
  //================for whatsapp chat============================
  whatsapp() async {
    var contact = widget.butcherDetails.phone.toString();
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Assalam walikum ${widget.butcherDetails.fullName.toString()}";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Assalam walikum ${widget.butcherDetails.fullName.toString()}')}";

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
    var contact = widget.butcherDetails.phone.toString();

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
        title: const Text("Butcher Details"),
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
                      widget.butcherDetails.profilePicUrl.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.butcherDetails.fullName.toString(),
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
                      widget.butcherDetails.address.toString(),
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
                            'Contact : ${widget.butcherDetails.phone.toString()}'),
                      ),
                      const Divider(),
                      const SizedBox(height: 0),
                      ListTile(
                        title: Text(
                            'Member : ${widget.butcherDetails.member.toString()}'),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                            'Experience : ${widget.butcherDetails.experience.toString()} year'),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => call(),
                            child: const Card(
                              color: Color(0xff2769ab),
                              elevation: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Icon(
                                  Icons.chat_bubble,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => whatsapp(),
                            child: Card(
                              elevation: 8,
                              color: const Color(0xff2769ab),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
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
