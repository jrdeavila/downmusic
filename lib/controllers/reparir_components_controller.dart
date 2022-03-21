import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RepairComponentController extends GetxController {
  RxBool googleButtonIsVisible = RxBool(false);

  @override
  void onReady() {
    checkGoogleButtonIsReady();
  }

  checkGoogleButtonIsReady() {
    googleButtonIsVisible = RxBool(false);
  }
}
