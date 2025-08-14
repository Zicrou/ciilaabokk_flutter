import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/depensesInfo.dart';

import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/depenses_provider.dart';
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
}
