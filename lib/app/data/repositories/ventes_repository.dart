import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class VentesRepository {
  final _apiProvider = Get.find<ApiProvider>();

  Future createVente(Map<String, dynamic> json) async {
    try {
      logger.i("Json from Repositories: ${json}");
      final res = await _apiProvider.post(createVenteEndpoint, json);
      logger.w(
        'AuthRepositories: Create Vente response message: ${res}', //res['message']
      );
      return res;
    } on BadRequestException {
      rethrow;
    }
  }

  Future<dynamic> updateVente(int id, Map<String, dynamic> json) async {
    try {
      logger.i("Id from Repositories: ${id}");
      final res = await _apiProvider.put('$venteUpdateEndpoint$id', json);
      logger.i('$venteUpdateEndpoint$id');
      logger.w('AuthRepositories Update Vente response: $res');
      return res;
    } on FetchDataException {
      errorMessage("Erreur");
    } on BadRequestException {
      rethrow;
    }
  }

  Future deleteVente(int id) async {
    try {
      logger.i("Id from Repositories: ${id}");
      final res = await _apiProvider.delete('$venteDeleteEndpoint$id');
      logger.i('$venteDeleteEndpoint$id');
      logger.w('AuthRepositories: Delete Vente response: $res');
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

  Future<VenteInfo> listVentes() async {
    final response = await _apiProvider.get(venteListEndpoint);
    logger.i("Response: ${response}");
    //final ventesResponse = VenteResponse.fromJson(response.data);
    return VenteInfo.fromJson(response);
  }
}
