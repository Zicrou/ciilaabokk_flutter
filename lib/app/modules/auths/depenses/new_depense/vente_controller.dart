import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
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
  RxString userName = ''.obs;
  RxBool isLoading = false.obs;
  final designation = TextEditingController();
  final prix = TextEditingController();
  late final user_id;
  // Assuming user_id is an integer and you have a way to set it
  // Assuming user_id is an integer and you have a way to set it
  final nombre = TextEditingController();
  final types = TextEditingController();
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

  get selectedType => null;
  @override
  void onInit() {
    super.onInit();
    //getTypes();
    // Initialize any necessary data or state here
  }

  //void getTypes() async {}

  void createVente() {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    var vente = Vente();
    vente.designation = designation.text.trim();
    vente.prix = int.parse(prix.text.trim());
    vente.nombre = int.parse(nombre.text.trim());
    vente.types = int.parse(types.text.trim());
    vente.userId = user_id;
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

    var res = ventesRepository.createVente(vente.toJson());
    logger.i("Res: ${res}");
    if (res != null) {
      VentesController().fetchVentes();
      Get.offAll(VentesScreen());
      Get.snackbar(
        "Success",
        "Vente created successfully",

        colorText: Colors.white,
        backgroundColor: Colors.green,
      );

      // You can also reset the controllers if needed
      designation.clear();
      prix.clear();
      nombre.clear();
      types.clear();
    } else {
      Get.snackbar(
        "Failed",
        "Vente creation failed",

        colorText: Colors.red,
        backgroundColor: Colors.redAccent,
      );
    }

    // print(
    //   "Vente created with: $designationValue, $prixValue, $userIdValue, $nombreValue, $typesValue",
    // );
    // If all fields are valid, proceed with creating the vente

    // Here you can add the logic to save the vente to your database or API
    // For example, you might call a service method to save the vente

    // For now, just print the values to the console
    // This is just a placeholder for your actual logic

    //userIdValue = user_id; // Reset to default or initial value
  }
}
