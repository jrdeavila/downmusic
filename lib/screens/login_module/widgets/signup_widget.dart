import 'package:downmusic/controllers/login_controller.dart';
import 'package:downmusic/widgets/button_widget.dart';
import 'package:downmusic/widgets/text_button_widget.dart';
import 'package:downmusic/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpWidget extends StatelessWidget {
  final void Function() onTap;
  final void Function() googleOnTap;
  final LoginController loginCtrl = Get.put(LoginController());

  SignUpWidget({Key? key, required this.onTap, required this.googleOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final emailCtrl = TextEditingController(text: loginCtrl.email.value),
        passwordCtrl = TextEditingController(text: loginCtrl.password.value),
        confPasswordCtrl =
            TextEditingController(text: loginCtrl.confPassword.value);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
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
        Obx(() {
          var messageValid = loginCtrl.validatePassword();
          var messageValidConfirm = loginCtrl.validateConfirmPassword();
          return Column(children: [
            TextFieldWidget(
              controller: passwordCtrl,
              obscureText: loginCtrl.visibilityPass.value,
              icon: Icons.lock_outline,
              hintText: 'password_label'.tr,
              errorText: messageValid?.tr,
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
            ),
            TextFieldWidget(
              controller: confPasswordCtrl,
              obscureText: loginCtrl.visibilityPass.value,
              icon: Icons.lock_outline,
              errorText: messageValidConfirm?.tr,
              hintText: 'confirm_password_label'.tr,
              onChanged: (value) => loginCtrl.setConfirmPassword(value),
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
            ),
          ]);
        }),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          title: 'sign_up_button'.tr,
          hasBorder: false,
          onTap: () async {
            await loginCtrl.register();
          },
        ),
        ButtonWidget(
          title: 'sign_up_with_google'.tr,
          icon: Icons.android,
          color: Colors.black87,
          textColor: Colors.white,
          hasBorder: false,
          onTap: googleOnTap,
        ),
        TextButtonWidget(
          title: 'have_account'.tr,
          onTap: onTap,
        ),
      ],
    );
  }
}
