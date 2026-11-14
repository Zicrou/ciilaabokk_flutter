import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class TypesRepositories {
  final _apiProvider = Get.find<ApiProvider>();

  Future listTypes() async {
    final response = await _apiProvider.get(typesEndpoint);
    logger.i(
      "Response from Repositories: ${response['types'].cast<Map<String, dynamic>>()}",
    );

    // The return type is List dynamic
    return (response['types'] as List)
        .map((type) => Types.fromJson(type as Map<String, dynamic>))
        .toList();
  }
}
