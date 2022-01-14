import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  changeMode() {
    var theme = Get.theme;
    if (theme.brightness == Brightness.dark) {
      Get.changeTheme(ThemeData(
          brightness: Brightness.light, primaryColor: Colors.lightBlue));
    } else {
      Get.changeTheme(ThemeData.dark());
    }
  }

  changeTheme() {
    var theme = Get.theme;
    if (theme.primaryColor == Colors.lightBlue) {
      Get.changeTheme(ThemeData(
        primaryColor: Colors.lightGreen,
      ));
    } else if (theme.primaryColor == Colors.lightGreen) {
      Get.changeTheme(ThemeData(
        primaryColor: Colors.lightBlue,
      ));
    }
  }

  changeLocale() {
    var locale = Get.locale;
    if (locale != null) {
      if (locale.languageCode == 'es') {
        Get.updateLocale(const Locale('en', 'US'));
      } else {
        Get.updateLocale(const Locale('es', 'ES'));
      }
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
