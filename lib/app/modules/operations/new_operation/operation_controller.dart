import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/operations_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

final logger = Logger();

class OperationController extends GetxController {
  final OperationsRepository operationsRepository =
      Get.find<OperationsRepository>();
  final AuthServices authServices = Get.find<AuthServices>();
  final TypesRepositories typesRepositories = Get.find<TypesRepositories>();
  final RemoteServices remoteService = Get.find<RemoteServices>();
  final GlobalKey<FormState> createOperationKeyForm = GlobalKey<FormState>();
  final GlobalKey<FormState> updateOperationKeyForm = GlobalKey<FormState>();
  // final ProduitsController produitsController = Get.find<ProduitsController>();

  // Reactive list of filtered products
  // RxList<Produit> produitList = <Produit>[].obs;

  RxString userName = ''.obs;
  RxBool isLoading = false.obs;
  final designation = TextEditingController();
  final prix = TextEditingController();
  late final user_id;
  var produit;
  var operation;
  RxBool isProduit = false.obs;
  // Assuming user_id is an integer and you have a way to set it
  // Assuming user_id is an integer and you have a way to set it
  final nombre = TextEditingController();
  var typesList = <Types>[].obs;

  var selectedType = Rx<Types?>(null);
  var selectedProduit = Rx<Produit?>(null);

  var operations = [].obs; // Observable list to hold ventes

  OperationsController _operationsController = Get.find<OperationsController>();
  OperationController() {
    final authProvider = Get.find<AuthProvider>();
    user_id = authProvider.user?.user?.id;
  }

  @override
  void onInit() {
    super.onInit();
    // _loadProduits();
    final args = Get.arguments;

    // A modifier
    if (args == null) {
      // print({args['produit']});
    } else if (args['produit'] != null || args['operation'] != null) {
      produit = args['produit'];
      operation = args['operation'];
      if (produit != null) {
        isProduit(true);
      }
    }
  }

  @override
  void onClose() {
    designation.dispose();
    prix.dispose();
    nombre.dispose();
    selectedType.close();
    super.onClose();
  }
  // @override
  // void dispose() {
  //   designation.dispose();
  //   prix.dispose();
  //   nombre.dispose();
  //   types.dispose();
  //   super.dispose();
  // }

  //void getTypes() async {}

  // void _loadProduits() async {
  //   // Wait for produitsController to have its data ready
  //   await Future.delayed(Duration(seconds: 1));

  //   if (produitsController.produitsList.isNotEmpty) {
  //     // Clear old data first
  //     produitList.clear();

  //     // Get first produits group (adjust this to your structure)
  //     var produits = produitsController.produitsList[0].produits;

  //     // Filter products where nombre > 0
  //     if (produits != null) {
  //       for (var produit in produits) {
  //         if (produit.nombre != null && produit.nombre! > 0) {
  //           produitList.add(produit);
  //         }
  //       }
  //     }
  //   }
  // }

  void createOperation() async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (createOperationKeyForm.currentState!.validate()) {
      createOperationKeyForm.currentState!.save();

      try {
        isLoading(true);
        var operation = Operation();
        operation.designation = designation.text.trim();
        operation.prix = Decimal.parse(prix.text.trim().replaceAll(',', '.'));
        operation.nombre = int.parse(nombre.text.trim());
        operation.types = selectedType.value!.id.toString();
        logger.i("Opération type: ${operation.types}");
        if (selectedProduit.value == null) {
          operation.produit = null;
        } else {
          operation.produit = selectedProduit.value!.id.toString();
          Produit produit = await ProduitController().getProduit(
            operation.produit!,
          );
          logger.i("Verifier si le nombre du produit est suffisant: $produit");
          if (produit.nombre != null && produit.nombre! < operation.nombre!) {
            errorMessage("Le nombre du produit est insuffisant");
            isLoading(false);
            return;
          }
        }
        operation.userId = user_id;
        logger.i(
          "Création d'opération avec ProduitID: ${operation.produit} ${operation.designation}, ${operation.prix}, ${operation.userId}, ${operation.nombre}, Type: ${operation.types}",
        );
        logger.i(
          "Le json de la création de l'opération: ${operation.toJson()}",
        );
        var res = await operationsRepository.createOperation(
          operation.toJson(),
        );
        logger.i("Res: $res");
        if (res != null) {
          if (res['success'] == "L'opération a été créée") {
            logger.i("res['success']: ${res['success']}");
            goodMessage("Opération créée avec succés");
             // Appel de la liste des opérations
            await _operationsController.fetchOperations();
          } else {
            errorMessage("Erreur: ${res['success']}");
            return;
          }

         

          Future.delayed(Duration(seconds: 2), () {
            Get.offAll(OperationsScreen());
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

  void updateOperation(operationDepuisForm) async {
    // Implement the logic to create an operation
    // You can access the controllers like this:
    if (updateOperationKeyForm.currentState!.validate()) {
      updateOperationKeyForm.currentState!.save();
      logger.w("Operation from form: ${operationDepuisForm}");
      try {
        isLoading(true);
        var operation = Operation();
        operation.id =
            operationDepuisForm.id; // Assuming operation has an id field
        operation.designation = designation.text.trim();
        operation.prix = Decimal.parse(prix.text.trim().replaceAll(',', '.'));
        operation.nombre = int.parse(nombre.text.trim());
        operation.userId = user_id ?? operationDepuisForm.userId;
        operation.produit = (operationDepuisForm.produit != null)
            ? operationDepuisForm.produit.id
            : null;
        //typesList.value = await typesRepositories.listTypes();
        // operation.types = int.parse(selectedType.value!.id.toString());
        if (selectedType.value != null) {
          operation.types = selectedType.value!.id.toString();
        } else {
          operation.types = operationDepuisForm
              .types
              .id; // Keep the existing type if none selected
        }
        logger.i("Opération from form: $operationDepuisForm");

        logger.i("Updating Opération : $operation");

        var res = await operationsRepository.updateOperation(
          operationDepuisForm.id,
          operation.toJson(),
        );
        // var res = await remoteService.updateVente(operation.id!, vente);
        logger.i("Res from updated operation: ${res}");
        if (res != null) {
          goodMessage("Opération modifiée avec succés");
          await _operationsController.fetchOperations();

          Future.delayed(Duration(seconds: 1), () {
            Get.offAll(OperationsScreen());
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

  // Delete Operation
  Future<void> deleteOperation(String id) async {
    try {
      isLoading(true);
      await operationsRepository.deleteOperation(id);
      logger.i("Opération with Id $id deleted successfully.");
      _operationsController
          .fetchOperations(); // Refresh the list after deletion
      goodMessage("Opération supprimée avec succés");
    } catch (e) {
      errorMessage("Erreur");
      logger.e("Error deleting opération: $e");
    } finally {
      isLoading(false);
    }
  }
}
