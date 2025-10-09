import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:get/get.dart';

class ProduitsInfo {
  RxList<Produit>? produits = <Produit>[].obs;
  String? status;

  ProduitsInfo({this.produits, this.status});

  ProduitsInfo.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = produits;
      json['produits'].forEach((p) {
        produits!.add(new Produit.fromJson(p));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.produits != null) {
      data['produits'] = this.produits!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${produits}, Status: ${status}";
  }
}
