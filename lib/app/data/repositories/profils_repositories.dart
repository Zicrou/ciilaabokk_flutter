import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/demandesEnvoye.dart';
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
  

  Future<dynamic> fetchMembres() async {
    try {
      final token = _authProvider.authToken;
      logger.i("Token from Authprovider: ${token}");
      final reponse = await _apiProvider.get('$teamEndpoints');
      logger.i("Reponse Profil repository: $reponse");
      logger.i("Reponse Profil repository reponse[liste_membres]: ${reponse['liste_membres']}");

      final listMembre = reponse['liste_membres'] as List;
      logger.i("Team's users repositories: ${listMembre}");
      var membres = listMembre.map((item) => Membres.fromJson(item)).toList();
      logger.i("Team's users repositories fromJson: ${listMembre}");
      
      final listDemandesEnvoye = reponse['demandes_envoyes'] as List;
      logger.i("Profil repository demande envoyé: ${listDemandesEnvoye}");
      var demandesEnvoyes = listDemandesEnvoye.map((item) => DemandesEnvoye.fromJson(item)).toList();
      logger.i("Profil repository demande envoyé fromJson: ${demandesEnvoyes}");

      final listDemandesRecus = reponse['demandes_recus'] as List;
      logger.i("Profil repository demande recus: ${listDemandesRecus}");
      var demandesRecus = listDemandesRecus.map((item) => DemandesEnvoye.fromJson(item)).toList();
      logger.i("Profil repository demande recus fromJson: ${demandesRecus.toString()}");

      return {"membres: $membres", "demandesEnvoyes: $demandesEnvoyes", "demandesRecu: $demandesRecus"};
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
        "${teamEndpoints}invite",
        json,
      );
      logger.i("Response from profils repositories: ${response})");
      if (response['status'] == 404) {
        return response;
      }

      logger.i("Response.data from profils repositories: ${response['user']})");
      if (response['success'] == true) {
        // final list = response['users'] as List;
        var message = response['message'];
        var success = response['success'];
        // logger.i("data user: {$user}, message: ${message}, status: ${status}");
        return { 'message': message, 'success': success};
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error adding User to a team: ${e.toString()}");
    }
  }

  Future<dynamic> deleteMembre(id) async {
    try {
      var idMembre = id;
      final token = _authProvider.authToken;
      // final user = authProvider.user.user;
      logger.i("Token from Authprovider: ${token}");
      logger.i("Team endpoint et id user: $teamEndpoints$id");
      var reponse = await _apiProvider.delete('$teamEndpoints$idMembre');
      logger.i("Reponse from profils repositories DELETE: ${reponse}");
      if (reponse['success'] == true) {
        return reponse;
      }
      throw "Erreur de suppression";
    } catch (e) {
      // Ensure the function doesn't complete normally without returning a value.
      throw Exception("Error removing User from a team: $e");
    }
  }
}
