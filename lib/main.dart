import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:maveshi/screens/auth/different_auth/buchter_signup.dart';
import 'package:maveshi/screens/auth/different_auth/driver_signup.dart';
import 'package:maveshi/screens/auth/different_auth/reset_email_sent.dart';
import 'package:maveshi/screens/auth/different_auth/sell_yr_animal.dart';
import 'package:maveshi/screens/auth/different_auth/veterinary_doctor_signup.dart';
import 'package:maveshi/screens/auth/otp_screen.dart';
import 'package:maveshi/screens/auth/sign_in_screen.dart';
import 'package:maveshi/screens/bottom_nav_bar_screens/search_screen.dart';
import 'package:maveshi/screens/favorite_screen.dart';
import 'package:maveshi/services/language_services.dart';
import 'package:maveshi/utils/colors.dart';
import 'package:maveshi/widgets/custom_nav_bar.dart';
import 'package:maveshi/widgets/splash_screen.dart';

import '../screens/animal_categories_screens/buffalo_category_screen.dart';
import '../screens/animal_categories_screens/bull_category_screen.dart';
import '../screens/animal_categories_screens/cow_category_screen.dart';
import '../screens/animal_categories_screens/goat_category_screen.dart';
import '../screens/animal_categories_screens/sheep_category_screen.dart';
import '../screens/bottom_nav_bar_screens/home_page.dart';
import '../screens/bottom_nav_bar_screens/profile_screen.dart';
import 'screens/auth/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LanguageServices(),
      locale: const Locale("en"),
      fallbackLocale: const Locale("en", "US"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColour.primaryColor,
          secondary: AppColour.primaryColor,
        ),
      ),
      title: 'Maveshi App',
      initialRoute: '/',
      routes: {
        '/': (ctx) => const SplashScreen(),
        ProfileScreen.routeName: (ctx) => const ProfileScreen(),
        CustomNavigationBar.routeName: (ctx) => const CustomNavigationBar(),
        FavoritesScreen.routeName: (ctx) =>
            const FavoritesScreen(animalType: ''),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        ResetEmailSentScreen.routeName: (ctx) => const ResetEmailSentScreen(),
        CowCategory.routeName: (ctx) => const CowCategory(animalType: ''),
        BuffaloCategoryScreen.routeName: (ctx) => const BuffaloCategoryScreen(
              animalType: '',
            ),
        GoatCategoryScreen.routeName: (ctx) => const GoatCategoryScreen(
              animalType: '',
            ),
        SheepCategoryScreen.routeName: (ctx) => const SheepCategoryScreen(
              animalType: '',
            ),

        BullCategoryScreen.routeName: (ctx) => const BullCategoryScreen(
              animalType: '',
            ),
        // FavoriteScreen.routeName: (ctx) => const FavoriteScreen(),
        SellYourAnimal.routeName: (ctx) => const SellYourAnimal(
              animalType: '',
            ),
        ButcherSignUp.routeName: (ctx) => const ButcherSignUp(),
        VeterinaryDoctorSignUp.routeName: (ctx) =>
            const VeterinaryDoctorSignUp(),
        SignUpScreen.routeName: (ctx) => const SignUpScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        OTPScreen.routeName: (ctx) => const OTPScreen(verificationId: ''),
        DriverSignUp.routeName: (ctx) => const DriverSignUp(),
        SearchScreen.routeName: (ctx) => const SearchScreen()
      },
    );
  }
}
