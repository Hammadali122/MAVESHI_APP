import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maveshi/screens/auth/different_auth/buchter_signup.dart';
import 'package:maveshi/screens/auth/different_auth/driver_signup.dart';
import 'package:maveshi/screens/auth/different_auth/sell_yr_animal.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';
import 'package:maveshi/utils/colors.dart';
import 'package:maveshi/utils/fonts.dart';
import 'package:maveshi/widgets/about_us.dart';

import '../screens//bottom_nav_bar_screens/profile_screen.dart';
import '../screens/auth/different_auth/veterinary_doctor_signup.dart';
import '../screens/auth/sign_up.dart';
import '../screens/favorite_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Language"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('URDU'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ENGLISH'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(right: 20),
        children: [
          DrawerHeader(
            curve: Curves.easeInCubic,
            child: Column(
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColour.primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: AppColour.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Stack(
                        children: [
                          const Text(
                            'farooq',
                            style: AppFonts.boldText,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                              child: Text(
                                'view profile'.tr,
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff2769ab)),
                                softWrap: true,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ProfileScreen.routeName);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignUpScreen.routeName);
                      },
                      child: Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff2769ab),
                        ),
                        child: Center(
                          child: Text(
                            'sign up'.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff2769ab),
                        ),
                        child: Center(
                          child: Text(
                            'sign in'.tr,
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Nunito'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.accessibility_sharp),
            title: Text('join as butcher'.tr),
            onTap: () {
              Navigator.of(context).pushNamed(ButcherSignUp.routeName);
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.car),
            title: Text('join as driver'.tr),
            onTap: () {
              Navigator.of(context).pushNamed(DriverSignUp.routeName);
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.doctor),
            title: Text('join as doctor'.tr),
            onTap: () {
              Navigator.of(context).pushNamed(VeterinaryDoctorSignUp.routeName);
            },
          ),
          ListTile(
            leading: const Icon(LineIcons.horse),
            title: Text('sell your animal'.tr),
            onTap: () {
              Navigator.of(context).pushNamed(SellYourAnimal.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: Text('favourite list'.tr),
            onTap: () {
              Navigator.of(context).pushNamed(FavoritesScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('language'.tr),
            onTap: () {
              showLanguageDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'log out'.tr,
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              auth.signOut();
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user_rounded),
            title: Text('about us'.tr),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutUsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
