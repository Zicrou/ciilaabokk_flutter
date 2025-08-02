import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/ventes.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthServices extends GetxService {
  //final _authProvider = Get.find<AuthProvider>();
  final _authRepositories = Get.find<AuthRepositories>();

  @override
  void onInit() {
    logger.w(
      "Is AuthRepositories registered? ${Get.isRegistered<AuthRepositories>()}",
    );
    _authRepositories;
    super.onInit();
  }

  Future<VenteResponse> getAllVentes() async {
    try {
      // final response = await _dio.get('http://10.0.2.2:8000/api/V1/ventes');
      return await _authRepositories.listVentes();
    } catch (e) {
      throw Exception("Error fetching ventes: $e");
    }
  }

  Future<UserInfo> login(String phone, String password) async {
    logger.w("AuthReppositories: ${_authRepositories}");

    logger.i(
      'AuthService: Logging in with phone: $phone and password: $password',
    );
    return await _authRepositories.login(phone, password);
  }

  // createVente(
  //   String designation,
  //   double prix,
  //   int userId,
  //   int nombre,
  //   int types,
  // ) async {
  //   logger.i(
  //     'AuthService: Creating vente with designation: $designation, prix: $prix, userId: $userId, nombre: $nombre, types: $types',
  //   );

  //   logger.i(
  //     "AuthService: as we don't have the token, we will not pass it to the repository",
  //   );
  //   return await _authRepository.createVente(
  //     designation,
  //     prix,
  //     userId,
  //     nombre,
  //     types,
  //   );
  // }

  // ListVentes() async {
  //   logger.i('AuthService: Fetching list of ventes');
  //   return await _authRepository.listVentes();
  // }
}
