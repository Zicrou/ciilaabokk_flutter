import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/repositories/journal_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class JournalController extends GetxController {
  final JournalRepository journalRepository = Get.find<JournalRepository>();
  final isLoading = true.obs;
  final operationsList = <Operation>[].obs;
  final depensesList = <Depenses>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJournal();
  }

  Future<void> fetchJournal() async {
    isLoading(true);
    try {
      final reponse = await journalRepository.fetchJournal();
      logger.i("Réponse fetchJournal controller: ${reponse.depenses}");
      operationsList.assignAll(reponse.operations);
      depensesList.assignAll(reponse.depenses ?? <Depenses>[]);
      logger.i("Opértion liste: ${operationsList[0]}");
    } catch (error) {
      Get.snackbar('Erreur', error.toString());
    } finally {
      isLoading(false);
    }
  }
}
