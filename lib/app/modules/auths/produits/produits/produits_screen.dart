import 'dart:convert';
import 'dart:typed_data';

import 'package:ciilaabokk/app/core/values/app_colors.dart';
import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_screen.dart';
import 'package:ciilaabokk/app/modules/auths/produits/new_produit/produit_screen.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class ProduitsScreen extends StatelessWidget {
  final ProduitsController controller = Get.put(ProduitsController());

  @override
  Widget build(BuildContext context) {
    Color getColorForNombre(int? nombre) {
      if (nombre! <= 0) {
        return Colors.red;
      } else if (nombre! == 1) {
        return AppColors.backgroundColor;
      } else {
        return AppColors.primaryColor;
      }
    }

    logger.i("Produit from screen: ${controller.produitsList}");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 173, 253),

        onPressed: () => Get.offAll(() => ProduitScreen()),
        child: Center(child: Icon(Icons.add, size: 30, color: Colors.white)),
      ),
      appBar: AppBar(
        title: Text(
          "Liste des produits",
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'avenir',
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 0, 173, 253),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Déconnexion"),
                    content: Text(
                      "Êtes-vous sûr de vouloir vous déconnecter ?",
                    ),
                    actions: [
                      TextButton(
                        child: Text("Annuler"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Se déconnecter"),
                        onPressed: () async {
                          Navigator.of(context).pop(); // Close the dialog
                          await controller.authControler.logout();
                          Get.to(() => LoginScreen());
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFF5F5F5),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(4),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Text("${controller.authProvider.user.user?.name}"),
                  TextButton(
                    onPressed: () {
                      Get.offAll(DepensesScreen());
                    },
                    child: Text("Dépenses"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAll(VentesScreen());
                    },
                    child: Text("Ventes"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2),

          Obx(() {
            if (controller.produitsList.isEmpty) {
              return SizedBox.shrink();
            }
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  "Total des produits: ${(controller.produitsList != null) ? controller.produitsList[0].produits!.length : null}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
          SizedBox(height: 2),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              // Default widget if none of the above conditions are met
              return ListView.builder(
                itemCount: controller.produitsList.length,
                itemBuilder: (context, index) {
                  final produit = controller.produitsList[index];

                  return Column(
                    children: produit.produits!.map((p) {
                      // Image on top

                      var total = (p.montant!) * (p.nombre!);
                      return Card(
                        //borderOnForeground: (p.nombre! <= 0) ? false : true,
                        color: getColorForNombre(p.nombre!),
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 4,

                        child: Column(
                          children: [
                            // Image on top
                            // if
                            p.image != null
                                ? Image.memory(
                                    base64Decode(p.image as String),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 150,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                    ),
                                  ),
                            const SizedBox(height: 8),
                            ListTile(
                              title: Text(
                                p.designation!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text.rich(
                                TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Nombre: ${p.nombre}\n',
                                      // style: TextStyle(
                                      //   backgroundColor: (p.nombre! <= 0)
                                      //       ? Colors.red
                                      //       : AppColors.cardColor,
                                      // ),
                                    ),
                                    TextSpan(
                                      text: 'Montant: ${p.montant} FCFA\n',
                                    ),
                                    TextSpan(
                                      text: '\nTotal:${total} FCFA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // leading: p.image != null
                              //     ? Image.memory(
                              //         base64Decode(p.image as String),
                              //         width: 80,
                              //         height: 80,
                              //         fit: BoxFit.fill,
                              //       )
                              //     : Icon(Icons.image_not_supported),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 4, 38, 255),
                                    ),
                                    onPressed: () {
                                      logger.i(
                                        "ok pour modifier la vente ${p.id}",
                                      );
                                      Get.to(
                                        () => ProduitScreen(),
                                        arguments: p,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: (p.nombre! <= 0)
                                          ? Colors.white
                                          : AppColors.errorColor,
                                    ),
                                    onPressed: () {
                                      logger.i(
                                        "ok pour supprimer la vente ${p.id}",
                                      );
                                      controller.deleteProduits(p.id!);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
// ...existing code...