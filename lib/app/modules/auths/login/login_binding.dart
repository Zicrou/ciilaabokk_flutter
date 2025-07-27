import 'package:ciilaabokk/app/modules/auths/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
