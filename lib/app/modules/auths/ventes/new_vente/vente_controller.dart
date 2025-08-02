import 'package:ciilaabokk/app/data/models/ventes.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenteController extends GetxController {
  final AuthServices auth_services = Get.find<AuthServices>();
  Rx<VenteResponse?> venteResponse = Rx<VenteResponse?>(null);
  RxBool isLoading = false.obs;
  final designation = TextEditingController();
  final prix = TextEditingController();
  final user_id =
      1; // Assuming user_id is an integer and you have a way to set it
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

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data or state here
    fetchVentes();
  }

  Future<void> fetchVentes() async {
    try {
      isLoading(true);
      final response = await auth_services.getAllVentes();
      venteResponse.value = response;
    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Impossible de récupérer les ventes",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  // void createVente() {
  //   // Implement the logic to create a vente
  //   // You can access the controllers like this:
  //   String designationValue = designation.text.trim();
  //   double prixValue = double.parse(prix.text.trim());
  //   int nombreValue = int.parse(nombre.text.trim());
  //   int typesValue = int.parse(
  //     types.text.trim(),
  //   ); // Assuming types is an integer
  //   ;
  //   int userIdValue = user_id;

  //   // Validate inputs
  //   if (designationValue.isEmpty) {
  //     isDesignationValid.value = false;
  //   } else {
  //     isDesignationValid.value = true;
  //   }
  //   if (prixValue == null || prixValue <= 0) {
  //     isPrixValid.value = false;
  //   } else {
  //     isPrixValid.value = true;
  //   }
  //   if (userIdValue <= 0) {
  //     isUserIdValid.value = false;
  //   } else {
  //     isUserIdValid.value = true;
  //   }
  //   if (nombreValue == null || nombreValue <= 0) {
  //     isNombreValid.value = false;
  //   } else {
  //     isNombreValid.value = true;
  //   }
  //   if (typesValue == null || typesValue <= 0) {
  //     isTypesValid.value = false;
  //   } else {
  //     isTypesValid.value = true;
  //   }
  //   // Check if all fields are valid
  //   if (!isDesignationValid.value ||
  //       !isPrixValid.value ||
  //       !isUserIdValid.value ||
  //       !isNombreValid.value ||
  //       !isTypesValid.value) {
  //     Get.snackbar(
  //       "Erreur",
  //       "Veuillez remplir tous les champs correctement",
  //       colorText: Colors.white,
  //       backgroundColor: Colors.redAccent,
  //     );
  //     return;
  //   }
  //   // If all fields are valid, proceed with creating the vente
  //   Get.snackbar(
  //     "Success",
  //     "Vente created successfully",
  //     colorText: Colors.white,
  //     backgroundColor: Colors.green,
  //   );
  //   // Here you can add the logic to save the vente to your database or API
  //   // For example, you might call a service method to save the vente
  //   auth_services.createVente(
  //     designationValue,
  //     prixValue,
  //     nombreValue,
  //     userIdValue,
  //     typesValue,
  //   );
  //   // For now, just print the values to the console
  //   // This is just a placeholder for your actual logic
  //   print(
  //     "Vente created with: $designationValue, $prixValue, $userIdValue, $nombreValue, $typesValue",
  //   );
  //   // You can also reset the controllers if needed
  //   designation.clear();
  //   prix.clear();
  //   nombre.clear();
  //   types.clear();
  //   userIdValue = 1; // Reset to default or initial value
  // }
}
