import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

final logger = Logger();

class VenteController extends GetxController {
  final VentesRepository ventesRepository = Get.find<VentesRepository>();
  final AuthServices authServices = Get.find<AuthServices>();
  final TypesRepositories typesRepositories = Get.find<TypesRepositories>();
  final RemoteServices remoteService = Get.find<RemoteServices>();
  final GlobalKey<FormState> createVenteKeyForm = GlobalKey<FormState>();
  final GlobalKey<FormState> updateVenteKeyForm = GlobalKey<FormState>();

  RxString userName = ''.obs;
  RxBool isLoading = false.obs;
  final designation = TextEditingController();
  final prix = TextEditingController();
  late final user_id;
  // Assuming user_id is an integer and you have a way to set it
  // Assuming user_id is an integer and you have a way to set it
  final nombre = TextEditingController();
  var typesList = <Types>[].obs;
  var selectedType = Rx<Types?>(null);
  // Add your login logic here

  var isDesignationValid = true.obs;
  var isPrixValid = true.obs;
  var isUserIdValid = true.obs;
  var isNombreValid = true.obs;
  var isTypesValid = true.obs;
  var ventes = [].obs; // Observable list to hold ventes

  //final _isLoading = false.obs;

  VenteController() {
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

  void createVente() async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (createVenteKeyForm.currentState!.validate()) {
      createVenteKeyForm.currentState!.save();

      // String designationValue = designation.text.trim();
      // int prixValue = int.parse(prix.text.trim());
      // int nombreValue = int.parse(nombre.text.trim());
      // int typesValue = int.parse(
      //   selectedType.value!.id.toString(),
      // ); // Assuming types is an integer
      // int userIdValue = user_id;
      // if (userIdValue == null) {
      //   throw Exception("User is not logged in.");
      // } else {
      //   logger.i("UserId: ${userIdValue}");
      // }
      // // Validate inputs
      // if (designationValue.isEmpty) {
      //   isDesignationValid.value = false;
      // } else {
      //   isDesignationValid.value = true;
      // }
      // if (prixValue == null || prixValue <= 0 || prixValue.isNaN) {
      //   isPrixValid.value = false;
      //   throw Exception("Prix invalide");
      // } else {
      //   isPrixValid.value = true;
      // }
      // if (userIdValue <= 0 || userIdValue == null) {
      //   isUserIdValid.value = false;
      // } else {
      //   isUserIdValid.value = true;
      // }
      // if (nombreValue == null || nombreValue <= 0) {
      //   isNombreValid.value = false;
      // } else {
      //   isNombreValid.value = true;
      // }
      // if (typesValue == null || typesValue <= 0) {
      //   isTypesValid.value = false;
      // } else {
      //   isTypesValid.value = true;
      // }
      // // Check if all fields are valid
      // if (!isDesignationValid.value ||
      //     !isPrixValid.value ||
      //     !isUserIdValid.value ||
      //     !isNombreValid.value ||
      //     !isTypesValid.value) {
      //   Get.snackbar(
      //     "Erreur",
      //     "Veuillez remplir tous les champs correctement",
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //   );
      //   return;
      // }

      var vente = Vente();
      vente.designation = designation.text.trim();
      vente.prix = int.parse(prix.text.trim());
      vente.nombre = int.parse(nombre.text.trim());
      vente.types = int.parse(selectedType.value!.id.toString());
      vente.userId = user_id;
      logger.i(
        "Creating Vente with: ${vente.designation}, ${vente.prix}, ${vente.userId}, ${vente.nombre}, Type: ${vente.types}",
      );

      logger.i("Creating Vente with Json: ${vente.toJson()}");
      var res = ventesRepository.createVente(vente.toJson());
      logger.i("Res: ${res}");
      if (res != null) {
        Get.snackbar(
          "Success",
          "Vente created successfully",

          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        // Get.offAll(VentesScreen());

        await VentesController().fetchVentes();

        Future.delayed(Duration(seconds: 2), () {
          Get.offAll(VentesScreen());
        });
      } else {
        Get.snackbar(
          "Failed",
          "Vente creation failed",

          colorText: Colors.red,
          backgroundColor: Colors.redAccent,
        );
      }
    }
  }

  void updateVente(venteFromForm) async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (updateVenteKeyForm.currentState!.validate()) {
      updateVenteKeyForm.currentState!.save();
      var vente = Vente();
      vente.id = venteFromForm.id; // Assuming vente has an id field
      vente.designation = designation.text.trim();
      vente.prix = int.parse(prix.text.trim());
      vente.nombre = int.parse(nombre.text.trim());
      vente.userId = user_id ?? venteFromForm.userId;
      typesList.value = await typesRepositories.listTypes();
      logger.i("VenteType: ${venteFromForm.types.id}");

      // vente.types = int.parse(selectedType.value!.id.toString());
      if (selectedType.value != null) {
        vente.types = int.parse(selectedType.value!.id.toString());
      } else {
        vente.types =
            venteFromForm.types.id; // Keep the existing type if none selected
      }
      // logger.i(
      //   "Updating Vente Sans selectionner la liste with: Id ${vente.id}, ${vente.designation}, ${vente.prix}, ${vente.userId}, ${vente.nombre}, Type: ${vente.types}",
      // );

      //String designationValue = designation.text.trim();
      // int prixValue = int.parse(prix.text.trim());
      // int nombreValue = int.parse(nombre.text.trim());
      // int typesValue = int.parse(
      //   types.text.trim(),
      // ); // Assuming types is an integer
      // ;
      // int userIdValue = user_id;
      // if (userIdValue == null) {
      //   throw Exception("User is not logged in.");
      // } else {
      //   logger.i("UserId: ${userIdValue}");
      // }
      // // Validate inputs
      // if (designationValue.isEmpty) {
      //   isDesignationValid.value = false;
      // } else {
      //   isDesignationValid.value = true;
      // }
      // if (prixValue == null || prixValue <= 0) {
      //   isPrixValid.value = false;
      // } else {
      //   isPrixValid.value = true;
      // }
      // if (userIdValue <= 0 || userIdValue == null) {
      //   isUserIdValid.value = false;
      // } else {
      //   isUserIdValid.value = true;
      // }
      // if (nombreValue == null || nombreValue <= 0) {
      //   isNombreValid.value = false;
      // } else {
      //   isNombreValid.value = true;
      // }
      // if (typesValue == null || typesValue <= 0) {
      //   isTypesValid.value = false;
      // } else {
      //   isTypesValid.value = true;
      // }
      // Check if all fields are valid
      // if (!isDesignationValid.value ||
      //     !isPrixValid.value ||
      //     !isUserIdValid.value ||
      //     !isNombreValid.value ||
      //     !isTypesValid.value) {
      //   Get.snackbar(
      //     "Erreur",
      //     "Veuillez remplir tous les champs correctement",
      //     colorText: Colors.white,
      //     backgroundColor: Colors.redAccent,
      //   );
      //   return;
      // }
      logger.i(
        "UPdating Vente avec Selection with: Id ${vente.id}, ${vente.designation}, ${vente.prix}, ${vente.userId}, ${vente.nombre}, Vente.Type: ${selectedType.value?.id}",
      );

      var res = ventesRepository.updateVente(venteFromForm.id, vente.toJson());
      // var res = await remoteService.updateVente(vente.id!, vente);
      logger.i("Res: ${res}");

      if (res != null) {
        Get.snackbar(
          "Success",
          "Vente created successfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        await VentesController().fetchVentes();
        Get.offAll(VentesScreen());
        // Future.delayed(Duration(seconds: 1), () {});
      } else {
        Get.snackbar(
          "Failed",
          "Vente creation failed",

          colorText: Colors.red,
          backgroundColor: Colors.redAccent,
        );
      }
    }
  }

  Future<void> fetchTypes([Vente? vente]) async {
    isLoading(true);
    try {
      // var ventes = await RemoteServices.fetchVentes();
      var typesList = await typesRepositories.listTypes();
      logger.i("Type from TypesController: ${typesList}");
      if (vente != null && vente.types != null) {
        final typeMatch = typesList.firstWhereOrNull(
          (t) => t.name == vente.types?.name,
        );
        selectedType.value = typeMatch;
      }
    } catch (e) {
      print("Error fetching types: $e");
    } finally {
      isLoading(false);
    }
  }

  // Pré-remplir les champs si vente existe
  // void fillFields(Vente? vente) {
  //   if (vente != null) {
  //     designation.text = vente.designation ?? '';
  //     prix.text = vente.prix.toString();
  //     nombre.text = vente.nombre.toString();
  //   }
  // }
}
