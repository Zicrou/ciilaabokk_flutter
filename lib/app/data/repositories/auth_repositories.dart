import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/core/values/endpoints.dart';
import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/user_register.dart';
import 'package:ciilaabokk/app/data/models/operation_info.dart';
import 'package:ciilaabokk/app/data/models/operations_response.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthRepositories {
  //final dio = Dio();
  final _authProvider = Get.find<AuthProvider>();
  final _apiProvider = Get.find<ApiProvider>();

  Future<UserInfo> login(String login, String password) async {
    try {
      logger.i(
        'Auth Repositories: login with login => $login and password => $password',
      );
      final response = await _apiProvider.postN(
        loginEndpoint,
        {'login': login, 'password': password},
        //options: Options(headers: {'Content-type': 'application/json'}),
      );
      if (response == null) {
        return response;
      }
      logger.i("Response from AuthRepositories: $response['team']");
      logger.i("Serializing the response with userinfo");
      var userInfo = UserInfo();
      userInfo = UserInfo.fromJson((response));
      logger.i("Serializing done, ${userInfo.toString()}");

      if (userInfo.token == null) {
        throw Exception("Login failed: token is null in response");
      }
      _authProvider.isAuthenticated = true;
      _authProvider.authToken = userInfo.token!;
      return userInfo;
    } on BadRequestException {
      rethrow;
    }
  }

  Future<UserRegister> signin(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    try {
      logger.i('Auth Repositories: SignUp with name $name email $email phone => $phone and password => $password');
      final response = await _apiProvider.postN(registerEndPoint, {'name': name, 'email': email, 'phone': phone, 'password': password},);
      logger.i("Response from AuthRepository: $response");
      // logger.w('Login response: $response');
      // logger.w('Login response data: $response.data');

      // var userRegister = UserRegister();
      // userRegister = UserRegister.fromJson((response));
      var userRegister = UserRegister();
      userRegister = UserRegister.fromJson((response));

      if (userRegister.token == null) {
        throw Exception("SignUp failed: token is null in response");
      }
      _authProvider.isAuthenticated = true;
      _authProvider.authToken = userRegister.token!;
      logger.i('authToken: ${_authProvider.authToken}');
      logger.i("userRegister from Repositories: ${userRegister.toString()}");
      return userRegister;
    } on BadRequestException {
      rethrow;
    }
  }

  Future<dynamic> signout() async {
    try {
      logger.i('Auth Repositories: signing out ${_authProvider.authToken}');
      final response = await _apiProvider.post(
        signOutEndpoint,
        Options(
          headers: {'Authorization': 'Bearer ${_authProvider.authToken}'},
        ),
      );
      logger.i("Response from Auth Repositories: ${response}");
      _authProvider.reset();
      if (!_authProvider.isAuthenticated) {
        return true;
      } else {
        return false;
      }
    } on BadRequestException {
      rethrow;
    }
  }

  // Future createVente(Map<String, dynamic> json) async {
  //   try {
  //     logger.i("Json from Repositories: ${json}");
  //     final res = await _apiProvider.post(createVenteEndpoint, json);
  //     logger.w('AuthRepositories: Create Vente response: $res');
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

  // Future<VenteInfo> listVentes() async {
  //   final response = await _apiProvider.getVentes();
  //   //final ventesResponse = VenteResponse.fromJson(response.data);
  //   return VenteInfo.fromJson(response.data);
  // }
}
