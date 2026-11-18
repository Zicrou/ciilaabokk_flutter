import 'package:ciilaabokk/app/modules/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/profils/journaux/jouralMembresUser_screen.dart';
import 'package:ciilaabokk/app/modules/profils/membres/ajouter_membre_screen.dart';
import 'package:ciilaabokk/app/modules/profils/profils_controller.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class _ProfilsDataSource<T> extends DataTableSource {
  _ProfilsDataSource(this.items, this.buildCells);

  final List<T> items;
  final List<DataCell> Function(T item) buildCells;

  @override
  DataRow? getRow(int index) {
    if (index >= items.length) {
      return null;
    }

    return DataRow.byIndex(index: index, cells: buildCells(items[index]));
  }

  @override
  int get rowCount => items.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

// ignore: must_be_immutable
class ProfilsScreen extends StatelessWidget {
  final ProfilController controller = Get.put(ProfilController());
  var title = "Mon profil";

  Widget _buildMembresTable(BuildContext context) {
    final items = controller.listMembres;
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Aucun membre dans votre équipe.'),
      );
    }

    return PaginatedDataTable(
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20],
      columns: const [
        DataColumn(label: Text('nom')),
        DataColumn(label: Text('Rôle')),
        DataColumn(label: Text('Actions')),
      ],
      source: _ProfilsDataSource(
        items.toList(),
        (membre) => [
          DataCell(Text(membre.name ?? '')),
          DataCell(
            (membre.pivot?.teamId == membre.team_id)
                ? Text("${membre.pivot?.role ?? ''} (Moi)")
                : Text(membre.pivot?.role ?? ''),
          ),
          DataCell(
            (membre.pivot?.teamId != membre.team_id)
                ? IconButton(
                    tooltip: 'Supprimer le membre',
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: membre.id == null
                        ? null
                        : () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: const Text('Supprimer ce membre ?'),
                                content:
                                    const Text('Cette action est irréversible.'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(false),
                                    child: const Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(true),
                                    child: const Text(
                                      'Supprimer',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await controller.deleteMembre(membre.id!);
                            }
                          },
                  )
                : Padding(padding: EdgeInsetsGeometry.all(16), child: Text("Moi"),),
          ),
        ],
      ),
    );
  }
  Widget _buildDemandesTable(BuildContext context) {
    final items = controller.listMembres; //listDemandes
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Aucune demande d\'ajout.'),
      );
    }

    return PaginatedDataTable(
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20],
      columns: const [
        DataColumn(label: Text('nom')),
        DataColumn(label: Text('Actions')),
      ],
      source: _ProfilsDataSource(
        items.toList(),
        (membre) => [
          DataCell(Text(membre.name ?? '')),
          
          DataCell(
            (membre.pivot?.teamId != membre.team_id)
                ? IconButton(
                    tooltip: 'Supprimer le membre',
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: membre.id == null
                        ? null
                        : () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: const Text('Supprimer ce membre ?'),
                                content:
                                    const Text('Cette action est irréversible.'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(false),
                                    child: const Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(true),
                                    child: const Text(
                                      'Supprimer',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await controller.deleteMembre(membre.id!);
                            }
                          },
                  )
                :  Text(""),
          ),
        ],
      ),
    );
  }

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
              title: Text("Opérations"),
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
      body: Obx(() {
        // Verifier si isLoading est a true
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Les membres de mon équipe',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              clipBehavior: Clip.antiAlias,
              child: controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _buildMembresTable(context),
            ),
            const SizedBox(height: 24),
            const Text(
              'Demande d\'ajout',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              clipBehavior: Clip.antiAlias,
              child: controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _buildDemandesTable(context),
            ),
          ],
        );
      }),
    );
  }
}
