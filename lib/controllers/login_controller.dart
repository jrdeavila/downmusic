import 'package:downmusic/controllers/firebase_auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class LoginController extends GetxController {
  final RxString email = ''.obs, password = ''.obs, confPassword = ''.obs;
  final RxString pageTitle = 'login'.obs;
  RxBool visibilityPass = true.obs;

  setPageTitle(int index) {
    switch (index) {
      case 0:
        pageTitle('login');
        break;
      case 1:
        pageTitle('sign_up');
        break;
    }

    reset();
  }

  setEmail(String value) {
    email(value);
  }

  String? validateEmail() {
    if (email.value.isEmpty) {
      return 'email_required';
    } else {
      var emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail.com")
              .hasMatch(email.value);
      if (emailValid) {
        return null;
      } else {
        return 'email_invalid';
      }
    }
  }

  String? validatePassword() {
    if (password.value.isEmpty) {
      return 'password_required';
    }
    if (password.value.length < 6) {
      return 'password_min_length';
    }
    var passValid = RegExp(r'(?=(.*\d){2})(?=(.*[a-z]{2,}))(?=(.*[A-Z]{2,}))')
        .hasMatch(password.value);
    if (passValid) {
      return null;
    } else {
      return 'password_invalid';
    }
  }

  String? validateConfirmPassword() {
    if (confPassword.value.isEmpty) {
      return 'confirm_password_required';
    }
    if (password.value != confPassword.value) {
      return 'confirm_password_invalid';
    }
    return null;
  }

  String? setPassword(String value) {
    password.value = value;
  }

  String? setConfirmPassword(String value) {
    confPassword.value = value;
  }

  String? visibilityPassword() {
    visibilityPass.value = !visibilityPass.value;
  }

  reset() {
    email('');
    password('');
    confPassword('');
    visibilityPass(true);
  }

  login() async {
    String lPassword = password.value;
    if (lPassword.isNotEmpty && validateEmail() == null) {
      await FirebaseAuthController.authInstance.login(email.value, lPassword);
    }
  }

  register() async {
    if (validateEmail() == null &&
        validatePassword() == null &&
        validateConfirmPassword() == null) {
      await FirebaseAuthController.authInstance
          .register(email.value, password.value);
    }
  }

  loginWithGoogle() async {
    try {
      await FirebaseAuthController.authInstance.loginWithGoogle();
    } catch (e) {
      Get.snackbar(
          'Google Sign In Error', 'Error while signing in with Google : $e',
          duration: const Duration(seconds: 3));
    }
  }
}
