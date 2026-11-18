import 'dart:math';

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
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Journal')),
        DataColumn(label: Text('Actions')),
      ],
      source: _ProfilsDataSource(
        items.toList(),
        (membre)  {
          final userId = membre.id;
          return[
            DataCell(Text(membre.name ?? '')),
          DataCell(TextButton(
                onPressed: userId == null
                    ? null
                    : () => Get.to(
                          () => (userId: userId),
                        ),
                child: const Text('Voir le journal'),
              ),
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
                                content: const Text(
                                  'Cette action est irréversible.',
                                ),
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
                : Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: Text("Moi"),
                  ),
          ),
          ];
          
        }
      ),
    );
  }

  Widget _buildDemandesEnvoyeesTable(BuildContext context) {
    final demandesEnvoyees = controller.listDemandesEnvoyees; //listDemandes
    if (demandesEnvoyees.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Aucune demande envoyée.'),
      );
    }

    return PaginatedDataTable(
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20],
      columns: const [
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Statut')),
        DataColumn(label: Text('Actions')),
      ],
      source: _ProfilsDataSource(
        demandesEnvoyees.toList(),
        (demande) => [
          DataCell(Text(demande.user!.name ?? '')),
          DataCell(Text(demande.status! ?? '')),
          DataCell(
            IconButton(
              tooltip: 'Supprimer le membre',
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: demande.id == null
                  ? null
                  : () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Supprimer la demande ?'),
                          content: const Text('Cette action est irréversible.'),
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
                        await controller.deleteMembre(demande.id!);
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemandesRecuesTable(BuildContext context) {
    final demandesRecues = controller.listDemandesRecues; //listDemandes
    if (demandesRecues.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Aucune demande reçue.'),
      );
    }

    return PaginatedDataTable(
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20],
      columns: const [
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Statut')),
        DataColumn(label: Text('Actions')),
      ],
      source: _ProfilsDataSource(demandesRecues.toList(), (demande) {
        final userId = demande.user?.id;

        return [
          DataCell(Text(demande.user?.name ?? '')),
          DataCell(Text(demande.status ?? '')),
          DataCell(
            Obx(() {
              final selectedResponse = userId == null
                  ? null
                  : controller.reponsesDemandes[userId];

              return Row(
                children: [
                  DropdownButton<String>(
                    value: selectedResponse ?? 'choisir',
                    items: const [
                      DropdownMenuItem(
                        value: 'choisir',
                        child: Text('Choisir'),
                      ),
                      DropdownMenuItem(
                        value: 'accepter',
                        child: Text('Accepter'),
                      ),
                      DropdownMenuItem(
                        value: 'refuser',
                        child: Text('Refuser'),
                      ),
                    ],
                    onChanged: userId == null
                        ? null
                        : (value) {
                            if (value != null) {
                              controller.reponsesDemandes[userId] = value;
                            }
                          },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed:
                        userId == null ||
                            selectedResponse == null ||
                            selectedResponse == 'choisir'
                        ? null
                        : () {
                            controller.accepterRefuserReponse(
                              userId,
                              selectedResponse,
                            );
                          },
                    child: const Text('Valider'),
                  ),
                ],
              );
            }),
          ),
        ];
      }),
    );
  }

  Widget _buildEquipesTable(BuildContext context) {
    final items = controller.listDesEquipesDansLesquellesJeSuis;
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Vous êtes dans aucune équipe.'),
      );
    }

    return PaginatedDataTable(
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20],
      columns: const [
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Actions')),
      ],
      source: _ProfilsDataSource(
        items.toList(),
        (equipe) {
          final userId = equipe.user?.id?.toString();

          return [
            DataCell(Text(equipe.user?.name ?? '')),
            DataCell(
              TextButton(
                onPressed: userId == null
                    ? null
                    : () => Get.to(
                          () => (userId: userId),
                        ),
                child: const Text('Voir le journal'),
              ),
            ),
          ];
        },
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
              'Demandes envoyés',
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
                  : _buildDemandesEnvoyeesTable(context),
            ),
            const SizedBox(height: 8),
            const Text(
              'Demandes reçues',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Card(
              clipBehavior: Clip.antiAlias,
              child: controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _buildDemandesRecuesTable(context),
            ),
            const Text(
              'Je suis dans l\'equpe de:',
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
                  : _buildEquipesTable(context),
                )
          ],
        );
      }),
    );
  }
}
