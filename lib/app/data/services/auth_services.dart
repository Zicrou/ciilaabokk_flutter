import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthServices extends GetxService {
  final _authProvider = Get.find<AuthProvider>();
  final _authRepository = Get.find<AuthRepositories>();

  login(String phone, String password) async {
    logger.i('Logging in with phone: $phone');
    return await _authRepository.login(phone, password);
  }
}
