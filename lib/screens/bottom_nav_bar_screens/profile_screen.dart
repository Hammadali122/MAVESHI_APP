import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';
import 'package:maveshi/utils/fonts.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'Profile-screen';

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username = "";
  late String email = "";
  late String location = "";
  dynamic sinceYear = '';
  DateTime? selectedDateTime;
  //=========================getting user credentials====================
  final currentUser = FirebaseAuth.instance.currentUser;
  getUserNameAndEmail() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    setState(() {
      username = snap['UserName'];
      email = snap['UserEmail'];
      sinceYear = snap['TimeCreation'];
      location = snap['location'];
    });
  }

  //=========================DATE PICKER=================================
  void showDatePickerDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        final formattedDate =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        // Update the date of birth in the state or handle it as required
      }
    });
  }

  @override
  void initState() {
    getUserNameAndEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentUser == null
        ? Center(
            child: AlertDialog(
                title: Text("attention".tr),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text('sign in'.tr))
                ],
                content: Text('sign in please'.tr)),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              backgroundColor: const Color.fromRGBO(39, 105, 171, 1),
              title: Text(
                "profile".tr,
                style: const TextStyle(fontFamily: 'Nunito'),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.done))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color.fromRGBO(39, 105, 171, 1),
                            borderRadius: BorderRadius.circular(3)),
                        child: const Center(
                          child: Icon(
                            LineIcons.userAlt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      title: Text(username),
                      subtitle: Text('SWAT \n'
                              'member since, $sinceYear'
                          .tr),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.edit)),
                    ),
                    const Divider(),
                    ProfileListTile(
                      icon: Icons.location_on,
                      title: 'location'.tr,
                      subTitle: location,
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                    ProfileListTile(
                      icon: Icons.mail,
                      title: "email".tr,
                      subTitle: email,
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                    ProfileListTile(
                      onPress: () {
                        showDatePickerDialog(context);
                      },
                      icon: Icons.location_on,
                      title: 'date of birth'.tr,
                      subTitle: selectedDateTime != null
                          ? DateFormat('dd/MM/yyyy').format(selectedDateTime!)
                          : 'Choose DOB',
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                    ProfileListTile(
                      icon: Icons.boy,
                      title: 'gender'.tr,
                      subTitle: 'Male',
                      trailingIcon: Icons.expand_more,
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          );
  }
}

class ProfileListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData trailingIcon;
  final IconData icon;
  final VoidCallback? onPress;
  const ProfileListTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.trailingIcon,
    required this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      trailing: Icon(trailingIcon),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: const Color.fromRGBO(39, 105, 171, 1),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: AppFonts.normalText,
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
