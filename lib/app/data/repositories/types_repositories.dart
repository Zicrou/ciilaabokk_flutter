import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class TypesRepositories {
  final _apiProvider = Get.find<ApiProvider>();

  Future listTypes() async {
    final response = await _apiProvider.get(typesListEndpoint);
    logger.i(
      "Response from Repositories: ${response['types'].cast<Map<String, dynamic>>()}",
    );
    // logger.i("Check Response ${{response['types'] is Map}}");
    return (response['types'] as List)
        .map((type) => Types.fromJson(type as Map<String, dynamic>))
        .toList();
  }
}
