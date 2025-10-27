import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/profils/profils_screen.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

final logger = Logger();

class ProfilController extends GetxController {
  // final AuthServices authServices = Get.find<AuthServices>();
  final RemoteServices remoteServices = Get.find<RemoteServices>();
  final GlobalKey<FormState> ajouterMembreKeyForm = GlobalKey<FormState>();
  // final GlobalKey<FormState> updateVenteKeyForm = GlobalKey<FormState>();
  var listMembres = <User>[].obs;
  late final user_id;

  // Assuming user_id is an integer and you have a way to set it
  final phone_number = TextEditingController();
  RxBool isLoading = false.obs;
  ProfilController() {
    final authProvider = Get.find<AuthProvider>();
    user_id = authProvider.user?.user;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMembres();
  }

  @override
  void dispose() {
    phone_number.dispose();
  }

  Future<void> fetchMembres() async {
    isLoading(true);
    try {
      // var ventes = await RemoteServices.fetchVentes();
      var membres = await remoteServices.fetchMembres();
      logger.i("Membres : ${membres}");
      //listeVentes = await _authServices.getAllVentes();

      listMembres.value = membres;

      logger.i("Fetched membres: ${listMembres.toString()}");
    } catch (e) {
      print("Errors fetching membres: $e");
    } finally {
      isLoading(false);
    }
  }

  void addUserToTeam() async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (ajouterMembreKeyForm.currentState!.validate()) {
      ajouterMembreKeyForm.currentState!.save();

      isLoading(true);
      var phoneNumber = phone_number.text.trim();
      logger.i("Adding a member with this number phone: ${phoneNumber}");

      try {
        var res = await remoteServices.addUserToTeam(phoneNumber);
        logger.i("Res: ${res}");
        if (res != null) {
          if (res['status'] == 404) {
            errorMessage("Erreur: ${res['message']}");
            return;
          } else {
            goodMessage("Membre ajouté avec succés");
          }
          Future.delayed(Duration(seconds: 1), () {
            Get.offAll(ProfilsScreen());
          });
        } else {
          errorMessage("Erreur");
        }
      } catch (e) {
        throw "Erreur: ${e.toString()}";
      } finally {
        isLoading(false);
      }
    }
  }

  Future<dynamic> deleteMembre(id) async {
    return 'ok';
  }
}
