import 'package:ciilaabokk/app/data/models/produitsInfo.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/produits_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/data/services/vente_services.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProduitsController extends GetxController {
  var isLoading = true.obs;
  var produitsList = <ProduitsInfo>[].obs;
  //RxList<VenteInfo> listeVentes = <VenteInfo>[].obs;
  // Rx<VenteResponse?> venteResponse = Rx<VenteResponse?>(null);
  final _produitsRepositories = Get.find<ProduitsRepositories>();
  final authProvider = Get.find<AuthProvider>();
  final authControler = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    //fetchVentes();
    fetchVentes();
  }

  Future<void> fetchVentes() async {
    isLoading(true);
    try {
      // var ventes = await RemoteServices.fetchVentes();
      var produits = await _produitsRepositories.listProduits();
      logger.i("Vente from venteController: ${produits}");

      produitsList.assignAll([produits]);

      logger.i("Fetched ventes: ${produitsList.toString()}");
    } catch (e) {
      print("Error fetching produits: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteVente(int id) async {
    try {
      isLoading(true);
      await _produitsRepositories.deleteProduits(id);
      logger.i("Vente with ID $id deleted successfully.");
      fetchVentes(); // Refresh the list after deletion
      Get.snackbar(
        "Succès",
        "Vente supprimée avec succès",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Impossible de supprimer la vente",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
      logger.e("Error deleting vente: $e");
    } finally {
      isLoading(false);
    }
  }
}
