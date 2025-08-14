import 'package:ciilaabokk/app/data/repositories/depenses_repositories.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/new_depense/depense_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:get/get.dart';

class DepenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => DepensesRepositories());
    Get.put(() => DepenseController());
    Get.put(() => DepensesController());
  }
}
