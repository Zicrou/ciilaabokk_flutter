import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:get/get.dart';

class VentesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VentesController());
  }
}
