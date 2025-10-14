import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
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
  var produit;
  var vente;
  RxBool isProduct = false.obs;
  // Assuming user_id is an integer and you have a way to set it
  // Assuming user_id is an integer and you have a way to set it
  final nombre = TextEditingController();
  var typesList = <Types>[].obs;

  // var produitsList = <Produit>[].obs;
  var selectedType = Rx<Types?>(null);
  var selectedProduit = Rx<Produit?>(null);
  // Add your login logic here

  // var isDesignationValid = true.obs;
  // var isPrixValid = true.obs;
  // var isUserIdValid = true.obs;
  // var isNombreValid = true.obs;
  // var isTypesValid = true.obs;
  var ventes = [].obs; // Observable list to hold ventes

  //final _isLoading = false.obs;

  VenteController() {
    final authProvider = Get.find<AuthProvider>();
    user_id = authProvider.user?.user?.id;
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args == null) {
      // print({args['produit']});
    } else if (args['produit'] != null || args['vente'] != null) {
      produit = args['produit'];
      vente = args['vente'];
      if (produit != null) {
        isProduct(true);
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

  void createVente() async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (createVenteKeyForm.currentState!.validate()) {
      createVenteKeyForm.currentState!.save();

      isLoading(true);
      var vente = Vente();
      vente.designation = designation.text.trim();
      vente.prix = int.parse(prix.text.trim());
      vente.nombre = int.parse(nombre.text.trim());
      vente.types = int.parse(selectedType.value!.id.toString());
      if (selectedProduit.value == null) {
        vente.produit = null;
      } else {
        vente.produit = int.parse(selectedProduit.value!.id.toString());
      }
      vente.userId = user_id;
      logger.i(
        "Creating Vente with: ProduitID: ${vente.produit} ${vente.designation}, ${vente.prix}, ${vente.userId}, ${vente.nombre}, Type: ${vente.types}",
      );
      logger.i("Creating Vente with Json: ${vente.toJson()}");
      var res = await ventesRepository.createVente(vente.toJson());
      logger.i("Res: ${res}");
      try {
        if (res != null) {
          if (res['status'] == null) {
            errorMessage("Erreur: ${res['message']}");
            return;
          } else {
            goodMessage("Vente créée avec succés");
          }
          // Get.offAll(VentesScreen());

          VentesController().fetchVentes();

          Future.delayed(Duration(seconds: 2), () {
            Get.offAll(VentesScreen());
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

  void updateVente(venteFromForm) async {
    // Implement the logic to create a vente
    // You can access the controllers like this:
    if (updateVenteKeyForm.currentState!.validate()) {
      updateVenteKeyForm.currentState!.save();
      logger.w("Vente from form: ${venteFromForm}");
      isLoading(true);
      try {
        var vente = Vente();
        vente.id = venteFromForm.id; // Assuming vente has an id field
        vente.designation = designation.text.trim();
        vente.prix = int.parse(prix.text.trim());
        vente.nombre = int.parse(nombre.text.trim());
        vente.userId = user_id ?? venteFromForm.userId;
        vente.produit = (venteFromForm.produit != null)
            ? venteFromForm.produit.id
            : null;
        //typesList.value = await typesRepositories.listTypes();
        // vente.types = int.parse(selectedType.value!.id.toString());
        if (selectedType.value != null) {
          vente.types = int.parse(selectedType.value!.id.toString());
        } else {
          vente.types =
              venteFromForm.types.id; // Keep the existing type if none selected
        }
        logger.i("Vente from form: ${vente}");

        logger.i("Updating Vente : ${vente}");

        var res = await ventesRepository.updateVente(
          venteFromForm.id,
          vente.toJson(),
        );
        // var res = await remoteService.updateVente(vente.id!, vente);
        logger.i("Res from updated vente: ${res}");
        if (res != null) {
          goodMessage("Vente modifiée avec succés");
          await VentesController().fetchVentes();

          Future.delayed(Duration(seconds: 1), () {
            Get.offAll(VentesScreen());
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

  // Future<void> fetchTypes([Vente? vente]) async {
  //   isLoading(true);
  //   try {
  //     // var ventes = await RemoteServices.fetchVentes();
  //     var typesList = await typesRepositories.listTypes();
  //     logger.i("Type from TypesController: ${typesList}");
  //     if (vente != null && vente.types != null) {
  //       final typeMatch = typesList.firstWhereOrNull(
  //         (t) => t.name == vente.types?.name,
  //       );
  //       selectedType.value = typeMatch;
  //     }
  //   } catch (e) {
  //     print("Error fetching types: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Pré-remplir les champs si vente existe
  // void fillFields(Vente? vente) {
  //   if (vente != null) {
  //     designation.text = vente.designation ?? '';
  //     prix.text = vente.prix.toString();
  //     nombre.text = vente.nombre.toString();
  //   }
  // }
}
