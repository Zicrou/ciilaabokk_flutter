import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProfilsRepositories {
  //final dio = Dio();
  final _authProvider = Get.find<AuthProvider>();
  final _apiProvider = Get.find<ApiProvider>();

  Future<List<User>> fetchMembres() async {
    try {
      final token = _authProvider.authToken;
      logger.i("Token from Authprovider: ${token}");
      final response = await _apiProvider.get('${teamEndpoints}members');
      final list = response['users'] as List;
      logger.i("Team's users repositories: ${list}");
      return list.map((item) => User.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Error fetching membres: $e");
    }
  }

  Future<List<User>> fetchMembress() async {
    final response = await _apiProvider.get('${teamEndpoints}members');
    logger.i("Response fetchMembre: ${response.data['users'] as List}");
    // return;
    // final user = User.fromJson(response.data['users']);
    final List data = response.data['users'] as List;
    logger.i("User repositories :${data}");
    return data.map((item) => User.fromJson(item)).toList();
  }

  // Future<dynamic> addUserToTeam(String phone) async {
  //   try {
  //     logger.i(
  //       'Auth Repositories: login with phone => $phone and password => $password',
  //     );
  //     final response = await _apiProvider.post(
  //       loginEndpoint,
  //       {'phone_number': phone, 'password': password},
  //       //options: Options(headers: {'Content-type': 'application/json'}),
  //     );
  //     if (response == null) {
  //       return response;
  //     }
  //     // logger.w('Login response: $response');
  //     // logger.w('Login response data: $response.data');

  //     // var userRegister = UserRegister();
  //     // userRegister = UserRegister.fromJson((response));
  //     var userInfo = UserInfo();
  //     userInfo = UserInfo.fromJson((response));

  //     if (userInfo.token == null) {
  //       throw Exception("Login failed: token is null in response");
  //     }
  //     _authProvider.isAuthenticated = true;
  //     _authProvider.authToken = userInfo.token!;
  //     // logger.i('authToken: ${_authProvider.authToken}');
  //     // logger.i("userInfo from Repositories: ${userInfo.toString()}");
  //     return userInfo;
  //   } on BadRequestException {
  //     rethrow;
  //   }
  // }

  // Future<dynamic> addUserToTeam(String numberPhone) async {
  //   final userId = authProvider.user.user;
  //   dynamic response = '';
  //   logger.w(userId);
  //   if (userId == null) {
  //     throw Exception("User ID is null — user is not logged in.");
  //   }
  //   var body = {"name": "Team ${userId.name}", "phone_number": numberPhone};
  //   var bodyToJson = jsonEncode(body);
  //   print(bodyToJson);
  //   try {
  //     final token = authProvider.authToken;
  //     logger.i("Token from Authprovider: ${token}");
  //     response = await _dio.post(
  //       'http://10.0.2.2:8000/api/V1/team/add-member',
  //       data: body,
  //       options: Options(
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );

  //     logger.i("Response from remote service: ${response})");
  //     if (response.data['status'] == 404) {
  //       return response.data;
  //     }
  //     logger.i("Response.data from remote service: ${response.data})");
  //     if (response.data['status'] == 201 && response.data != null) {
  //       // Dio automatically parses JSON, so we use response.data
  //       var user = User.fromJson(response.data['user']);
  //       //ventesList.assignAll([ventes]);
  //       logger.i("Response User from Remote Services: ${user.toString()}");
  //       logger.i("User: ${user}");
  //       var message = response.data['message'];
  //       var status = response.data['status'];

  //       return {'user': user, 'message': message, 'status': status};
  //     } else {
  //       throw Exception("User not found");
  //     }
  //   } on DioException {
  //     throw ("Response from dio: ${response}");
  //   } catch (e) {
  //     throw Exception("Error adding User to a team: ${e.toString()}");
  //   }
  // }
}
