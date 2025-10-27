import 'package:ciilaabokk/app/data/models/journalResponse.dart';
import 'package:ciilaabokk/app/data/repositories/journaux_repositories.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class JournalMembresUserController extends GetxController {
  final JournauxRepositories _journauxRepositories = Get.put(
    JournauxRepositories(),
  );

  var isLoading = false.obs;
  var journal = <String, JournalDay>{}.obs; // Map<Date, JournalDay>
  var user;
  @override
  void onInit() {
    super.onInit();
    // _loadProduits();
    final args = Get.arguments;
    if (args != null && args['user'] != null) {
      logger.i("User from Journal init: ${user}");
      user = args['user'];
    } else {
      errorMessage("User not found");
      return;
    }
    fetchUserJournal();
  }

  Future<void> fetchUserJournal() async {
    try {
      isLoading(true);

      final response = await _journauxRepositories.listUserJournal(user);
      // response = await _journauxRepositories.listUserJournal(user);
      logger.i("Response from Controller: ${response}");
      journal.value = response.journal;
      logger.i("Journal: ${journal}");
    } catch (e) {
      Get.snackbar("Erreur", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Exemple : récupérer le total des ventes d’un jour
  int getTotalVentes(String date) {
    return journal[date]?.ventes.totalVentes ?? 0;
  }

  // Exemple : récupérer le total des dépenses d’un jour
  int getTotalDepenses(String date) {
    return journal[date]?.depenses.totalDepenses ?? 0;
  }
}
