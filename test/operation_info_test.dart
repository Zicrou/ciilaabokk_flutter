import 'package:ciilaabokk/app/data/models/operation_info.dart';
import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses integer product amounts from the operations API', () {
    final response = OperationInfo.fromJson({
      'operations': [
        {
          'id': 'operation-id',
          'nombre': 2,
          'prix': '111111.00',
          'types': [],
          'produit': {
            'id': 'product-id',
            'designation': 'Produit 5',
            'nombre': 209,
            'montant': 11111111,
          },
        },
      ],
      'input': [],
      'totalOfTheDay': 24355531,
      'totalVenteOfTheDay': 24355531,
      'totalReparationOfTheDay': 0,
      'depenseTotal': 0,
    });

    final produit = response.operations.single.produit;

    expect(produit, isA<Produit>());
    expect((produit as Produit).montant, Decimal.parse('11111111'));
    expect(response.totalOfTheDay, Decimal.parse('24355531'));
  });
}
