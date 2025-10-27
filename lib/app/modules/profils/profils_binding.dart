import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/profils/profils_controller.dart';
import 'package:get/get.dart';

class ProfilsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilController());
    Get.put(AuthRepositories());
    Get.put(AuthServices());
    // Get.put();
  }
}
