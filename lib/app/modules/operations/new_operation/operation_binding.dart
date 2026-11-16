import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/operations/new_operation/operation_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_controller.dart';
import 'package:get/get.dart';

class OperationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OperationController());
    Get.lazyPut(() => OperationsController(), fenix: true);
    Get.put(TypesRepositories()); // Assuming TypesRepositories is needed here
    Get.put(TypesController()); // Assuming TypesController is needed here
    Get.put(RemoteServices());
    // Get.put(ProduitsController());
  }
}
