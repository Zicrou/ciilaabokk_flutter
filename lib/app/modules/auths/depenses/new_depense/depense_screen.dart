import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/new_depense/depense_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/modules/auths/auth_controller.dart';
import 'package:ciilaabokk/view/signup_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DepenseScreen extends StatelessWidget {
  final DepenseController controller = Get.put(DepenseController());
  final Depenses depense = Get.arguments ?? Depenses();
  var title = "Nouvelle Dépense";
  @override
  Widget build(BuildContext context) {
    if (depense.id != null && depense is Depenses) {
      title = "Modifier Dépense";
      controller.libelle.text = depense.libelle!;
      controller.montant.text = depense.montant.toString();
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
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: depense.id != null
                ? controller.depensesUpdateKeyForm
                : controller.depensesKeyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Dépense",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 173, 253),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    return null;
                  },
                  controller: controller.libelle,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.label,
                      color: Color.fromARGB(255, 10, 151, 217),
                    ),
                    labelText: "Libellé",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: controller.libelle.value
                    //     ? null
                    //     : "Libellé invalide",
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Nombres uniquement';
                    }
                    if (int.parse(value) <= 0) {
                      return "Veuillez saisir un montant valide";
                    }
                    return null;
                  },
                  controller: controller.montant,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Montant",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: controller.montant.value
                    //     ? null
                    //     : "Montant invalide",
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
                (depense.id != null && depense is Depenses)
                    ? ElevatedButton(
                        onPressed: () => {
                          controller.updateDepense(depense), // Update the vente
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
                          controller.createDepense(),
                        }, //  venteController.createVente(),
                        child: Text("Valider", style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 173, 253),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                // Obx(
                //   () => controller.isLoading
                //       ? Center(
                //           child: CircularProgressIndicator(
                //             color: Color.fromARGB(255, 0, 173, 253),
                //           ),
                //         )
                //       : ElevatedButton(
                //           onPressed: () => controller.createDepense(),
                //           child: Text(
                //             "Valider",
                //             style: TextStyle(fontSize: 18),
                //           ),
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: Color.fromARGB(255, 0, 173, 253),
                //             foregroundColor: Colors.white,
                //             padding: EdgeInsets.symmetric(vertical: 16),
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //           ),
                //         ),
                // ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.offAll(DepensesScreen()),
                  child: Text(
                    "Voir les dépenses",
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
