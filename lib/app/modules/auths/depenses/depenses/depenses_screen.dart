import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/depenses/depenses_controller.dart';
import 'package:ciilaabokk/app/modules/auths/depenses/new_depense/depense_screen.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_screen.dart';
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

      appBar: AppBar(
        title: Text(
          "${controller.depensesProvider.user.user?.name ?? 'Liste des dépenses'}",
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
            margin: EdgeInsets.all(5),
            child: TextButton(
              onPressed: () => Get.offAll(VentesScreen()),
              child: Text("Go to ventes"),
            ),
          ),
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

          Expanded(
            child: Obx(() {
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
                      children: depense.depenses.map((v) {
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(
                              v.libelle!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Montant: ${v.montant}'),
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