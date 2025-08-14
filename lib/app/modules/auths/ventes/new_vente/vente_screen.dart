import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/modules/auths/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// ignore: must_be_immutable
class VenteScreen extends StatelessWidget {
  final VenteController venteController = Get.put(VenteController());
  final TypesController typesController = Get.put(TypesController());
  final Vente vente = Get.arguments ?? Vente();
  var stl = ''.obs;

  var title = "Nouvelle Vente";
  @override
  Widget build(BuildContext context) {
    logger.i("Liste Types : ${typesController.fetchTypes().toString()}");
    if (vente.id != null && vente is Vente) {
      title = "Modifier Vente";
      venteController.designation.text = vente.designation!;
      venteController.prix.text = vente.prix.toString();
      venteController.nombre.text = vente.nombre.toString();
      // Trouver dans la liste le type correspondant à la vente
      // Rx<Types?> typeMatch = typesController.typesList
      //     .firstWhereOrNull((t) => t.name == vente.types)
      //     .obs;
      // var matchType = typesController.typesList.firstWhereOrNull(
      //   (t) => t.name == vente.types,
      // );
      // if (matchType != null) {
      //   venteController.selectedType.value = matchType;
      //   logger.i("Selected Type: ${venteController.selectedType.value!.id}");
      // } else {
      //   venteController.selectedType.value = null;
      //   logger.w("No matching type found for vente: ${vente.types?.name}");
      // }

      logger.i("Selected Type: ${venteController.selectedType.value}");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'avenir',
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 0, 173, 253),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: vente.id != null
                ? venteController.updateVenteKeyForm
                : venteController.createVenteKeyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Vente",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 173, 253),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: venteController.designation,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.label,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),

                    labelText: "Désignation",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: venteController.isDesignationValid.value
                    //     ? null
                    //     : "Désignation invalide",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: venteController.prix,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Nombres uniquement';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Prix",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: venteController.isPrixValid.value
                    //     ? null
                    //     : "Prix invalide",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: venteController.nombre,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Nombre uniquement';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Nombre",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: venteController.isNombreValid.value
                    //     ? null
                    //     : "Nombre invalide",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Obx(
                  () => DropdownButtonFormField<Types>(
                    value: venteController.selectedType.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      labelText:
                          " ${vente?.types?.name ?? 'Sélectionner un type'}",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: typesController.typesList.map((type) {
                      return DropdownMenuItem<Types>(
                        value: type,
                        child: Text(
                          type.name!,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 173, 253),
                          ),
                        ),
                      );
                    }).toList(),

                    // value: vente.types != null
                    //     ? vente.types
                    //     : venteController.selectedType.value,
                    onChanged: (value) {
                      venteController.selectedType.value = value!;
                      logger.i(
                        "Selected Type Vente Screen: ${venteController.selectedType.value!.id}",
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                (vente.id != null && vente is Vente)
                    ? ElevatedButton(
                        onPressed: () => {
                          venteController.updateVente(
                            vente,
                          ), // Update the vente
                        }, //  venteController.updateVente(vente),
                        child: Text(
                          "Modifier vente",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 173, 253),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () => {
                          venteController.createVente(),
                        }, //  venteController.createVente(),
                        child: Text(
                          "Créer vente",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 173, 253),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.offAll(() => VentesScreen()),
                  child: Text(
                    "Voir les ventes",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
