import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_controller.dart';
import 'package:get/get.dart';

class ProduitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DepensesController());
    Get.put(AuthRepositories());
    Get.put(ProduitsController());
  }
}
