import 'package:ciilaabokk/app/modules/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/profils/journaux/journalMembresUser_controller.dart';
import 'package:ciilaabokk/app/modules/profils/profils_screen.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class JournalMembresUserScreen extends StatelessWidget {
  final JournalMembresUserController controller = Get.put(
    JournalMembresUserController(),
  );

  // final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //final VentesController controller = Get.put(VentesController());
    // if (args['user'] == null) {
    //   controller.fetchJournal(); // Charger les données
    // }else{
    //   controller.user
    // }

    return Scaffold(
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
