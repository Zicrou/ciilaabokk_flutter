import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/depenses_provider.dart';
import 'package:ciilaabokk/app/data/providers/storage_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/depenses_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/produits_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/new_depense/depense_controller.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_controller.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/auths/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:get/get.dart';

class AppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageProvider(), permanent: true);
    Get.put(AuthProvider(), permanent: true);
    Get.put(ApiProvider());
    Get.put(DepensesProvider());
    Get.put(AuthRepositories()); // MUST come before AuthServices
    Get.put(DepensesRepositories());
    Get.put(VentesRepository());
    Get.put(TypesRepositories());
    Get.put(ProduitsRepositories());
    Get.lazyPut(() => AuthServices());
    Get.put(RemoteServices());
    // safe to find dependencies
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => VenteController());
    Get.lazyPut(() => VentesController());
    Get.lazyPut(() => ProduitsController());
    Get.put(() => DepenseController());
    Get.lazyPut(() => DepensesController());
    Get.put(() => TypesController());
  }
}
