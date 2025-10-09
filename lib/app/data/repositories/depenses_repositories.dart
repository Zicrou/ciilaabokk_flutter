import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/depensesInfo.dart';

import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/depenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DepensesRepositories {
  final _apiProvider = Get.find<ApiProvider>();
  final _depensesProvider = Get.find<DepensesProvider>();

  Future createDepense(Map<String, dynamic> json) async {
    try {
      logger.i("Json from Repositories: ${json}");
      final res = await _apiProvider.post(createDepenses, json);
      logger.w('DepensesRepositories: Create depense response: $res');
      return res;
    } on BadRequestException {
      rethrow;
    }
  }

  Future<DepensesInfo> listeDepenses() async {
    final response = await _apiProvider.get(depensesListEndpoint);
    logger.i("Response: ${response}");
    //final ventesResponse = VenteResponse.fromJson(response.data);
    return DepensesInfo.fromJson(response);
  }

  Future updateDepense(int id, Map<String, dynamic> json) async {
    var res;
    try {
      logger.i("Json from Repositories: $updateDepenses$id'");
      res = await _apiProvider.put('$updateDepenses$id', json);
      logger.i('Update Depense response: ${res == null}');
      if (res == null) {
        res = null;
        throw FetchDataException('Update depense failed');
      }
      return res;
    } on FetchDataException catch (e) {
      logger.e("FetchDataException: ${e.message}");
      logger.i('Update Depense response: $res');
      return res = null;
    } on BadRequestException {
      rethrow;
    }
  }

  Future deleteDepenses(int id) async {
    try {
      logger.i("Id from Repositories: ${id}");
      final res = await _apiProvider.delete('$depenseDeleteEndpoint$id');
      logger.i('$depenseDeleteEndpoint$id');
      logger.w('Depenses Repositories: Delete Depense response: $res');
      return res;
    } on BadRequestException {
      rethrow;
    }
  }
}
