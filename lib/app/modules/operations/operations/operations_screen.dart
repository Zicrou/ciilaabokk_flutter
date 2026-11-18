import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/models/operation_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/journal_repository.dart';
import 'package:ciilaabokk/app/data/repositories/profils_repositories.dart';
import 'package:ciilaabokk/app/modules/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/login/login_screen.dart';
import 'package:ciilaabokk/app/modules/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/profils/profils_screen.dart';
import 'package:ciilaabokk/app/modules/operations/new_operation/operation_controller.dart';
import 'package:ciilaabokk/app/modules/operations/new_operation/operation_screen.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_controller.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:ciilaabokk/app/modules/auths/auth_controller.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class OperationsScreen extends StatelessWidget {
  final OperationsController controller = Get.put(OperationsController());
  final ProduitController produitController = Get.put(ProduitController());
  final OperationController _operationController = Get.put(
    OperationController(),
  );

  // final Vente vente;
  // const VentesScreen(this.vente, {Key? key}) : super(key: key);
  //final UserInfo userInfo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //final VentesController controller = Get.put(VentesController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 173, 253),

        onPressed: () => Get.offAll(() => OperationScreen()),
        child: Center(child: Icon(Icons.add, size: 30, color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 173, 253),
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("Profils"),
              onTap: () {
                Get.offAll(ProfilsScreen());
              },
            ),
            ListTile(
              title: Text("Opération"),
              onTap: () {
                Get.offAll(OperationsScreen());
              },
            ),
            ListTile(
              title: Text("Dépenses"),
              onTap: () {
                Get.offAll(DepensesScreen());
              },
            ),
            ListTile(
              title: Text("Produits"),
              onTap: () {
                Get.offAll(ProduitsScreen());
              },
            ),
            ListTile(
              title: Text("Journal"),
              onTap: () {
                Get.offAll(() => JournalScreen());
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Text(
          "Liste des opération",
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
                          await controller.authController.logout();
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
          // // Container(
          // //   margin: EdgeInsets.all(4),
          // //   child: Padding(
          // //     padding: const EdgeInsets.all(4),
          // //     child: Row(
          // //       children: [Text("${controller.authProvider.user.user?.name}")],
          // //     ),
          // //   ),
          // // ),
          SizedBox(height: 4),

          Obx(() {
            if (controller.operationsList.isEmpty) {
              return SizedBox.shrink();
            }
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  "Total journée: ${controller.operationsList[0].totalOfTheDay}FCFA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text:
                            'Vente total: ${controller.operationsList[0].totalVenteOfTheDay}FCFA\n',
                      ),
                      TextSpan(
                        text:
                            'Réparation: ${controller.operationsList[0].totalReparationOfTheDay} FCFA\n',
                      ),
                      TextSpan(
                        text:
                            'Dépense total:${controller.operationsList[0].depenseTotal} FCFA',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              // Default widget if none of the above conditions are met
              return ListView.builder(
                itemCount: controller.operationsList.length,
                itemBuilder: (context, index) {
                  final operation = controller.operationsList[index];
                  logger.i("Opértion from operations_screen: $operation ");
                  return Column(
                    children: operation.operations.map((o) {
                      final total =
                          (Decimal.tryParse(o.prix?.toString() ?? '0') ??
                              Decimal.zero) *
                          (Decimal.tryParse(o.nombre?.toString() ?? '0') ??
                              Decimal.zero);
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            o.designation?.isNotEmpty == true
                                ? o.designation!
                                : 'Produit: ${o.produit.designation}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text:
                                      'Type: ${o.types is List ? (o.types as List).map((type) => type.name).join(', ') : o.types?.name ?? ''}\n',
                                ),
                                TextSpan(text: 'Nombre: ${o.nombre}\n'),
                                TextSpan(text: 'Prix: ${o.prix} FCFA\n'),
                                TextSpan(
                                  text: '\nTotal:${total.toString()} FCFA',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 0, 173, 253),
                            child: Text(
                              o.nombre.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // IconButton(
                              //   icon: Icon(
                              //     Icons.edit,
                              //     color: Color.fromARGB(255, 4, 38, 255),
                              //   ),
                              //   onPressed: () async {
                              //     var produitFromOperationList;
                              //     try {
                              //       logger.i(
                              //         "Produit from list d'opération(o): ${o.produit}, pourquoi le rechercher alors avec getProduit()",
                              //       );
                              //       logger.i(
                              //         "ok pour modifier l'opération ${o} avec Produit ${o.produit}",
                              //       );
                              //       Get.to(
                              //         () => OperationScreen(),
                              //         arguments: {
                              //           "operation": o,
                              //           "produit": o.produit,
                              //         },
                              //       );
                              //     } catch (e) {
                              //       throw errorMessage("${e.toString()}");
                              //     } finally {
                              //       produitController.isLoading(false);
                              //     }
                              //     // verifier si le produit de la vente existe dans produitList;
                              //   },
                              // ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (dialogContext) => AlertDialog(
                                      title: const Text(
                                        'Annuler cette opération ?',
                                      ),
                                      content: const Text(
                                        'Cette action est irréversible.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(
                                            dialogContext,
                                          ).pop(false),
                                          child: const Text('Annuler'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(
                                            dialogContext,
                                          ).pop(true),
                                          child: const Text(
                                            'Supprimer',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm != true) return;

                                  logger.i(
                                    "ok pour supprimer l'opération ${o.id}",
                                  );
                                  _operationController.deleteOperation(o.id!);
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
