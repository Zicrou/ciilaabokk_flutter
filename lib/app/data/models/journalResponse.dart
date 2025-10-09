import 'package:logger/logger.dart';

final logger = Logger();

class JournalResponse {
  final Map<String, JournalDay> journal;

  JournalResponse({required this.journal});

  factory JournalResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, JournalDay> parsed = {};
    (json['journal'] as Map<String, dynamic>).forEach((date, data) {
      parsed[date] = JournalDay.fromJson(data as Map<String, dynamic>);
      logger.i("Journal date ${parsed}");
    });
    return JournalResponse(journal: parsed);
  }
}

class JournalDay {
  final JournalDepenses depenses;
  final JournalVentes ventes;

  JournalDay({required this.depenses, required this.ventes});

  factory JournalDay.fromJson(Map<String, dynamic> json) {
    return JournalDay(
      depenses: JournalDepenses.fromJson(json['depenses']),
      ventes: JournalVentes.fromJson(json['ventes']),
    );
  }
}

class JournalDepenses {
  final List<Depense> depenses;
  final int totalDepenses;

  JournalDepenses({required this.depenses, required this.totalDepenses});

  factory JournalDepenses.fromJson(Map<String, dynamic> json) {
    final depensesList = <Depense>[];
    json.forEach((key, value) {
      if (key != 'totalDepenses') {
        depensesList.add(Depense.fromJson(value));
      }
    });
    return JournalDepenses(
      depenses: depensesList,
      totalDepenses: json['totalDepenses'] ?? 0,
    );
  }
}

class JournalVentes {
  final List<Vente> ventes;
  final int totalVentes;

  JournalVentes({required this.ventes, required this.totalVentes});

  factory JournalVentes.fromJson(Map<String, dynamic> json) {
    final ventesList = <Vente>[];
    json.forEach((key, value) {
      if (key != 'totalVentes') {
        ventesList.add(Vente.fromJson(value));
      }
    });
    return JournalVentes(
      ventes: ventesList,
      totalVentes: json['totalVentes'] ?? 0,
    );
  }
}

class Depense {
  final int id;
  final String libelle;
  final int montant;

  Depense({required this.id, required this.libelle, required this.montant});

  factory Depense.fromJson(Map<String, dynamic> json) {
    return Depense(
      id: json['id'],
      libelle: json['libelle'] ?? '',
      montant: json['montant'] ?? 0,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Depense: ID ${id}, libelle ${libelle}, Montant ${montant}";
  }
}

class Vente {
  final int id;
  final String? designation;
  final dynamic produit;
  final int nombre;
  final int prix;
  final dynamic type;

  Vente({
    required this.id,
    this.designation,
    required this.nombre,
    required this.prix,
    this.produit,
    this.type,
  });

  factory Vente.fromJson(Map<String, dynamic> json) {
    return Vente(
      id: json['id'],
      designation: json['designation'] ?? null,
      nombre: json['nombre'],
      prix: json['prix'],
      produit: json['produit_id'] ?? null,
      type: json['type'],
    );
  }
}
