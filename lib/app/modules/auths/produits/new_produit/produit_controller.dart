import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/produits_repositories.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

final logger = Logger();

class ProduitController extends GetxController {
  final AuthServices authServices = Get.find<AuthServices>();
  final ProduitsRepositories produitsRepositories =
      Get.find<ProduitsRepositories>();

  final RemoteServices remoteService = Get.find<RemoteServices>();
  final GlobalKey<FormState> createProduitKeyForm = GlobalKey<FormState>();
  final GlobalKey<FormState> updateProduitKeyForm = GlobalKey<FormState>();

  // RxString userName = ''.obs;
  RxBool isLoading = false.obs;
  final designation = TextEditingController();
  final montant = TextEditingController();
  var user_id;
  // Assuming user_id is an integer and you have a way to set it
  // Assuming user_id is an integer and you have a way to set it
  final nombre = TextEditingController();
  // Add your login logic here

  ProduitController() {
    final authProvider = Get.find<AuthProvider>();
    user_id = authProvider.user?.user?.id;
  }

  @override
  void onInit() {
    super.onInit();
    //getTypes();
    // Initialize any necessary data or state here
  }

  @override
  void onClose() {
    designation.dispose();
    montant.dispose();
    nombre.dispose();
    super.onClose();
  }

  // @override
  // void dispose() {
  //   designation.dispose();
  //   montant.dispose();
  //   nombre.dispose();
  //   super.dispose();
  // }

  void createProduit() async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (createProduitKeyForm.currentState!.validate()) {
      createProduitKeyForm.currentState!.save();
      logger.w(
        "Creating Produits from form: Designation: ${designation.text.trim()}, Montant: ${montant.text.trim()}, Nombre: ${nombre.text.trim()}, User_id: ${user_id}",
      );
      logger.i("User_id : ${user_id}");
      isLoading(true);
      try {
        var produit = Produit();
        produit.designation = designation.text.trim();
        produit.montant = int.parse(montant.text.trim());
        produit.nombre = int.parse(nombre.text.trim());
        produit.userId = user_id;
        logger.i(
          "Creating produit with: ${produit.designation}, ${produit.montant}, ${produit.userId}, ${produit.nombre}}",
        );

        logger.i("Creating Vente with Json: ${produit.toJson()}");

        var res = await produitsRepositories.createProduits(produit.toJson());

        // var designationV = designation.text.trim();
        // var montantV = int.parse(montant.text.trim());
        // var nombreV = int.parse(nombre.text.trim());
        // var res = await remoteService.createProduit(
        //   designationV,
        //   montantV,
        //   nombreV,
        // );

        logger.i("Res: ${res}");
        if (res != null) {
          goodMessage("Produit créer avec succés");

          await ProduitsController().fetchProduits();

          Future.delayed(Duration(seconds: 2), () {
            Get.offAll(ProduitsScreen());
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

  Future<Produit> getProduit(int id) async {
    try {
      var res = await produitsRepositories.getProduit(id);

      logger.w("Res: ${res}");

      if (res == null) {
        errorMessage("Erreur");
      }
      return res;
    } catch (e) {
      throw "Erreur: ${e}";
    } finally {
      isLoading(false);
    }
  }

  void updateProduit(produitFromForm) async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (updateProduitKeyForm.currentState!.validate()) {
      updateProduitKeyForm.currentState!.save();

      try {
        var produit = Produit();
        produit.id = produitFromForm.id; // Assuming produit has an id field
        produit.designation = designation.text.trim();
        produit.montant = int.parse(montant.text.trim());
        produit.nombre = int.parse(nombre.text.trim());
        produit.userId = user_id ?? produitFromForm.userId;

        logger.i(
          "UPdating produit avec Selection with: Id ${produit.id}, ${produit.designation}, ${produit.montant}, ${produit.userId}, ${produit.nombre}}",
        );

        logger.i("Produit From form: ${produitFromForm}");
        var res = produitsRepositories.updateProduit(
          produitFromForm.id,
          produit.toJson(),
        );
        // var designationV = designation.text.trim();
        // var montantV = int.parse(montant.text.trim());
        // var nombreV = int.parse(nombre.text.trim());
        // var res = await remoteService.updateProduits(
        //   designationV,
        //   montantV,
        //   nombreV,
        //   produitFromForm.id,
        // );
        logger.i("Res: ${res}");

        if (res != null) {
          goodMessage("Produit modifié avec succés");
          await ProduitsController().fetchProduits();
          Get.offAll(ProduitsScreen());
          // Future.delayed(Duration(seconds: 1), () {});
        } else {
          errorMessage("Erreur");
        }
      } catch (e) {
        throw "Erreur: ${e}";
      } finally {
        isLoading(false);
      }
    }
  }
}
