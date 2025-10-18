import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/produitsInfo.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// ignore: must_be_immutable
class VenteScreen extends StatelessWidget {
  final VenteController venteController = Get.put(VenteController());
  final TypesController typesController = Get.put(TypesController());
  final ProduitsController produitsController = Get.put(ProduitsController());

  var title = "Nouvelle Vente";
  @override
  Widget build(BuildContext context) {
    // Create a list of Produit with nombre > 0
    // RxList<Produit?> produitList = <Produit>[].obs;
    // Future.delayed(Duration(seconds: 1), () {
    //   if (produitsController.produitsList.isNotEmpty) {
    //     produitsController.produitsList[0].produits!.forEach((produit) {
    //       if (produit.nombre != null && produit.nombre! > 0) {
    //         produitList.add(produit);
    //       }
    //     });
    //   }
    // });

    logger.w("Le produit a modifier: ${venteController.produit}");
    if (venteController.vente != null && venteController.vente is Vente) {
      title = "Modifier Vente";
      if (venteController.vente.designation != null) {
        venteController.designation.text = venteController.vente.designation!;
      }
      if (venteController.produit != null) {
        venteController.selectedProduit.value = venteController.produit;
      }
      venteController.prix.text = venteController.vente.prix.toString();
      venteController.nombre.text = venteController.vente.nombre.toString();
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
            key: venteController.vente?.id != null
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

                Obx(() {
                  if (venteController.vente == null) {
                    return DropdownButtonFormField<Produit>(
                      value: venteController.selectedProduit.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.category,
                          color: Color.fromARGB(255, 0, 173, 253),
                        ),
                        labelText: "Sélectionner dans le stock",
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
                      items: produitsController.produitsListSupAZero.isNotEmpty
                          ? produitsController.produitsListSupAZero.map((
                              produit,
                            )
                            // produitList.isNotEmpty
                            // ? produitList.map((produit)
                            {
                              return DropdownMenuItem<Produit>(
                                value: produit,
                                child: Text(
                                  produit!.designation!,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 173, 253),
                                  ),
                                ),
                              );
                            }).toList()
                          : [],

                      onChanged: (value) {
                        venteController.selectedProduit.value = value!;
                        logger.i(
                          "Selected Type Vente Screen: ${venteController.selectedProduit.value!.id}",
                        );
                      },
                    );
                  } else if (venteController.vente != null &&
                      venteController.isProduct.value == true) {
                    return DropdownButtonFormField<Produit>(
                      value: venteController.selectedProduit.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.category,
                          color: Color.fromARGB(255, 0, 173, 253),
                        ),
                        labelText: " ${venteController.produit?.designation}",
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

                      items: [
                        DropdownMenuItem<Produit>(
                          value: venteController.produit,
                          child: Text(
                            venteController.produit.designation!,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 173, 253),
                            ),
                          ),
                        ),
                      ],

                      onChanged: (value) {
                        venteController.selectedProduit.value = value!;
                        logger.i(
                          "Selected Type Vente Screen: ${venteController.selectedProduit.value!.id}",
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                }),

                // return "Pas de produit rattaché";
                // Obx(
                // () => DropdownButtonFormField<Produit>(
                //   value: venteController.selectedProduit.value,
                //   decoration: InputDecoration(
                //     prefixIcon: Icon(
                //       Icons.category,
                //       color: Color.fromARGB(255, 0, 173, 253),
                //     ),
                //     labelText:
                //         " ${produit?.designation ?? 'Sélectionner dans le stock'}",
                //     labelStyle: TextStyle(
                //       color: Color.fromARGB(255, 0, 173, 253),
                //     ),
                //     filled: true,
                //     fillColor: Colors.white,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide.none,
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                //   // produitsController.produitsList.isNotEmpty
                //   //     ? produitsController.produitsList[0].produits!
                //   // if produit on modif return item with produitFromVente
                //   // else return item with  produitsController.produitsList.isNotEmpty
                //   //     ? produitsController.produitsList[0].produits!
                //   items: produitsController.produitsList.isNotEmpty
                //       ? produitsController.produitsList[0].produits!.map((
                //           produit,
                //         ) {
                //           return DropdownMenuItem<Produit>(
                //             value: produit,
                //             child: Text(
                //               produit.designation!,
                //               style: TextStyle(
                //                 color: Color.fromARGB(255, 0, 173, 253),
                //               ),
                //             ),
                //           );
                //         }).toList()
                //       : [],

                //   // value: vente.types != null
                //   //     ? vente.types
                //   //     : venteController.selectedType.value,
                //   onChanged: (value) {
                //     venteController.selectedProduit.value = value!;
                //     logger.i(
                //       "Selected Type Vente Screen: ${venteController.selectedProduit.value!.id}",
                //     );
                //   },
                // ),
                // ),
                SizedBox(height: 30),

                // vente?.designation == null
                //     ? SizedBox.shrink() :
                // if(vente != null and produit != null){

                // }
                SizedBox(height: 30),
                Visibility(
                  visible: venteController.selectedProduit.value == null,
                  child: TextFormField(
                    controller: venteController.designation,
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
                    if (int.parse(value) <= 0) {
                      errorMessage("Le prix n'est pas valide");
                      return null;
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
                    if (int.parse(venteController.nombre.text) <= 0) {
                      errorMessage("Le nombre n'est pas valide");
                      return null;
                    }
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
                    value: venteController
                        .selectedType
                        .value, //Check if type is selected  on create
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      labelText:
                          " ${venteController.vente?.types?.name ?? 'Sélectionner un type'}",
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
                      logger.i("Type value: ${type}");
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
                (venteController.vente?.id != null)
                    ? ElevatedButton(
                        onPressed: () => {
                          logger.w(
                            "ok pour modifier vente: ${venteController.vente.id}",
                          ),
                          // if (venteController.designation.text.isNotEmpty &&
                          //     venteController.selectedProduit.value != null) {
                          //   errorMessage(
                          //     "Vous devez choisir entre Produit et Désignation"
                          //   ),

                          // },
                          // if ((int.parse(venteController.prix.text) <= 0) ||
                          //     (int.parse(venteController.nombre.text) <= 0)) {
                          //   errorMessage(
                          //     'Le montant ou le nombre doît être supérieur a 0',
                          //   )
                          //   return;
                          // },
                          // if (venteController.prix.text.length < 3) {
                          //   errorMessage(
                          //     "Le prix doît être supérieur à 3 chiffres",
                          //   )
                          //   return null;
                          // },
                          venteController.updateVente(
                            venteController.vente,
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
                        onPressed: () {
                          if (venteController.selectedType.value == null) {
                            errorMessage("Vous devez selectionner un type");
                          }
                          if (venteController.designation.text.isNotEmpty &&
                              venteController.selectedProduit.value != null) {
                            errorMessage(
                              "Vous devez choisir entre Produit et Désignation",
                            );
                          }
                          if ((int.parse(venteController.prix.text) <= 0) ||
                              (int.parse(venteController.nombre.text) <= 0)) {
                            errorMessage(
                              'Le montant ou le nombre doît être supérieur a 0',
                            );
                            return;
                          }
                          if (venteController.prix.text.length < 3) {
                            errorMessage(
                              "Le prix doît être supérieur à 3 chiffres",
                            );
                            return null;
                          }
                          venteController.createVente();
                          //}
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
