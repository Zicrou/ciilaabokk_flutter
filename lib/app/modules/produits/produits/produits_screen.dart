import 'package:ciilaabokk/app/core/values/app_colors.dart';
import 'package:ciilaabokk/app/data/repositories/produits_repositories.dart';
import 'package:ciilaabokk/app/modules/login/login_screen.dart';
import 'package:ciilaabokk/app/modules/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/produits/new_produit/produit_screen.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/widgets/app_drawer.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

// ...existing code...
final logger = Logger();

class ProduitsScreen extends StatefulWidget {
  final bool showCreationSuccess;

  const ProduitsScreen({super.key, this.showCreationSuccess = false});

  @override
  State<ProduitsScreen> createState() => _ProduitsScreenState();
}

class _ProduitsScreenState extends State<ProduitsScreen> {
  final ProduitsController controller = Get.put(ProduitsController());
  final ProduitController _produitController = Get.put(ProduitController());

  @override
  void initState() {
    super.initState();
  }

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
      drawer: const AppDrawer(),
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
                children: [Text("${controller.authProvider.user.user?.name}")],
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

                      var total = p.montant! * Decimal.fromInt(p.nombre ?? 0);
                      // final baseUrl =
                      //     'http://10.0.2.2:8000'; // For Android emulator
                      return Card(
                        //borderOnForeground: (p.nombre! <= 0) ? false : true,
                        color: getColorForNombre(p.nombre ?? 0),
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 4,

                        child: Column(
                          children: [
                            
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
                                        "ok pour modifier le produit ${p.id}",
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
                                        "ok pour supprimer le produit ${p.id}",
                                      );
                                      // ProduitsRepositories().deleteProduits(p.id!);
                                      _produitController.deleteProduits(p.id!);
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
