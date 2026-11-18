import 'package:ciilaabokk/app/data/models/membre.dart';
import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/profils_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/operations_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/profils/profils_screen.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

final logger = Logger();

class ProfilController extends GetxController {
  final ProfilsRepositories _profilsRepositories =
      Get.find<ProfilsRepositories>();
  final RemoteServices remoteServices = Get.find<RemoteServices>();
  final GlobalKey<FormState> ajouterMembreKeyForm = GlobalKey<FormState>();
  // final GlobalKey<FormState> updateVenteKeyForm = GlobalKey<FormState>();
  var listMembres = <Membres>[].obs;
  late final user;

  // Assuming user_id is an integer and you have a way to set it
  final user_email_or_phone = TextEditingController();
  RxBool isLoading = false.obs;
  ProfilController() {
    final authProvider = Get.find<AuthProvider>();
    user = authProvider.user?.user;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMembres();
  }

  @override
  void dispose() {
    user_email_or_phone.dispose();
  }

  Future<void> fetchMembres() async {
    isLoading(true);
    try {
      var membres = await _profilsRepositories.fetchMembres();
      // var membres = await remoteServices.fetchMembres();
      logger.i("Membres : ${membres}");
      //listeVentes = await _authServices.getAllVentes();=]['-,.]
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
      var userEmailOrPhone = user_email_or_phone.text.trim();
      logger.i("Adding a member with this number phone: ${userEmailOrPhone}");

      try {
        final Membres membre = Membres();
        membre.user_email_or_phone = user_email_or_phone.text.trim();
        // membre.name = user.name;
        logger.i("Membre: ${membre.toJson()}");
        var res = await _profilsRepositories.addUserToTeam(membre.toJson());
        // var res = await remoteServices.addUserToTeam(user_email_or_phone);
        logger.i("Res: ${res}");
        if (res != null) {
          if (res['success'] != true) {
            errorMessage("Erreur: ${res['message']}");
            return;
          } else {
            goodMessage("Membre ajouté avec succés");
          }
          await fetchMembres();
          Future.delayed(Duration(milliseconds: 500), () {
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

  Future<void> deleteMembre(String id) async {
    try {
      var idMembre = id;
      final reponse = await _profilsRepositories.deleteMembre(idMembre);
      logger.i("Response from Profil controller ${reponse}");

      goodMessage("Membre supprimé avec succès");
      await fetchMembres();
      // Future.delayed(Duration(milliseconds: 500), () {
      // Get.offAll(() => ProfilsScreen());
      // });
    } catch (e) {
      logger.e("Error removing User from a team: $e");
      errorMessage("Erreur lors de la suppression du membre");
    }
  }
}
