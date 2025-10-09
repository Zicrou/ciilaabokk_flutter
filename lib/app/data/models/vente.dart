import 'dart:convert';

import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:get/get.dart';

Vente venteFromJson(String str) => Vente.fromJson(json.decode(str));

class Vente {
  int? id;
  String? designation;
  int? nombre;
  int? prix;
  String? image;
  dynamic produit;
  dynamic deletedAt;
  int? userId;
  String? createdAt;
  String? updatedAt;
  dynamic types;
  //RxList<Types> types = <Types>[].obs;

  Vente({
    this.id,
    this.designation,
    this.nombre,
    this.prix,
    this.image,
    this.produit,
    this.deletedAt,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.types,
  });

  Vente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designation = json['designation'];
    nombre = json['nombre'];
    prix = json['prix']; //!= null ? (json['prix'] as num).toDouble() : 0.0;
    image = json['image'];
    produit = json['produit'] != null
        ? Produit.fromJson(json['produit'])
        : null;
    deletedAt = json['deleted_at'];
    userId = json['user_id'];
    types = json['types'] != null
        ? Types.fromJson(json['types'])
        : null; //Types.fromJson(json['types']);
    // logger.w("Types: ${types}");
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['designation'] = this.designation;
    data['nombre'] = this.nombre;
    data['prix'] = this.prix;
    // data['image'] = this.image;
    data['produit_id'] = this.produit;
    // data['deleted_at'] = this.deletedAt;
    data['user_id'] = this.userId;
    logger.i("Types from toJson: ${types}");
    data['type_id'] = this.types; // Assuming types is a single object
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Vente{id: $id, designation: $designation, nombre: $nombre, prix: $prix, image: $image, produitId: ${produit}, Type: ${types}, deletedAt: $deletedAt, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
