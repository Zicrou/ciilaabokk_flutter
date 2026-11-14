// To parse this JSON data, do
//
//     final vente = venteFromJson(jsonString);

import 'dart:convert';

import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:decimal/decimal.dart';

OperationResponse venteFromJson(String str) =>
    OperationResponse.fromJson(json.decode(str));
String venteToJson(Vente data) => json.encode(data.toJson());

class OperationResponse {
  List<Operation> operations;
  List<dynamic> input;
  Decimal totalOfTheDay;
  Decimal totalVenteOfTheDay;
  Decimal totalReparationOfTheDay;
  Decimal depenseTotal;
  String status;

  OperationResponse({
    required this.operations,
    required this.input,
    required this.totalOfTheDay,
    required this.totalVenteOfTheDay,
    required this.totalReparationOfTheDay,
    required this.depenseTotal,
    required this.status,
  });

  factory OperationResponse.fromJson(Map<String, dynamic> json) => OperationResponse(
    operations: List<Operation>.from(json["operations"].map((x) => Operation.fromJson(x))),
    input: json["input"],
    totalOfTheDay: json["totalOfTheDay"],
    totalVenteOfTheDay: json["totalVenteOfTheDay"],
    totalReparationOfTheDay: json["totalReparationOfTheDay"],
    depenseTotal: json["depenseTotal"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "operations": List<dynamic>.from(operations.map((x) => x.toJson())),
    "input": List<dynamic>.from(input),
    "totalOfTheDay": totalOfTheDay,
    "totalVenteOfTheDay": totalVenteOfTheDay,
    "totalReparationOfTheDay": totalReparationOfTheDay,
    "depenseTotal": depenseTotal,
    "status": status,
  };

  @override
  String toString() {
    return 'OperationResponse{operations: $operations, input: $input, totalOfTheDay: $totalOfTheDay, totalVenteOfTheDay: $totalVenteOfTheDay, totalReparationOfTheDay: $totalReparationOfTheDay, depenseTotal: $depenseTotal, status: $status}';
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
  final int userId;
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
    userId: json["user_id"],
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
    return 'Vente to String {id: $id, designation: $designation, nombre: $nombre, prix: $prix, image: $image, produitId: $produitId, deletedAt: $deletedAt, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
