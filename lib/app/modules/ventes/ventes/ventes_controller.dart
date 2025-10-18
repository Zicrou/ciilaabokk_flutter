import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/models/ventes.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
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

class VentesController extends GetxController {
  var isLoading = true.obs;
  var ventesList = <VenteInfo>[].obs;
  //RxList<VenteInfo> listeVentes = <VenteInfo>[].obs;
  // Rx<VenteResponse?> venteResponse = Rx<VenteResponse?>(null);
  final _ventesRespository = Get.find<VentesRepository>();
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
      var ventes = await _ventesRespository.listVentes();
      logger.i("Vente from venteController: ${ventes}");

      //listeVentes = await _authServices.getAllVentes();
      ventesList.assignAll([ventes]);

      logger.i("Fetched ventes: ${ventesList.toString()}");
    } catch (e) {
      print("Error fetching ventes: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteVente(int id) async {
    isLoading(true);
    try {
      await _ventesRespository.deleteVente(id);
      logger.i("Vente with ID $id deleted successfully.");
      fetchVentes(); // Refresh the list after deletion
      goodMessage("Vente supprimée avec succés");
    } catch (e) {
      errorMessage("Erreur");
      logger.e("Error deleting vente: $e");
    } finally {
      isLoading(false);
    }
  }
}
