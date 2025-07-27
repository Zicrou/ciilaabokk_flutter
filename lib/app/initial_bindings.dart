import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/providers/storage_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_controller.dart';
import 'package:get/get.dart';

class AppInitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageProvider>(StorageProvider(), permanent: true);
    Get.put<AuthProvider>(AuthProvider(), permanent: true);
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut(() => AuthRepositories());
    Get.put<AuthServices>(AuthServices());
    Get.lazyPut(() => LoginController());
    // Add other dependencies as needed
  }
}
