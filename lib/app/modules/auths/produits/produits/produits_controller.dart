import 'dart:ffi';

import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/produitsInfo.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/produits_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/data/services/vente_services.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProduitsController extends GetxController {
  var isLoading = true.obs;
  var produitsList = <ProduitsInfo>[].obs;
  var produitsListSupAZero = <Produit>[].obs;
  //RxList<VenteInfo> listeVentes = <VenteInfo>[].obs;
  // Rx<VenteResponse?> venteResponse = Rx<VenteResponse?>(null);
  final _produitsRepositories = Get.find<ProduitsRepositories>();
  final authProvider = Get.find<AuthProvider>();
  final authControler = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    //fetchVentes();
    fetchProduits();
    // getProduitsSupAZero();
  }

  Future<void> fetchProduits() async {
    isLoading(true);
    try {
      // var ventes = await RemoteServices.fetchVentes();
      var produits = await _produitsRepositories.listProduits();
      logger.i("Liste produits fom ProduitController: ${produits}");

      produitsList.assignAll([produits]);

      logger.i("Fetched produits: ${produitsList.toString()}");
    } catch (e) {
      print("Error fetching produits: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getProduitsSupAZero() async {
    isLoading(true);
    try {
      // var produits = await _produitsRepositories.listProduitsSupAZero();
      // logger.i("Liste produits from ProduitController supeAzero: ${produits}");

      // produitsListSupAZero.assignAll([produits]);

      // logger.i("Fetched produits: ${produitsListSupAZero.toString()}");
    } catch (e) {
      throw "Error fetching produits > 0, ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteProduits(int id) async {
    isLoading(true);
    try {
      var response = await _produitsRepositories.deleteProduits(id);
      if (response['errMessage'] != null) {
        errorMessage(response['errMessage']);
      } else {
        logger.i("Vente with ID $id deleted successfully.");
        fetchProduits(); // Refresh the list after deletion
        goodMessage("Produit supprimé avec succés");
      }
    } catch (e) {
      logger.e("Error deleting vente: $e");
    } finally {
      isLoading(false);
    }
  }
}
