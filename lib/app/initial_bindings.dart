import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/storage_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:get/get.dart';

class AppInitialBindings extends Bindings {
  @override
  void dependencies() {
    // safe to find dependencies
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => VenteController());
    Get.lazyPut(() => VentesController());
  }
}
