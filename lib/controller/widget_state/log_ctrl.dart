import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LogController extends GetxController {
  var logState = true.obs;
  int cardIndex = 1;
  var isLatelogin = false.obs;
  var isEarlyLogout = false.obs;

  void updateLogState(bool val) {
    logState.value = val;
    if (logState.value == false) {
      cardIndex = 2;
    } else {
      cardIndex = 1;
    }
    print(logState.value);
  }
}
