import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/membre.dart';
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

  Future<List<Membres>> fetchMembres() async {
    try {
      final token = _authProvider.authToken;
      logger.i("Token from Authprovider: ${token}");
      final response = await _apiProvider.get('${teamEndpoints}members');
      final list = response['users'] as List;
      logger.i("Team's users repositories: ${list}");
      return list.map((item) => Membres.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Error fetching membres: $e");
    }
  }

  Future<dynamic> addUserToTeam(Map<String, dynamic> json) async {
    final user = _authProvider.user;

    logger.w(user);
    if (user == null) {
      throw Exception("User ID is null — user is not logged in.");
    }

    try {
      final token = _authProvider.authToken;
      logger.i("Token from Authprovider: ${token}");
      final response = await _apiProvider.post(
        "${teamEndpoints}add-member",
        json,
      );
      logger.i("Response from profils repositories: ${response})");
      if (response['status'] == 404) {
        return response;
      }

      logger.i("Response.data from profils repositories: ${response['user']})");
      if (response['status'] == 201 && response['user'] != null) {
        // final list = response['users'] as List;
        var user = Membres.fromJson(response['user']);
        var message = response['message'];
        var status = response['status'];
        // logger.i("data user: {$user}, message: ${message}, status: ${status}");
        return {'user': user, 'message': message, 'status': status};
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error adding User to a team: ${e.toString()}");
    }
  }

  Future<List<Membres>> deleteMembre(id) async {
    try {
      final token = _authProvider.authToken;
      // final user = authProvider.user.user;
      logger.i("Token from Authprovider: ${token}");

      var response = await _apiProvider.delete('${teamEndpoints}members/${id}');
      logger.i("Response from profils repositories: ${response}");
      if (response['status'] == 200 && response['users'] != null) {
        final list = response['users'] as List;
        List<Membres> users = list.map((e) => Membres.fromJson(e)).toList();
        logger.i("user: ${users}");
        return users;
      }
      throw "Erreur de suppression";
    } catch (e) {
      // Ensure the function doesn't complete normally without returning a value.
      throw Exception("Error removing User from a team: $e");
    }
  }
}
