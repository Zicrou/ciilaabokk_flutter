import 'package:ciilaabokk/app/modules/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/profils/journaux/jouralMembresUser_screen.dart';
import 'package:ciilaabokk/app/modules/profils/membres/ajouter_membre_screen.dart';
import 'package:ciilaabokk/app/modules/profils/profils_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// ignore: must_be_immutable
class ProfilsScreen extends StatelessWidget {
  final ProfilController controller = Get.put(ProfilController());
  var title = "Mon profil";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 173, 253),

        onPressed: () => Get.offAll(() => AjouterMembreScreen()),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Title(
                color: Color.fromARGB(255, 0, 173, 253),
                child: Text(
                  'Liste des membres',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Color.fromARGB(255, 0, 173, 253),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                // Default widget if none of the above conditions are met
                return ListView.builder(
                  itemCount: controller.listMembres.length,
                  itemBuilder: (_, index) {
                    final membre = controller.listMembres[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(
                          '${membre.name} ${membre.phoneNumber}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          logger.i("User: ${membre.id}");
                          Get.to(
                            () => JournalMembresUserScreen(),
                            arguments: {"user": membre.id},
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
