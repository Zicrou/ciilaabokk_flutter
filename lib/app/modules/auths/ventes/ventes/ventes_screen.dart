import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class VentesScreen extends StatelessWidget {
  final authProvider = Get.find<AuthProvider>();
  final authController = Get.find<AuthController>();
  // final Vente vente;
  // const VentesScreen(this.vente, {Key? key}) : super(key: key);
  //final UserInfo userInfo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final VentesController controller = Get.put(VentesController());
    return Scaffold(
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
                          await authController.logout();
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
                  TextButton(
                    onPressed: () => Get.to(() => VenteScreen()),
                    child: Text("Ajouter une vente"),
                  ),
                  Text("${authProvider.user.user?.name}"),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.ventesList.isEmpty) {
                return Center(child: Text("Aucune vente trouvée."));
              }
              // Default widget if none of the above conditions are met
              return ListView.builder(
                itemCount: controller.ventesList.length,
                itemBuilder: (context, index) {
                  final vente = controller.ventesList[index];

                  return Column(
                    children: vente.ventes.map((v) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            v.designation?.isNotEmpty == true
                                ? v.designation!
                                : 'Produit ID: ${v.produitId}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Quantité: ${v.nombre}'),
                          trailing: Text('${v.prix} FCFA'),
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