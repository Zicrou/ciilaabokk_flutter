import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/user_register.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthRepositories {
  final _authProvider = Get.find<AuthProvider>();
  final _apiProvider = Get.find<ApiProvider>();

  Future<dynamic> login(String phone, String password) async {
    try {
      logger.i('Logging in with phone: $phone');
      final res = await _apiProvider.post(loginEndpoint, {
        'phone_number': phone.toLowerCase().trim(),
        'password': password,
      });
      logger.w(res);

      var userRegister = UserRegister();
      userRegister = UserRegister.fromJson((res));

      _authProvider.isAuthenticated = true;
      _authProvider.authToken = userRegister.token!;
      logger.i('authToken: ${_authProvider.authToken}');
      return res;
    } on BadRequestException {
      rethrow;
    }
  }
}
