import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/models/depensesInfo.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/depenses_provider.dart';
import 'package:ciilaabokk/app/data/repositories/depenses_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/new_depense/depense_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

final logger = Logger();

class DepenseController extends GetxController {
  final AuthServices authServices = Get.find<AuthServices>();

  final GlobalKey<FormState> depensesKeyForm = GlobalKey<FormState>();
  final GlobalKey<FormState> depensesUpdateKeyForm = GlobalKey<FormState>();

  RxString userName = ''.obs;
  RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;
  var libelle = TextEditingController();
  var montant = TextEditingController();
  final user_id = Get.find<AuthProvider>().user?.user?.id;
  final DepensesRepositories depensesRepositories =
      Get.find<DepensesRepositories>();

  // var isLibelleValid = true.obs;
  // var isMontantValid = true.obs;
  // var isUserIdValid = true.obs;

  //var ventes = [].obs; // Observable list to hold ventes

  //final _isLoading = false.obs;

  // VenteController() {
  //   final authProvider = Get.find<AuthProvider>();
  //   user_id = authProvider.user?.user?.id;
  // }

  @override
  void onInit() {
    super.onInit();
    //getTypes();
    // Initialize any necessary data or state here
  }

  //void getTypes() async {}

  void createDepense() async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    //_isLoading = true.obs;
    if (depensesKeyForm.currentState!.validate()) {
      depensesKeyForm.currentState!.save();
      if (user_id == null) {
        Get.snackbar(
          "Error",
          "User ID is not available",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
        );
        return;
      }
      var response;
      var depense = Depenses();
      depense.libelle = libelle.text.trim();
      depense.montant = int.tryParse(montant.text.trim());
      depense.userId = user_id;
      logger.i("Libelle from DepenseController: ${depense.toString()}");
      response = await depensesRepositories.createDepense(depense.toJson());

      // logger.i("Depense: ${depense.toJson()}");
      // var libelleValue = libelle.text.trim();
      // var montantValue = int.tryParse(montant.text.trim());
      // var res = RemoteServices();
      // var response = await res.createDepense(libelleValue, montantValue!);
      //logger.i("Response Depense: ${response.toJson()}");
      logger.i("Res: ${response}");
      var depenses = Depenses.fromJson(response);
      logger.i("Depense from createDepense: ${depenses.toString()}");
      if (depenses != null) {
        //Depenses
        Get.snackbar(
          "Success",
          "Dépense ajouter avec succés",

          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Future.delayed(Duration(seconds: 1), () {
          Get.offAll(DepensesScreen());
        });

        // You can also reset the controllers if needed
        // libelle.clear();
        // montant.clear();
      } else {
        Get.snackbar(
          "Failed",
          "Ajout dépense erreur",

          colorText: Colors.red,
          backgroundColor: Colors.redAccent,
        );
      }
    }
  }

  void updateDepense(Depenses depense) async {
    if (depensesUpdateKeyForm.currentState!.validate()) {
      depensesUpdateKeyForm.currentState!.save();
      if (user_id == null) {
        Get.snackbar(
          "Error",
          "User ID is not available",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
        );
        return;
      }
      depense.id = depense.id; // Ensure the ID is set for update
      depense.libelle = libelle.text.trim();
      depense.montant = int.tryParse(montant.text.trim());
      depense.userId = user_id;
      logger.i("depense from DepenseController: ${depense.toJson()}");

      var response = await depensesRepositories.updateDepense(
        depense.id!,
        depense.toJson(),
      );

      var updatedDepense = response;
      logger.i("Response Depense updatedDepense: ${response}");
      if (updatedDepense == null) {
        Get.snackbar(
          "Failed",
          "Échec de la modification: User ou dépense non trouvée",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
        );
      } else {
        Get.snackbar(
          "Success",
          "Dépense mise à jour avec succès",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Future.delayed(Duration(seconds: 1), () {
          Get.offAll(DepensesScreen());
        });
      }
    }
  }
}
