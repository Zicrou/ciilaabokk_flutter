import 'package:ciilaabokk/app/modules/depenses/depenses/depenses_screen.dart';
import 'package:ciilaabokk/app/modules/journaux/journaux/journal_screen.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_screen.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/profils/profils_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 173, 253),
            ),
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Profils'),
            onTap: () => Get.offAll(() => ProfilsScreen()),
          ),
          ListTile(
            title: const Text('Opérations'),
            onTap: () => Get.offAll(() => OperationsScreen()),
          ),
          ListTile(
            title: const Text('Dépenses'),
            onTap: () => Get.offAll(() => DepensesScreen()),
          ),
          ListTile(
            title: const Text('Produits'),
            onTap: () => Get.offAll(() => ProduitsScreen()),
          ),
          ListTile(
            title: const Text('Journal'),
            onTap: () => Get.offAll(() => JournalScreen()),
          ),
        ],
      ),
    );
  }
}
