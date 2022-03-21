import 'package:downmusic/controllers/login_controller.dart';
import 'package:downmusic/screens/login_module/widgets/login_widget.dart';
import 'package:downmusic/screens/login_module/widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreenWeb extends StatelessWidget {
  final pageCtrl = PageController(initialPage: 0);
  final loginCtrl = Get.put(LoginController());

  AuthScreenWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Obx(() => Text(loginCtrl.pageTitle.value.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: !isDarkMode
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900))),
              ),
              SizedBox(
                width: 500,
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
            ]),
      ),
    );
  }

  Widget _logIn(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: LoginWidget(
        onTap: () {
          pageCtrl.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }

  Widget _signIn(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SignUpWidget(
        onTap: () {
          pageCtrl.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        },
        googleOnTap: () {},
      ),
    );
  }
}
