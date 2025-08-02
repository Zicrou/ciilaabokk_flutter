import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:get/get.dart';

class VenteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VenteController());
  }
}
