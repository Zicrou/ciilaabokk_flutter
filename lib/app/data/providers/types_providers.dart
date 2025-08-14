import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/providers/storage_providers.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

import '../models/user_info.dart';

final logger = Logger();

class TypesProviders extends GetxService {
  final _storageProvider = Get.find<StorageProvider>();
  final _types = Types().obs;
  final _isAuthenticated = false.obs;
  final _authToken = ''.obs;

  Types get types => _types.value;
  set types(Types types) {
    _types.value = types;
    logger.i('userId: ${types}');
  }

  @override
  void onInit() {
    super.onInit();
    _isAuthenticated.value = _storageProvider.authStatus ?? false;
    _authToken.value = _storageProvider.authToken ?? '';
  }
}
