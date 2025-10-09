import 'package:ciilaabokk/app/data/models/journalResponse.dart';
import 'package:ciilaabokk/app/data/repositories/journaux_repositories.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

@override
void onInit() {
  //fetchVentes();
  // fetchJournal();
}

class JournalController extends GetxController {
  final JournauxRepositories _journauxRepositories = Get.put(
    JournauxRepositories(),
  );
  var isLoading = false.obs;
  var journal = <String, JournalDay>{}.obs; // Map<Date, JournalDay>

  // Récupérer le journal depuis l’API
  Future<void> fetchJournal() async {
    try {
      isLoading(true);

      final response = await _journauxRepositories.listJournal();
      logger.i("Response from Controller: ${response}");
      // final journalResponse = JournalResponse.fromJson(response.data);
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
