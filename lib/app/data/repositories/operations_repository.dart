import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/operation_info.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class OperationsRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future createOperation(Map<String, dynamic> json) async {
    try {
      logger.i("Json from Repositories: ${json}");
      final res = await _apiProvider.post(operationsEndpoint, json);
      logger.w(
        'Opértion Repositories: Création d\'opération, response success: ${res}', //res['message']
      );
      return res;
    } on BadRequestException {
      rethrow;
    }
  }

  Future<dynamic> updateOperation(int id, Map<String, dynamic> json) async {
    try {
      logger.i("Id from Repositories: $id, endPoint: $operationsEndpoint$id");
      final res = await _apiProvider.put('$operationsEndpoint$id', json);
      logger.i('$operationsEndpoint$id');
      logger.w('OperationRepositories modification Opération, response: $res');
      return res;
    } on FetchDataException {
      errorMessage("Erreur");
    } on BadRequestException {
      rethrow;
    }
  }

  Future deleteOperation(String id) async {
    try {
      logger.i("Id from Repositories: ${id}, endPoint: $operationsEndpoint$id");
      final res = await _apiProvider.delete('$operationsEndpoint$id');
      logger.i('$operationsEndpoint$id');
      logger.w('OperationRepositories: Suppression de l\'opération, response: $res');
      return res;
    } on BadRequestException {
      rethrow;
    }
  }

  // Future<List<dynamic>> fetchVentes() async {
  //   try {
  //     logger.i("Auth Repositories: Fetching list of ventes");
  //     final res = await _apiProvider.get(venteListEndpoint);
  //     logger.w('List Ventes response: $res');
  //     return res;
  //   } on BadRequestException {
  //     rethrow;
  //   }
  // }

  // Future<List<dynamic>> fetchVentes() async {
  //   final response = await _authProvider.getVentes(); // Calls provider
  //   if (response.statusCode == 200) {
  //     // Assuming response.body is a JSON array
  //     return response.body;
  //   } else {
  //     throw Exception('Failed to fetch ventes');
  //   }
  // }

  Future<OperationInfo> listOperations() async {
    final response = await _apiProvider.get("$operationsEndpoint");
    logger.i("Response: $response");
    var listOperation =  OperationInfo.fromJson(response);
    logger.i("La liste des opérations; ${listOperation.toString()}");
    return listOperation;
  }
}
