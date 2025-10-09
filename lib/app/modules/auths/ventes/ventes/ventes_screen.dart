import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/auths/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_screen.dart';
import 'package:ciilaabokk/app/modules/auths/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class VentesScreen extends StatelessWidget {
  final VentesController controller = Get.put(VentesController());
  final ProduitController produitController = Get.put(ProduitController());
  // final Vente vente;
  // const VentesScreen(this.vente, {Key? key}) : super(key: key);
  //final UserInfo userInfo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //final VentesController controller = Get.put(VentesController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 173, 253),

        onPressed: () => Get.offAll(() => VenteScreen()),
        child: Center(child: Icon(Icons.add, size: 30, color: Colors.white)),
      ),
      appBar: AppBar(
        title: Text(
          "Liste des ventes",
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
                      Get.offAll(JournalScreen());
                    },
                    child: Text("Journal"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAll(ProduitsScreen());
                    },
                    child: Text("Produits"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2),

          Obx(() {
            if (controller.ventesList.isEmpty) {
              return SizedBox.shrink();
            }
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  "Total journée: ${controller.ventesList[0].totalOfTheDay}FCFA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text:
                            'Vente total: ${controller.ventesList[0].totalVenteOfTheDay}FCFA\n',
                      ),
                      TextSpan(
                        text:
                            'Réparation: ${controller.ventesList[0].totalReparationOfTheDay} FCFA\n',
                      ),
                      TextSpan(
                        text:
                            'Dépense total:${controller.ventesList[0].depenseTotal} FCFA',
                      ),
                    ],
                  ),
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
                itemCount: controller.ventesList.length,
                itemBuilder: (context, index) {
                  final vente = controller.ventesList[index];
                  return Column(
                    children: vente.ventes.map((v) {
                      var total = (v.prix!) * (v.nombre!);
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            v.designation?.isNotEmpty == true
                                ? v.designation!
                                : 'Produit ID: ${v.produit.designation}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: 'Type: ${v.types.name}\n'),
                                TextSpan(text: 'Nombre: ${v.nombre}\n'),
                                TextSpan(text: 'Prix: ${v.prix} FCFA\n'),
                                TextSpan(
                                  text: '\nTotal:${total} FCFA',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 0, 173, 253),
                            child: Text(
                              v.nombre.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 4, 38, 255),
                                ),
                                onPressed: () async {
                                  produitController.isLoading(true);
                                  // if (produitController.isLoading.value ==
                                  //     true) {
                                  //   CircularProgressIndicator;
                                  // }

                                  var produitFromVenteList;
                                  try {
                                    if (v.produit == null) {
                                      produitFromVenteList = null;
                                    } else {
                                      produitFromVenteList =
                                          await produitController.getProduit(
                                            v.produit.id,
                                          );
                                      logger.w(
                                        "Produit: ${produitFromVenteList == null}",
                                      );
                                    }

                                    logger.i(
                                      "ok pour modifier la vente ${v} et Produit ${produitFromVenteList}",
                                    );
                                    Get.to(
                                      () => VenteScreen(),
                                      arguments: {
                                        "vente": v,
                                        "produit": produitFromVenteList,
                                      },
                                    );
                                  } catch (e) {
                                    throw errorMessage("${e.toString()}");
                                  } finally {
                                    produitController.isLoading(false);
                                  }
                                  // verifier si le produit de la vente existe dans produitList;
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  logger.i(
                                    "ok pour supprimer la vente ${v.id}",
                                  );
                                  controller.deleteVente(v.id!);
                                },
                              ),
                            ],
                          ),
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