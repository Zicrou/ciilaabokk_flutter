import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/vente.dart' show Vente;
import 'package:ciilaabokk/app/data/repositories/types_repositories.dart';
import 'package:ciilaabokk/app/data/repositories/ventes_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class TypesController extends GetxController {
  var isLoading = true.obs;
  var typesList = <Types>[].obs;
  var selectedType = Rx<Types?>(null);
  final _typesRepository = Get.find<TypesRepositories>();

  @override
  void onInit() {
    super.onInit();
    fetchTypes();
  }

  Future fetchTypes() async {
    isLoading(true);
    try {
      // var ventes = await RemoteServices.fetchVentes();
      typesList.value = await _typesRepository.listTypes();
      logger.i("Type from TypesController: ${typesList}");
      return typesList;

      // if (vente != null && vente.types != null) {
      //   final typeMatch = typesList.firstWhereOrNull(
      //     (t) => t.name == vente.types?.name,
      //   );
      //   selectedType.value = typeMatch;
      // }
    } catch (e) {
      print("Error fetching types: $e");
      throw ("Error fetching types: $e");
    } finally {
      isLoading(false);
    }
  }
}
