import 'package:ciilaabokk/app/data/models/depensesInfo.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/models/ventes.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/depenses_provider.dart';
import 'package:ciilaabokk/app/data/repositories/depenses_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/data/services/vente_services.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DepensesController extends GetxController {
  var isLoading = false.obs;
  var listeDepenses = <DepensesInfo>[].obs;
  //RxList<VenteInfo> listeVentes = <VenteInfo>[].obs;
  // Rx<VenteResponse?> venteResponse = Rx<VenteResponse?>(null);
  final _depensesRepositories = Get.find<DepensesRepositories>();
  final depensesProvider = Get.find<DepensesProvider>();
  final authControler = Get.find<AuthController>();
  var user = UserInfo();
  RxBool _isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    //fetchVentes();
    fetchDepenses();
  }

  void fetchDepenses() async {
    isLoading(true);

    try {
      // var depenses = await RemoteServices.fetchDepenses();

      var depenses = await _depensesRepositories.listeDepenses();
      logger.i("Depenses from DepensesController: ${depenses}");

      // listeVentes = await _authServices.getAllVentes();
      listeDepenses.assignAll([depenses]);

      logger.i("Fetched depenses: ${listeDepenses.toString()}");
    } catch (e) {
      print("Error fetching depenses: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteDepense(int id) async {
    try {
      _isLoading.value = true;
      var response = await _depensesRepositories.deleteDepenses(id);
      logger.i("Response Depense: ${response}");
      if (response != null) {
        Get.snackbar(
          "Success",
          "Dépense supprimée avec succès",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        fetchDepenses(); // Refresh the list after deletion
      } else {
        Get.snackbar(
          "Failed",
          "Échec de la suppression de la dépense",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Erreur lors de la suppression de la dépense",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
      logger.e("Error deleting depense: $e");
    } finally {
      _isLoading.value = false;
    }
  }
}
