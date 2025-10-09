import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/auths/journaux/journaux/journal_controller.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_screen.dart';
import 'package:ciilaabokk/app/modules/auths/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/auths/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class JournalScreen extends StatelessWidget {
  final JournalController controller = Get.put(JournalController());
  // final Vente vente;
  // const VentesScreen(this.vente, {Key? key}) : super(key: key);
  //final UserInfo userInfo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //final VentesController controller = Get.put(VentesController());
    controller.fetchJournal(); // Charger les données
    logger.w("Journal list: ${controller.fetchJournal()}");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 173, 253),

        onPressed: () => Get.offAll(() => VenteScreen()),
        child: Center(child: Icon(Icons.add, size: 30, color: Colors.white)),
      ),
      appBar: AppBar(
        title: Text(
          "Journal",
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
                      // TextButton(
                      //   child: Text("Se déconnecter"),
                      //   onPressed: () async {
                      //     Navigator.of(context).pop(); // Close the dialog
                      //     await controller.authControler.logout();
                      //     Get.to(() => LoginScreen());
                      //   },
                      // ),
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
                  // Text("${controller.authProvider.user.user?.name}"),
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

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.journal.isEmpty) {
                return Center(child: Text("Aucune donnée disponible"));
              }

              // Calculer les totaux Globaux
              int totalGlobalVentes = 0;
              int totalGlobalDepense = 0;

              controller.journal.forEach((date, jour) {
                totalGlobalDepense += jour.depenses.totalDepenses;
                totalGlobalVentes += jour.ventes.totalVentes;
              });

              return ListView(
                children: [
                  // 🔹 Boucle par date
                  ...controller.journal.entries.map((entry) {
                    final date = entry.key;
                    final jour = entry.value;

                    return Card(
                      margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "$date",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),

                            // Liste des ventes
                            Center(
                              child: Text(
                                "Ventes:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ...jour.ventes.ventes.map(
                              (vente) => ListTile(
                                title: Center(
                                  child: Text(
                                    (vente.designation != null)
                                        ? vente.designation!
                                        : "Produit: ${vente.produit}",
                                  ),
                                ),
                                subtitle: Center(
                                  child: Text(
                                    "Prix: ${vente.prix} x Nombre: ${vente.nombre}",
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Total Ventes: ${jour.ventes.totalVentes} FCFA",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Divider(),

                            // Liste des dépenses
                            Center(
                              child: Text(
                                "Dépenses:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ...jour.depenses.depenses.map(
                              (depense) => ListTile(
                                title: Center(child: Text(depense.libelle)),
                                subtitle: Center(
                                  child: Text("Montant: ${depense.montant}"),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Total Dépenses: ${jour.depenses.totalDepenses} FCFA",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  // 🔹 Résumé global en bas
                  Card(
                    color: Colors.blue.shade50,
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "Résumé Global",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Total Ventes: $totalGlobalVentes FCFA",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Total Dépenses: $totalGlobalDepense FCFA",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
              // Resume Global
           
// ...existing code...