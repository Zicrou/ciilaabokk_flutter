import 'dart:io';

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
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';
import 'dart:convert';

final logger = Logger();

class ProduitController extends GetxController {
  final AuthServices authServices = Get.find<AuthServices>();
  final ProduitsRepositories produitsRepositories =
      Get.find<ProduitsRepositories>();

  final RemoteServices remoteService = Get.find<RemoteServices>();
  final GlobalKey<FormState> createProduitKeyForm = GlobalKey<FormState>();
  final GlobalKey<FormState> updateProduitKeyForm = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  // Reactive variable for the selected image file
  Rxn<File> selectedImage = Rxn<File>();
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
  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  /// Convert selected image to Base64
  Future<String?> getImageBase64() async {
    if (selectedImage.value == null) return null;
    final bytes = await selectedImage.value!.readAsBytes();
    return base64Encode(bytes);
  }

  // Optional: clear the image
  void clearImage() {
    selectedImage.value = null;
  }

  void createProduitWithImage() async {
    if (createProduitKeyForm.currentState!.validate()) {
      createProduitKeyForm.currentState!.save();

      logger.w(
        "Creating Produits from form: Designation: ${designation.text.trim()}, Montant: ${montant.text.trim()}, Nombre: ${nombre.text.trim()}, User_id: ${user_id}",
      );
      logger.i("User_id : ${user_id}");
      isLoading(true);
      final image = await selectedImage.value;
      try {
        // Build JSON payload

        // 📨 Send request through your repository
        // Send JSON via your API provider
        //final response = await produitsRepositories.createProduitWithBase64(payload)
        await remoteService.createProduitWithImage(
          designation.text.trim(),
          int.parse(montant.text.trim()),
          int.parse(nombre.text.trim()),
          image!,
        );
        // if (response != null) {
        //   goodMessage("Produit créé avec succès ✅");
        //   clearImage();

        //   await ProduitsController().fetchProduits();

        //   Future.delayed(const Duration(seconds: 2), () {
        //     Get.offAll(ProduitsScreen());
        //   });
        // } else {
        //   errorMessage("Erreur, échec de l’envoi (aucune réponse)");
        // }
      } catch (e) {
        errorMessage("Erreur: ${e.toString()}");
        print("error creating produit: $e.toString()");
      } finally {
        isLoading(false);
      }
    }
  }

  // void createProduit() async {
  //   if (createProduitKeyForm.currentState!.validate()) {
  //     createProduitKeyForm.currentState!.save();

  //     logger.w(
  //       "Creating Produits from form: Designation: ${designation.text.trim()}, Montant: ${montant.text.trim()}, Nombre: ${nombre.text.trim()}, User_id: ${user_id}",
  //     );
  //     logger.i("User_id : ${user_id}");
  //     isLoading(true);
  //     final imageBase64 = await getImageBase64();
  //     try {
  //       // Build JSON payload
  //       final payload = {
  //         'designation': designation.text.trim(),
  //         'montant': int.parse(montant.text.trim()),
  //         'nombre': int.parse(nombre.text.trim()),
  //         'user_id': user_id,
  //         'image': imageBase64,
  //       };
  //       logger.i("Payload: ${payload}");
  //       // 📨 Send request through your repository
  //       // Send JSON via your API provider
  //       //final response = await produitsRepositories.createProduitWithBase64(payload)
  //       await remoteService.createProduitWithBase64(payload);
  //       // if (response != null) {
  //       //   goodMessage("Produit créé avec succès ✅");
  //       //   clearImage();

  //       //   await ProduitsController().fetchProduits();

  //       //   Future.delayed(const Duration(seconds: 2), () {
  //       //     Get.offAll(ProduitsScreen());
  //       //   });
  //       // } else {
  //       //   errorMessage("Erreur, échec de l’envoi (aucune réponse)");
  //       // }
  //     } catch (e) {
  //       errorMessage("Erreur: ${e.toString()}");
  //       print("error creating produit: $e.toString()");
  //     } finally {
  //       isLoading(false);
  //     }
  //   }
  // }

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
