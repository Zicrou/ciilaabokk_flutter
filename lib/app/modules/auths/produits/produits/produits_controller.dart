import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

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
    getProduitsSupAZero();
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

  //available products
  Future<void> getProduitsSupAZero() async {
    isLoading(true);
    try {
      // Wait for produitsController to have its data ready
      await Future.delayed(Duration(seconds: 1));

      if (produitsList.isNotEmpty) {
        // Clear old data first
        produitsListSupAZero.clear();

        // Get first produits group (adjust this to your structure)
        var produits = produitsList[0].produits;

        // Filter products where nombre > 0
        if (produits != null) {
          for (var produit in produits) {
            if (produit.nombre != null && produit.nombre! > 0) {
              produitsListSupAZero.add(produit);
            }
          }
        }
      } else {
        logger.w("La liste des produits est vide");
      }
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
