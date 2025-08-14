import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/auths/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:get/get.dart';

class TypesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TypesRepositories());
    Get.put(TypesController());
  }
}
