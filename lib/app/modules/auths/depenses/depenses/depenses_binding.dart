import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/depenses_repositories.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/new_depense/depense_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:get/get.dart';

class DepensesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepositories());
    Get.put(() => DepensesRepositories());
    Get.put(() => DepensesController());
    Get.lazyPut(() => DepenseController());
    Get.lazyPut(() => VentesController());
  }
}
