import 'package:flutter/material.dart';
import 'package:maveshi/services/splash_services.dart';
import 'package:maveshi/utils/colors.dart';

import '../utils/utilsold.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColour.secondaryColor,
                  AppColour.primaryColor,
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(4, 9, 35, 1),
                  Color.fromRGBO(39, 105, 171, 1),
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/pictures/maveshiLogo.png',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Maveshi App',
                style: TextStyle(
                  letterSpacing: 3,
                  color: Colors.white,
                  fontSize: 34,
                  fontFamily: 'Nisebuschgardens',
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Unlock the Livestock Market\n"
                "Connect, Trade, Thrive!",
                textAlign: TextAlign.center,
                style: safeGoogleFont(
                  'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.625,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
