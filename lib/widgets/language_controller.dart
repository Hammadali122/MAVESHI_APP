import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  static void changeLanguage(var param1) {
    var locale = Locale(param1);

    Get.updateLocale(locale);
  }
}
