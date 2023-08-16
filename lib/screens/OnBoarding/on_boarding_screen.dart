import 'package:flutter/material.dart';

import '../../utils/utilsold.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          // android1M3U (11:1903)
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // skip7Cz (11:1906)
                margin: EdgeInsets.fromLTRB(
                    0 * fem, 0 * fem, 30 * fem, 49.35 * fem),
                child: Text(
                  'Skip',
                  style: safeGoogleFont(
                    'DM Sans',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.3025 * ffem / fem,
                    color: const Color(0xff4266b2),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 84.63 * fem, 0 * fem),
                width: 198.81 * fem,
                height: 216.22 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff4266b2),
                ),
                child: Image.asset(
                  'assets/sound-bar-app-ui/images/logo77.png',
                  width: 198.81 * fem,
                  height: 216.22 * fem,
                ),
              ),
              Container(
                // autogroupsfxc76W (QNjEsxFQQquwR8iYT8sFXC)
                padding: EdgeInsets.fromLTRB(
                    33 * fem, 72.59 * fem, 33 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // group427320321R7C (11:1943)
                      margin: EdgeInsets.fromLTRB(
                          30 * fem, 0 * fem, 12.12 * fem, 12.7 * fem),
                      width: double.infinity,
                      height: 52.45 * fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // attachment16440472611v3x (11:1944)
                            left: 70 * fem,
                            top: 3.7481079102 * fem,
                            child: Align(
                              child: SizedBox(
                                  width: 251.88 * fem,
                                  height: 48.7 * fem,
                                  child: Text(
                                    'MAVESHI APP',
                                    style: safeGoogleFont(
                                      'DM Sans',
                                      fontSize: 23 * ffem,
                                      fontWeight: FontWeight.w900,
                                      height: 1.625 * ffem / fem,
                                      letterSpacing: -0.3555555642 * fem,
                                      color: const Color(0x7f000000),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // soundbarhelpsartistinthemusici (11:1905)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 82.5 * fem),
                      constraints: BoxConstraints(
                        maxWidth: 294 * fem,
                      ),
                      child: Text(
                        'Sound Bar helps artist in the music industry to find each other so that they can collabrate and create music together easier.',
                        textAlign: TextAlign.center,
                        style: safeGoogleFont(
                          'DM Sans',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.625 * ffem / fem,
                          letterSpacing: -0.3555555642 * fem,
                          color: const Color(0x7f000000),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        // buttonVug (11:1909)
                        margin: EdgeInsets.fromLTRB(
                            3.45 * fem, 0 * fem, 3.45 * fem, 0 * fem),
                        width: double.infinity,
                        height: 56 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xff4266b2),
                          borderRadius: BorderRadius.circular(16 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Get Started',
                            textAlign: TextAlign.center,
                            style: safeGoogleFont(
                              'DM Sans',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.7142857143 * ffem / fem,
                              letterSpacing: -0.3000000119 * fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // gestureswipeZ8r (I21:18662;20:8597)
                padding: EdgeInsets.fromLTRB(
                    148 * fem, 28 * fem, 148 * fem, 4 * fem),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Align(
                  // rectangleHae (I21:18662;20:8597;20:8595)
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 2 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32 * fem),
                        color: const Color(0xff949494),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
