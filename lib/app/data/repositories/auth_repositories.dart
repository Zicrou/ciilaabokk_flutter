import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/ventes.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthRepositories {
  final dio = Dio();
  final _authProvider = Get.find<AuthProvider>();
  final _apiProvider = Get.find<ApiProvider>();

  Future<UserInfo> login(String phone, String password) async {
    try {
      logger.i(
        'Auth Repositories: login with phone => $phone and password => $password',
      );
      final response = await _apiProvider.post(
        loginEndpoint,
        {'phone_number': phone, 'password': password},
        //options: Options(headers: {'Content-type': 'application/json'}),
      );
      // logger.w('Login response: $response');
      // logger.w('Login response data: $response.data');

      // var userRegister = UserRegister();
      // userRegister = UserRegister.fromJson((response));
      var userInfo = UserInfo();
      userInfo = UserInfo.fromJson((response));

      if (userInfo.token == null) {
        throw Exception("Login failed: token is null in response");
      }
      _authProvider.isAuthenticated = true;
      _authProvider.authToken = userInfo.token!;
      // logger.i('authToken: ${_authProvider.authToken}');
      // logger.i("userInfo from Repositories: ${userInfo.toString()}");
      return userInfo;
    } on BadRequestException {
      rethrow;
    }
  }

  // Future<dynamic> createVente(
  //   String designation,
  //   double prix,
  //   int userId,
  //   int nombre,
  //   int types,
  // ) async {
  //   try {
  //     logger.i(
  //       'Auth Repositories: Creating vente with designation: $designation, prix: $prix, userId: $userId, nombre: $nombre, types: $types',
  //     );
  //     final res = await _apiProvider.post(createVenteEndpoint, {
  //       'designation': designation,
  //       'prix': prix,
  //       'user_id': userId,
  //       'nombre': nombre,
  //       'types': types,
  //     });
  //     logger.w('Create Vente response: $res');
  //     return res;
  //   } on BadRequestException {
  //     rethrow;
  //   }
  // }

  // Future<List<dynamic>> fetchVentes() async {
  //   try {
  //     logger.i("Auth Repositories: Fetching list of ventes");
  //     final res = await _apiProvider.get(venteListEndpoint);
  //     logger.w('List Ventes response: $res');
  //     return res;
  //   } on BadRequestException {
  //     rethrow;
  //   }
  // }

  // Future<List<dynamic>> fetchVentes() async {
  //   final response = await _authProvider.getVentes(); // Calls provider
  //   if (response.statusCode == 200) {
  //     // Assuming response.body is a JSON array
  //     return response.body;
  //   } else {
  //     throw Exception('Failed to fetch ventes');
  //   }
  // }

  Future<VenteResponse> listVentes() async {
    final response = await _apiProvider.getVentes();
    //final ventesResponse = VenteResponse.fromJson(response.data);
    return VenteResponse.fromJson(response.data);
  }
}
