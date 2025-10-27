import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/produitsInfo.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/modules/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/profils/profils_controller.dart';
import 'package:ciilaabokk/app/modules/profils/profils_screen.dart';
import 'package:ciilaabokk/app/modules/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// ignore: must_be_immutable
class AjouterMembreScreen extends StatelessWidget {
  final ProfilController controller = Get.put(ProfilController());
  var title = "Ajouter un membre";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 173, 253),

        onPressed: () => Get.offAll(() => AjouterMembreScreen()),
        child: Center(child: Icon(Icons.add, size: 30, color: Colors.white)),
      ),
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
            key:
                // depense.id != null
                //     ? controller.depensesUpdateKeyForm
                //     :
                controller.ajouterMembreKeyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Ajouter un membre",
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
                  controller: controller.phone_number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.label,
                      color: Color.fromARGB(255, 10, 151, 217),
                    ),
                    labelText: "Numéro de téléphone",
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

                ElevatedButton(
                  onPressed: () => {
                    controller.addUserToTeam(),
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

                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.offAll(ProfilsScreen()),
                  child: Text(
                    "Retour",
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
