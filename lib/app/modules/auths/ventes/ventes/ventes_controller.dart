import 'package:ciilaabokk/app/data/models/ventes.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class VentesController extends GetxController {
  var isLoading = true.obs;
  var ventesList = <VenteResponse>[].obs;
  final _authServices = AuthServices();

  @override
  void onInit() {
    super.onInit();
    fetchVentes();
  }

  void fetchVentes() async {
    isLoading(true);
    try {
      // var ventes = await RemoteServices.fetchVentes();
      var ventes = await _authServices.getAllVentes();
      //logger.i("Vente: ${ventes}");
      ventesList.assignAll([ventes]);
      logger.i("Fetched ventes: ${ventesList.toString()}");
    } catch (e) {
      print("Error fetching ventes: $e");
    } finally {
      isLoading(false);
    }
  }
}
