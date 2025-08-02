// To parse this JSON data, do
//
//     final vente = venteFromJson(jsonString);

import 'dart:convert';

VenteResponse venteFromJson(String str) =>
    VenteResponse.fromJson(json.decode(str));
String venteToJson(Vente data) => json.encode(data.toJson());

class VenteResponse {
  List<Vente> ventes;
  List<dynamic> input;
  int totalOfTheDay;
  int totalVenteOfTheDay;
  int totalReparationOfTheDay;
  int depenseTotal;
  String status;

  VenteResponse({
    required this.ventes,
    required this.input,
    required this.totalOfTheDay,
    required this.totalVenteOfTheDay,
    required this.totalReparationOfTheDay,
    required this.depenseTotal,
    required this.status,
  });

  factory VenteResponse.fromJson(Map<String, dynamic> json) => VenteResponse(
    ventes: List<Vente>.from(json["ventes"].map((x) => Vente.fromJson(x))),
    input: json["input"],
    totalOfTheDay: json["totalOfTheDay"],
    totalVenteOfTheDay: json["totalVenteOfTheDay"],
    totalReparationOfTheDay: json["totalReparationOfTheDay"],
    depenseTotal: json["depenseTotal"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "ventes": List<dynamic>.from(ventes.map((x) => x.toJson())),
    "input": List<dynamic>.from(input),
    "totalOfTheDay": totalOfTheDay,
    "totalVenteOfTheDay": totalVenteOfTheDay,
    "totalReparationOfTheDay": totalReparationOfTheDay,
    "depenseTotal": depenseTotal,
    "status": status,
  };

  @override
  String toString() {
    return 'VenteResponse{ventes: $ventes, input: $input, totalOfTheDay: $totalOfTheDay, totalVenteOfTheDay: $totalVenteOfTheDay, totalReparationOfTheDay: $totalReparationOfTheDay, depenseTotal: $depenseTotal, status: $status}';
  }
}

class Vente {
  int id;
  String? designation;
  int nombre;
  int prix;
  dynamic image;
  int? produitId;
  dynamic deletedAt;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  Vente({
    required this.id,
    required this.designation,
    required this.nombre,
    required this.prix,
    required this.image,
    required this.produitId,
    required this.deletedAt,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vente.fromJson(Map<String, dynamic> json) => Vente(
    id: json["id"],
    designation: json["designation"],
    nombre: json["nombre"],
    prix: json["prix"],
    image: json["image"],
    produitId: json["produit_id"],
    deletedAt: json["deleted_at"],
    userId: json["user_id"] ?? 1,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "designation": designation,
    "nombre": nombre,
    "prix": prix,
    "image": image,
    "produit_id": produitId,
    "deleted_at": deletedAt,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  @override
  String toString() {
    return 'Vente{id: $id, designation: $designation, nombre: $nombre, prix: $prix, image: $image, produitId: $produitId, deletedAt: $deletedAt, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
