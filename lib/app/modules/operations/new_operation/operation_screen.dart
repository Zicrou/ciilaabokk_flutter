import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/produitsInfo.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/operations/new_operation/operation_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// ignore: must_be_immutable
class OperationScreen extends StatelessWidget {
  final OperationController operationController = Get.put(
    OperationController(),
    tag: 'operation-form',
  );
  final TypesController typesController = Get.put(TypesController());
  final ProduitsController produitsController = Get.put(ProduitsController());

  var title = "Nouvelle Opération";
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

    logger.w("Le produit a modifier: ${operationController.produit}");
    if (operationController.operation != null &&
        operationController.operation is Operation) {
      title = "Modifier l'opération";
      if (operationController.operation.designation != null) {
        operationController.designation.text =
            operationController.operation.designation!;
      }
      if (operationController.produit != null) {
        operationController.selectedProduit.value = operationController.produit;
      }
      operationController.prix.text = operationController.operation.prix
          .toString();
      operationController.nombre.text = operationController.operation.nombre
          .toString();
      logger.i("Selected Type: ${operationController.selectedType.value}");
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
            key: operationController.operation?.id != null
                ? operationController.updateOperationKeyForm
                : operationController.createOperationKeyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Opération",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 173, 253),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Obx(() {
                  if (operationController.operation == null) {
                    return DropdownButtonFormField<Produit>(
                      value: operationController.selectedProduit.value,
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
                        operationController.selectedProduit.value = value!;
                        logger.i(
                          "Selected produit opération Screen: ${operationController.selectedProduit.value!.id}",
                        );
                      },
                    );
                  } else if (operationController.operation != null &&
                      operationController.isProduit.value == true) {
                    return DropdownButtonFormField<Produit>(
                      value: operationController.selectedProduit.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.category,
                          color: Color.fromARGB(255, 0, 173, 253),
                        ),
                        labelText:
                            " ${operationController.produit?.designation}",
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
                          value: operationController.produit,
                          child: Text(
                            operationController.produit.designation!,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 173, 253),
                            ),
                          ),
                        ),
                      ],

                      onChanged: (value) {
                        operationController.selectedProduit.value = value!;
                        logger.i(
                          "Selected produit opération Screen: ${operationController.selectedProduit.value!.id}",
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                }),

                // return "Pas de produit rattaché";
                // Obx(
                // () => DropdownButtonFormField<Produit>(
                //   value: operationController.selectedProduit.value,
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
                //   //     : operationController.selectedType.value,
                //   onChanged: (value) {
                //     operationController.selectedProduit.value = value!;
                //     logger.i(
                //       "Selected Type Vente Screen: ${operationController.selectedProduit.value!.id}",
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
                  visible: operationController.selectedProduit.value == null,
                  child: TextFormField(
                    controller: operationController.designation,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.label,
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),

                      labelText: "Désignation",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      // errorText: operationController.isDesignationValid.value
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
                  controller: operationController.prix,
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
                    // errorText: operationController.isPrixValid.value
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
                  controller: operationController.nombre,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Nombre uniquement';
                    }
                    if (int.parse(operationController.nombre.text) <= 0) {
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
                    // errorText: operationController.isNombreValid.value
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
                    value: operationController
                        .selectedType
                        .value, //Check if type is selected  on create
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.category,
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      labelText:
                          " ${operationController.operation?.types is List ? (operationController.operation!.types as List).map((type) => type.name).join(', ') : operationController.operation?.types?.name ?? 'Sélectionner un type'}",
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
                    //     : operationController.selectedType.value,
                    onChanged: (value) {
                      operationController.selectedType.value = value!;
                      logger.i(
                        "Selected Type Vente Screen: ${operationController.selectedType.value!.id}",
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                (operationController.operation?.id != null)
                    ? ElevatedButton(
                        onPressed: () {
                          logger.w(
                            "ok pour modifier l'opértion: ${operationController.operation?.id}",
                          );
                          operationController.updateOperation(
                            operationController.operation,
                          );
                        },
                        child: Text(
                          "Modifier opération",
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
                          if (operationController.selectedType.value == null) {
                            errorMessage("Vous devez selectionner un type");
                            return;
                          }

                          if (operationController.designation.text.isNotEmpty &&
                              operationController.selectedProduit.value !=
                                  null) {
                            errorMessage(
                              "Vous devez choisir entre Produit et Désignation",
                            );
                            return;
                          }

                          final prixText = operationController.prix.text.trim();
                          final nombreText = operationController.nombre.text
                              .trim();

                          if (prixText.isEmpty || nombreText.isEmpty) {
                            errorMessage('Le montant et le nombre sont requis');
                            return;
                          }

                          final prix = Decimal.tryParse(prixText);
                          final nombre = int.tryParse(nombreText);

                          if (prix == null ||
                              nombre == null ||
                              prix <= Decimal.zero ||
                              nombre <= 0) {
                            errorMessage(
                              'Le montant ou le nombre doît être supérieur a 0',
                            );
                            return;
                          }

                          operationController.createOperation();
                        },
                        child: Text(
                          "Créer opération",
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
                  onPressed: () => Get.offAll(() => OperationsScreen()),
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
