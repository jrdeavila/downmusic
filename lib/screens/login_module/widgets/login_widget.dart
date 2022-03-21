import 'package:downmusic/controllers/login_controller.dart';
import 'package:downmusic/controllers/reparir_components_controller.dart';
import 'package:downmusic/widgets/button_widget.dart';
import 'package:downmusic/widgets/text_button_widget.dart';
import 'package:downmusic/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWidget extends StatelessWidget {
  final void Function() onTap;
  final LoginController loginCtrl = Get.put(LoginController());
  final repairController = Get.put(RepairComponentController());

  LoginWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final emailCtrl = TextEditingController(text: loginCtrl.email.value),
        passwordCtrl = TextEditingController(text: loginCtrl.password.value);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          var messageValid = loginCtrl.validateEmail();
          return TextFieldWidget(
            controller: emailCtrl,
            icon: Icons.email_outlined,
            hintText: 'email_label'.tr,
            errorText: messageValid?.tr,
            onChanged: (value) => loginCtrl.setEmail(value),
          );
        }),
        Obx(() => TextFieldWidget(
              controller: passwordCtrl,
              obscureText: loginCtrl.visibilityPass.value,
              icon: Icons.lock_outline,
              hintText: 'password_label'.tr,
              onChanged: (value) => loginCtrl.setPassword(value),
              suffixIcon: GestureDetector(
                onTap: () => loginCtrl.visibilityPassword(),
                child: Icon(
                  loginCtrl.visibilityPass.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: isDarkMode
                      ? Theme.of(context).primaryColorLight
                      : Theme.of(context).primaryColor,
                  size: 18,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: InkWell(
            onTap: () {},
            child: Text(
              'forgot_password'.tr,
              style: TextStyle(
                color: isDarkMode
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        ButtonWidget(
          title: 'login_button'.tr,
          hasBorder: false,
          onTap: () async {
            await loginCtrl.login();
          },
        ),
        Obx(() {
          var isReady = repairController.googleButtonIsVisible.value;
          return isReady
              ? ButtonWidget(
                  title: 'sign_in_with_google'.tr,
                  icon: Icons.android,
                  color: Colors.black87,
                  textColor: Colors.white,
                  hasBorder: false,
                  onTap: () async {
                    await loginCtrl.loginWithGoogle();
                  },
                )
              : Container();
        }),
        TextButtonWidget(
          title: "no_have_account".tr,
          onTap: onTap,
        ),
      ],
    );
  }
}
