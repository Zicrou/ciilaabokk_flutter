import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/journal_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class JournalController extends GetxController {
  final JournalRepository journalRepository = Get.find<JournalRepository>();
  final isLoading = true.obs;
  final operationsList = <Operation>[].obs;
  final depensesList = <Depenses>[].obs;
  late final String? userId;
  int _latestFetchId = 0;

  @override
  void onInit() {
    super.onInit();
    fetchJournal(userId);
  }

  JournalController() {
    final authProvider = Get.find<AuthProvider>();
    userId = authProvider.user?.user?.id;
  }

  Future<void> fetchJournal([String? coequipier]) async {
    final targetUserId = coequipier ?? userId;
    if (targetUserId == null || targetUserId.isEmpty) {
      isLoading(false);
      Get.snackbar('Erreur', "Identifiant de l'utilisateur introuvable");
      return;
    }

    final fetchId = ++_latestFetchId;
    isLoading(true);
    try {
      final reponse = await journalRepository.fetchJournal(targetUserId);
      if (fetchId != _latestFetchId) {
        return;
      }

      logger.i("Réponse fetchJournal controller: ${reponse.depenses}");
      operationsList.assignAll(reponse.operations);
      depensesList.assignAll(reponse.depenses ?? <Depenses>[]);
      logger.i("Opérations chargées: ${operationsList.length}");
    } catch (error) {
      if (fetchId == _latestFetchId) {
        Get.snackbar('Erreur', error.toString());
      }
    } finally {
      if (fetchId == _latestFetchId) {
        isLoading(false);
      }
    }
  }
}
