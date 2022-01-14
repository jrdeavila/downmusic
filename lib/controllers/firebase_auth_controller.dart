import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_constants.dart' as constants;

class FirebaseAuthController extends GetxController {
  static FirebaseAuthController authInstance = Get.find();

  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(constants.firebaseApp.currentUser);
    firebaseUser.bindStream(constants.firebaseApp.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/authentication');
    }
  }

  Future<void> register(String email, String password) async {
    var messageTr = '';
    try {
      await constants.firebaseApp
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        messageTr = 'password_easy';
      } else if (e.code == 'email-already-in-use') {
        messageTr = 'email_already_in_use';
      } else {
        messageTr = 'unknown_error';
      }
      messageTr = messageTr.tr;
      Get.snackbar('Error', messageTr, duration: const Duration(seconds: 3));
    }
  }

  Future<void> login(String email, String password) async {
    var messageTr = '';
    try {
      await constants.firebaseApp
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        messageTr = 'wrong_password';
      } else if (e.code == 'user-not-found') {
        messageTr = 'user_not_found';
      } else if (e.code == 'user-disabled') {
        messageTr = 'user_disabled';
      } else {
        messageTr = 'unknown_error';
      }
      messageTr = messageTr.tr;
      Get.snackbar('Error', messageTr, duration: const Duration(seconds: 3));
    }
  }

  Future<void> loginWithGoogle() async {
    GoogleSignIn().signOut();
    final GoogleSignInAccount? _googleUser = await GoogleSignIn().signIn();

    if (_googleUser != null) {
      final GoogleSignInAuthentication _googleAuth =
          await _googleUser.authentication;
      final crendentials = GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);
      await constants.firebaseApp.signInWithCredential(crendentials);
    }
  }

  Future<void> logout() async {
    var messageTr = '';
    var title = 'error'.tr;
    try {
      messageTr = 'logout_message'.tr;
      constants.firebaseApp.signOut();
      title = 'logout_success'.tr;
      Get.snackbar(title, messageTr, duration: const Duration(seconds: 3));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        messageTr = 'network_request_failed';
      } else {
        messageTr = 'unknown_error';
      }
      messageTr = messageTr.tr;
      Get.snackbar(title, messageTr, duration: const Duration(seconds: 3));
    }
  }
}
