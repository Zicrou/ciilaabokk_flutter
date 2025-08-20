import 'package:ciilaabokk/app/data/models/produits.dart';
import 'package:get/get.dart';

class ProduitsInfo {
  RxList<Produits>? produits = <Produits>[].obs;
  String? status;

  ProduitsInfo({this.produits, this.status});

  ProduitsInfo.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = produits;
      json['produits'].forEach((p) {
        produits!.add(new Produits.fromJson(p));
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
}
