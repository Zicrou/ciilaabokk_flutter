import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/models/depensesInfo.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/depenses_provider.dart';
import 'package:ciilaabokk/app/data/repositories/depenses_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/operations_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/new_depense/depense_screen.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:decimal/decimal.dart';
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
  final DepensesController _depensesController = Get.put(DepensesController());

  @override
  void onInit() {
    super.onInit();
  }

  void createDepense() async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (depensesKeyForm.currentState!.validate()) {
      depensesKeyForm.currentState!.save();
      if (user_id == null) {
        errorMessage("User non trouvé");
      }
      _isLoading(true);
      try {
        var response;
        var depense = Depenses();
        depense.libelle = libelle.text.trim();
        depense.montant = Decimal.parse(montant.text.trim());
        depense.userId = user_id;
        logger.i("Libelle from DepenseController: ${depense.toString()}");
        response = await depensesRepositories.createDepense(depense.toJson());

        logger.i("Res: ${response}");
        
        if (response['success']== true) {
          goodMessage("Dépense créée avec succés");
          await _depensesController.fetchDepenses();
          Future.delayed(Duration(seconds: 1), () {
            Get.offAll(DepensesScreen());
          });

          // You can also reset the controllers if needed
          // libelle.clear();
          // montant.clear();
        } else {
          errorMessage("Erreur");
        }
      } catch (e) {
        throw "Erreur: ${e}";
      } finally {
        _isLoading(false);
      }
    }
  }

  void updateDepense(Depenses depense) async {
    if (depensesUpdateKeyForm.currentState!.validate()) {
      depensesUpdateKeyForm.currentState!.save();
      if (user_id == null) {
        errorMessage("User non trouvé");
      }
      try {
        depense.id = depense.id; // Ensure the ID is set for update
        depense.libelle = libelle.text.trim();
        depense.montant = Decimal.parse(montant.text.trim());
        depense.userId = user_id;
        logger.i("depense from DepenseController: ${depense.toJson()}");

        var response = await depensesRepositories.updateDepense(
          depense.id!,
          depense.toJson(),
        );

        if(response['success'] != true){
          errorMessage("Erreur: Modification dépense");
          logger.e("Erreur: Modification dépense");
        }
        logger.i("Response Depense updatedDepense : ${response}");
          goodMessage("Dépense modifiée avec succés");
          Future.delayed(Duration(seconds: 1), () {
            Get.offAll(DepensesScreen());
            });
          
      } catch (e) {
        throw "Erreur : ${e}";
      } finally {
        _isLoading(false);
      }
    }
  }
}
