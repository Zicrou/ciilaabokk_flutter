import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/auths/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:get/get.dart';

class VenteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VenteController());
    Get.lazyPut(() => VentesController());
    Get.put(TypesRepositories()); // Assuming TypesRepositories is needed here
    Get.put(TypesController()); // Assuming TypesController is needed here
    Get.put(RemoteServices());
    // Get.put(ProduitsController());
  }
}
