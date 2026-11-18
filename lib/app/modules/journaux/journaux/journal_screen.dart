import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/modules/journaux/journaux/journal_controller.dart';
import 'package:ciilaabokk/app/widgets/app_drawer.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _JournalDataSource<T> extends DataTableSource {
  _JournalDataSource(this.items, this.buildCells);

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

class JournalScreen extends StatelessWidget {
  JournalScreen({super.key, this.userId});

  final String? userId;

  final _journalController = Get.find<JournalController>();

  String _operationDesignation(Operation operation) {
    if (operation.designation?.trim().isNotEmpty == true) {
      return operation.designation!.trim();
    }

    final produit = operation.produit;
    if (produit is Produit) {
      return produit.designation ?? 'Produit';
    }

    return produit == null ? '—' : 'Produit: $produit';
  }

  String _operationType(Operation operation) {
    final type = operation.types;
    if (type is List) {
      return type.map((item) => item.name).join(', ');
    }
    return type?.name?.toString() ?? '—';
  }

  Decimal _operationTotal(Operation operation) {
    final prix =
        Decimal.tryParse(operation.prix?.toString() ?? '') ?? Decimal.zero;
    return prix * Decimal.fromInt(operation.nombre ?? 0);
  }

  Widget _buildOperationsTable() {
    final items = _journalController.operationsList;
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Aucune opération trouvée'),
      );
    }

    return PaginatedDataTable(
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20],
      columns: const [
        DataColumn(label: Text('Désignation')),
        DataColumn(label: Text('Type')),
        DataColumn(label: Text('Nombre'), numeric: true),
        DataColumn(label: Text('Prix unitaire'), numeric: true),
        DataColumn(label: Text('Total'), numeric: true),
      ],
      source: _JournalDataSource(
        items.toList(),
        (operation) => [
          DataCell(Text(_operationDesignation(operation))),
          DataCell(Text(_operationType(operation))),
          DataCell(Text('${operation.nombre ?? 0}')),
          DataCell(Text('${operation.prix ?? Decimal.zero} FCFA')),
          DataCell(Text('${_operationTotal(operation)} FCFA')),
        ],
      ),
    );
  }

  Widget _buildDepensesTable() {
    final items = _journalController.depensesList.toList();
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Aucune dépense trouvée'),
      );
    }

    return PaginatedDataTable(
      rowsPerPage: 5,
      availableRowsPerPage: const [5, 10, 20],
      columns: const [
        DataColumn(label: Text('Libellé')),
        DataColumn(label: Text('Montant'), numeric: true),
      ],
      source: _JournalDataSource(
        items,
        (depense) => [
          DataCell(Text(depense.libelle ?? '—')),
          DataCell(Text('${depense.montant ?? Decimal.zero} FCFA')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Journal',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'avenir',
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 0, 173, 253),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Actualiser',
            icon: const Icon(Icons.refresh),
            onPressed: () => _journalController.fetchJournal(userId),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Obx(() {
        // Verifier si isLoading est a true
        if (_journalController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Opérations',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              clipBehavior: Clip.antiAlias,
              child: _journalController.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _buildOperationsTable(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Dépenses',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              clipBehavior: Clip.antiAlias,
              child: _journalController.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _buildDepensesTable(),
            ),
          ],
        );
      }),
    );
  }
}
