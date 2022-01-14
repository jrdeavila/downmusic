import 'package:downmusic/controllers/login_controller.dart';
import 'package:downmusic/controllers/theme_controller.dart';
import 'package:downmusic/screens/login_module/widgets/login_widget.dart';
import 'package:downmusic/screens/login_module/widgets/signup_widget.dart';
import 'package:downmusic/widgets/animation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationScreen extends StatelessWidget {
  final pageCtrl = PageController(initialPage: 0);
  AuthenticationScreen({Key? key}) : super(key: key);
  Widget body(context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeCtrl = Get.put(ThemeController());
    final locale = Get.locale ?? const Locale('en', 'US'); 
    final loginCtrl = Get.put(LoginController());
    final keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Stack(
      children: [
        Container(
          height: size.height,
          color: Theme.of(context).primaryColor,
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad,
          top: keyboardIsOpen ? -size.height / (locale.languageCode == 'en' ? 5 : 8) : 0.0,
          child: AnimationWidget(
            size: size,
            yOffset: size.height / 3.0,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad,
          top: keyboardIsOpen ? size.height * 0.04 : 100.0,
          left: keyboardIsOpen ? size.width * 0.05 : (size.width * 0.5 - 100.0),
          child: SizedBox(
            width: 200,
            child: Obx(() => Text(loginCtrl.pageTitle.value.tr,
                textAlign: keyboardIsOpen ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                    color: isDarkMode
                        ? Theme.of(context).primaryColorLight
                        : Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w900))),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          top: keyboardIsOpen ? size.height * 0.15 : size.height * 0.35,
          left: keyboardIsOpen ? size.width * 0.05 : (size.width * 0.5 - 175.0),
          curve: Curves.easeInOutQuad,
          child: SizedBox(
            width: 350,
            height: 500,
            child: PageView(
              controller: pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _logIn(context),
                _signIn(context),
              ],
              onPageChanged: (index) {
                loginCtrl.setPageTitle(index);
              },
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.04,
          right: size.width * 0.03,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.brightness_medium,
                  color: isDarkMode
                      ? Theme.of(context).primaryColorLight
                      : Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  themeCtrl.changeMode();
                },
              ),
              IconButton(
                icon: CircleAvatar(
                  radius: 17.5,
                  backgroundColor: isDarkMode
                      ? Theme.of(context).primaryColorLight
                      : Colors.white,
                  child: Icon(
                    Icons.circle,
                    color: Theme.of(context).primaryColor == Colors.lightBlue
                        ? Colors.lightGreen
                        : isDarkMode
                            ? Theme.of(context).primaryColor
                            : Colors.lightBlue,
                  ),
                ),
                onPressed: () {
                  themeCtrl.changeTheme();
                },
              ),
              IconButton(
                icon:
                    const Icon(Icons.translate, color: Colors.white, size: 35),
                onPressed: () {
                  themeCtrl.changeLocale();
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget _logIn(context) {
    return LoginWidget(
      onTap: () {
          pageCtrl.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
      },

    );
  }

  Widget _signIn(context) {
    return SignUpWidget(
      onTap: () {
        pageCtrl.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
      googleOnTap: () {},
    );
  }
}
