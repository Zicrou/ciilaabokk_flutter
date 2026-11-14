import 'package:ciilaabokk/app/data/models/operation_info.dart';
import 'package:ciilaabokk/app/data/models/operations_response.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/operations_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/data/services/vente_services.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:ciilaabokk/app/modules/auths/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class OperationsController extends GetxController {
  var isLoading = true.obs;
  var operationsList = <OperationInfo>[].obs;
  //RxList<VenteInfo> listeVentes = <VenteInfo>[].obs;
  // Rx<VenteResponse?> venteResponse = Rx<VenteResponse?>(null);
  final _operationsRepository = Get.find<OperationsRepository>();
  final authProvider = Get.find<AuthProvider>();
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    //fetchVentes();
    fetchOperations();
  }

  Future<void> fetchOperations() async {
    isLoading(true);
    try {
      // var ventes = await RemoteServices.fetchVentes();
      var operations = await _operationsRepository.listOperations();
      logger.i("Operation from operationsController: ${operations}");

      //listeVentes = await _authServices.getAllVentes();
      operationsList.assignAll([operations]);

      logger.i("Fetched opération: ${operationsList.toString()}");
    } catch (e) {
      print("Error fetching opérations: $e");
    } finally {
      isLoading(false);
    }
  }
}
