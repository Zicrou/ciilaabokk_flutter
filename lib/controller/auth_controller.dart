import 'dart:convert';

import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart'
    hide logger;
import 'package:ciilaabokk/app/data/services/auth_services.dart' hide logger;
import 'package:ciilaabokk/app/data/services/remote_services.dart' hide logger;
import 'package:ciilaabokk/app/modules/auths/login/login_screen.dart'
    hide logger;
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart'
    hide logger;
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart'
    hide logger;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class AuthController extends GetxController {
  final AuthProvider authProvider = Get.find<AuthProvider>();
  final AuthServices authServices = AuthServices();
  final RemoteServices remoteServices = RemoteServices();
  final dio = Dio();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  var isPhoneNumberValid = true.obs;
  var isPasswordValid = true.obs;
  var isNameValid = true.obs;

  void login() async {
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();

    if (phoneNumber.isEmpty || !phoneNumberController.text.isPhoneNumber) {
      isPhoneNumberValid.value = false;
    } else {
      isPhoneNumberValid.value = true;
    }

    if (password.isEmpty || password.length < 6) {
      isPasswordValid.value = false;
      return;
    } else {
      isPasswordValid.value = true;
    }

    //validating email and password and checking a static email just for checking
    if (isPhoneNumberValid.value && isPasswordValid.value) {
      // Call the post Api method to send data
      var userInfo = await authServices.login(phoneNumber, password);
      logger.i("Response Auth Controller: ${userInfo}");
      phoneNumberController.clear();
      passwordController.clear();

      authProvider.user = userInfo;
      Get.offAll(() => VentesScreen());
      Get.snackbar(
        "Success",
        "Logged In Successfully",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        "Error",
        "Logged In Failed",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  void signup() async {
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();

    if (phoneNumber.isEmpty || !phoneNumberController.text.isPhoneNumber) {
      isPhoneNumberValid.value = false;
    } else {
      isPhoneNumberValid.value = true;
    }

    if (password.isEmpty || password.length < 6) {
      isPasswordValid.value = false;
    }

    if (name.isEmpty || nameController.text.isPhoneNumber) {
      isNameValid.value = false;
    }
    //validating email and password and checking a static email just for checking
    if (isPhoneNumberValid.value &&
        isPasswordValid.value &&
        isNameValid.value) {
      phoneNumberController.clear();
      passwordController.clear();
      nameController.clear();
      logger.i(
        "Registering Name: ${name}, Phone: ${phoneNumber}, Password: ${password}",
      );
      //var response = remoteServices.signUp(name, phoneNumber, password);
      var userRegistred = authServices.signin(name, phoneNumber, password);
      logger.i("AuthController User Registered ${userRegistred.toString()}");
      authProvider.userRegister = await userRegistred;
      Get.offAll(() => LoginScreen());
      Get.snackbar(
        "Success",
        "Signed In Successfully",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar(
        "Error",
        "Signed In Failed",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  Future<void> logout() async {
    logger.i("Signing out");
    final token = authProvider.authToken;
    logger.i("Token from Authprovider: ${token}");
    if (authProvider.isAuthenticated == false || token.isEmpty) {
      logger.e("No token found — user might already be logged out.");
      Get.offAll(() => LoginScreen());
    }

    try {
      //final response = await authServices.signout();
      final response = await dio.post(
        'http://10.0.2.2:8000/api/V1/logout',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      logger.i("Response ${response.data['loggedOut']}");
      var res = response.data['loggedOut'];
      if (res == true) {
        authProvider.reset();
        Get.delete<AuthRepositories>(force: true);
        // Rebind if need it
        Get.put(AuthRepositories());
        Get.put(AuthProvider());
        Get.offAll(() => LoginScreen());
        Get.snackbar(
          "Déconnexion",
          "Vous êtes déconnecté(e).",
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
      } else {
        Get.to(VentesScreen());
      }
      logger.i("Logout response: ${response}");
    } catch (e, stacktrace) {
      logger.e("Logout failed: $e");
      logger.e("Stacktrace: $stacktrace");
      Get.snackbar(
        "Erreur",
        "Échec de la déconnexion",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
