import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maveshi/models/livestock_model.dart';
import 'package:maveshi/utils/fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimalDetailScreen extends StatefulWidget {
  static const routeName = '/Product-detail';
  final Livestock livestockDetails;

  const AnimalDetailScreen({
    Key? key,
    required this.livestockDetails,
  }) : super(key: key);

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  //================for whatsapp chat============================
  whatsapp() async {
    var contact = widget.livestockDetails.phone.toString();
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Assalam walikum ${widget.livestockDetails.sellerName.toString()}";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Assalam walikum ${widget.livestockDetails.sellerName.toString()}')}";

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
    var contact = widget.livestockDetails.phone.toString();

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
        title: const Text('Animal Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.network(
                      widget.livestockDetails.imagePath.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Divider(color: Colors.black87, thickness: 2),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: doneMark(),
                      ),
                      const Text(
                        "Description",
                        style: AppFonts.boldText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: doneMark(),
                      ),
                      Text(
                        "Price : ${widget.livestockDetails.price.toString()}",
                        style: AppFonts.boldText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: doneMark(),
                      ),
                      Text(
                        "Age : ${widget.livestockDetails.age.toString()} years old",
                        style: AppFonts.normalText,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: doneMark(),
                      ),
                      Text(
                        "Weight : ${widget.livestockDetails.weight.toString()} KG",
                        style: AppFonts.normalText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Seller Details',
                        style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
                      ),
                    ),
                    const SizedBox(height: 0),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        widget.livestockDetails.sellerName.toString(),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(widget.livestockDetails.phone.toString()),
                    ),
                    const Divider(),
                    const Center(
                      child: Text(
                        'Contact Detail',
                        style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
                      ),
                    ),
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
                                )),
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
    );
  }

  CircleAvatar doneMark() {
    return const CircleAvatar(
      radius: 8,
      child: Icon(
        Icons.done,
        color: Colors.white,
        size: 12,
      ),
    );
  }
}
