import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/models/journalInfo.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:get/get.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:logger/web.dart';

final Logger logger = Logger();
class JournalRepository {
  // JournalRepository({
  //   required OperationsRepository operationsRepository,
  //   required DepensesRepositories depensesRepositories,
  // }) : _operationsRepository = operationsRepository,
  //      _depensesRepositories = depensesRepositories;

  // final OperationsRepository _operationsRepository;
  // final DepensesRepositories _depensesRepositories;
  final _apiProvider = Get.find<ApiProvider>();

  final RxList<Operation> operationListe = <Operation>[].obs;
  final RxList<Depenses> depenseListe = <Depenses>[].obs;

  Future<JournalInfo> fetchJournal(String coequipier) async {
    final results = await _apiProvider.post("$journalEndpoint", {"coequipier": coequipier});
    logger.i("Response journal: $results");
    var journal =  JournalInfo.fromJson(results);
    return journal;
    
  }
}
