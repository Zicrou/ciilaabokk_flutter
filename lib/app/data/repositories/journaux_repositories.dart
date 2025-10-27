import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/journalResponse.dart';
import 'package:ciilaabokk/app/data/models/vente_info.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class JournauxRepositories {
  final _apiProvider = Get.find<ApiProvider>();
  Future<dynamic> listJournal() async {
    final response = await _apiProvider.get(journauxEndpoints);
    logger.i("Response from Journaux repositories: ${response}");
    //final ventesResponse = VenteResponse.fromJson(response.data);

    return JournalResponse.fromJson(response);
  }

  Future<dynamic> listUserJournal(user) async {
    final endpoint = '${journauxEndpoints}user/${user}';
    logger.i("User Journal Endpoint: ${endpoint}");
    final response = await _apiProvider.get(endpoint);
    logger.i("Response from Journaux repositories: ${response}");
    //final ventesResponse = VenteResponse.fromJson(response.data);

    return JournalResponse.fromJson(response);
  }
}
