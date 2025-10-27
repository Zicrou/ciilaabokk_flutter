import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/modules/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/depenses/new_depense/depense_screen.dart';
import 'package:ciilaabokk/app/modules/login/login_screen.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/profils/profils_screen.dart';
import 'package:ciilaabokk/app/modules/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/new_vente/vente_screen.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/modules/auths/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class DepensesScreen extends StatelessWidget {
  final DepensesController controller = Get.put(DepensesController());
  // final Vente vente;
  // const VentesScreen(this.vente, {Key? key}) : super(key: key);
  //final UserInfo userInfo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // final DepensesController controller = Get.put(DepensesController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 173, 253),

        onPressed: () => Get.to(() => DepenseScreen()),
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
              title: Text("Ventes"),
              onTap: () {
                Get.offAll(VentesScreen());
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
                Get.offAll(JournalScreen());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "${controller.depensesProvider.user.user?.name ?? 'Dépenses'}",
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
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Liste des dépenses",
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'avenir',
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2),

          Obx(() {
            if (controller.listeDepenses.isEmpty) {
              return SizedBox.shrink();
            }
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  "Total dépense de la journée: ${controller.listeDepenses[0].totalOfTheDay}FCFA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      // TextSpan(
                      //   text:
                      //       'Vente total: ${controller.listeDepenses[0].totalVenteOfTheDay}FCFA\n',
                      // ),
                      // TextSpan(
                      //   text:
                      //       'Réparation: ${controller.listeDepenses[0].totalReparationOfTheDay} FCFA\n',
                      // ),
                      // TextSpan(
                      //   text:
                      //       'Dépense total:${controller.listeDepenses[0].depenseTotal} FCFA',
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 2),

          Expanded(
            child: Obx(() {
              print(controller.listeDepenses.isEmpty);
              {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.listeDepenses.isEmpty) {
                  return Center(child: Text("Aucune dépense trouvée"));
                }
                // Default widget if none of the above conditions are met
                return ListView.builder(
                  itemCount: controller.listeDepenses.length,
                  itemBuilder: (context, index) {
                    final depense = controller.listeDepenses[index];

                    return Column(
                      children: depense.depenses.map((d) {
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(
                              d.libelle!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Montant: ${d.montant}'),
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
                                      "ok pour modifier la la dépense ${d.id}",
                                    );
                                    Get.to(() => DepenseScreen(), arguments: d);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    logger.i(
                                      "ok pour supprimer la dépense ${d.id}",
                                    );
                                    controller.deleteDepense(d.id!);
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
              }
            }),
          ),
        ],
      ),
    );
  }
}
// ...existing code...