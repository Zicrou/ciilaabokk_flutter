import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/depensesInfo.dart';
import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/produitsInfo.dart';

import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/depenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProduitsRepositories {
  final _apiProvider = Get.find<ApiProvider>();

  Future<ProduitsInfo> listProduits() async {
    final response = await _apiProvider.get(produitsEndpoint);
    logger.i("Response: ${response}");
    //final ventesResponse = VenteResponse.fromJson(response.data);

    return ProduitsInfo.fromJson(response);
  }

  Future<Produit> listProduitsSupAZero() async {
    final response = await _apiProvider.get(produitSupAZeroEndpoint);
    logger.i("Response from Produits repositories supeAzero: ${response}");
    //final ventesResponse = VenteResponse.fromJson(response.data);

    return Produit.fromJson(response);
  }

  Future createProduits(Map<String, dynamic> json) async {
    try {
      logger.i("Json from Repositories: ${json}");
      final res = await _apiProvider.post(produitsEndpoint, json);
      logger.w('DepensesRepositories: Create depense response: $res');
      return res;
    } on BadRequestException {
      rethrow;
    }
  }

  Future createProduitsWithImage(dynamic formData) async {
    try {
      // logger.i("Json from Repositories: ${json}");
      final res = await _apiProvider.post(produitsEndpoint, formData);
      logger.w('DepensesRepositories: Create depense response: $res');
      return res;
    } on BadRequestException {
      rethrow;
    }
  }

  Future<Produit> getProduit(id) async {
    final response = await _apiProvider.get('$produitsEndpoint$id');
    logger.i("Response: ${response['produit']}");

    return Produit.fromJson(response['produit']);
  }

  Future updateProduit(int id, Map<String, dynamic> json) async {
    var res;
    try {
      logger.i("Json from Repositories: $produitsEndpoint$id'");
      res = await _apiProvider.put('$produitsEndpoint$id', json);
      logger.i('Update Produit response: $res.StatusCode');
      if (res == null) {
        res = null;
        throw FetchDataException('Update produit failed');
      }
      return res;
    } on FetchDataException catch (e) {
      logger.e("FetchDataException: ${e.message}");
      logger.i('Update Produit response: $res');
      return res = null;
    } on BadRequestException {
      rethrow;
    }
  }

  Future deleteProduits(int id_produit) async {
    try {
      var idProduit = int.parse(id_produit.toString());
      logger.i("Id from Repositories: ${idProduit}");
      final res = await _apiProvider.delete('$produitsEndpoint$idProduit');
      logger.i('$produitsEndpoint$idProduit');
      logger.w(
        "Produits Repositories: Delete Produit response: ${res['errMessage']}",
      );
      return res;
    } on BadRequestException {
      rethrow;
    }
  }
}
