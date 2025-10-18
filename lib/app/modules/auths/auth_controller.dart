import 'dart:convert';

import 'package:ciilaabokk/app/core/exceptions/network_exceptions.dart';
import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/repositories/auth_repositories.dart'
    hide logger;
import 'package:ciilaabokk/app/data/services/auth_services.dart' hide logger;
import 'package:ciilaabokk/app/data/services/remote_services.dart' hide logger;
import 'package:ciilaabokk/app/initial_bindings.dart';
import 'package:ciilaabokk/app/modules/login/login_screen.dart' hide logger;
import 'package:ciilaabokk/app/modules/ventes/new_vente/vente_screen.dart'
    hide logger;
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_controller.dart'
    hide logger;
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart'
    hide logger;
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final AuthProvider authProvider = Get.find<AuthProvider>();
  final AuthServices authServices = AuthServices();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  var isPhoneNumberValid = true.obs;
  var isPasswordValid = true.obs;
  var isNameValid = true.obs;

  void login() async {
    logger.i("LoginFormKey: ${loginFormKey}");
    try {
      logger.i("conecting..");
      _isLoading.value = true;
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        String phoneNumber = phoneNumberController.text.trim();
        String password = passwordController.text.trim();

        // Call the post Api method to send data
        var userInfo = await authServices.login(phoneNumber, password);
        logger.i("Response Auth Controller: ${userInfo}");

        phoneNumberController.clear();
        passwordController.clear();

        authProvider.user = userInfo;
        //authProvider.user.token;
        Get.offAll(() => VentesScreen());
        goodMessage("Connexion avec succés");
      }
    } catch (e) {
      errorMessage("Impossible de se connecter");
      logger.w("Error: ${e}");
    } finally {
      _isLoading.value = false;
    }
  }

  void signup() async {
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    try {
      if (signupFormKey.currentState!.validate()) {
        //signupFormKey.currentState!.save();
        logger.i("Signin in signinFormKey : ${signupFormKey}");
        _isLoading.value = true;
        var userRegistred = authServices.signin(name, phoneNumber, password);
        authProvider.userRegister = await userRegistred;
        Get.offAll(() => LoginScreen());
        goodMessage("Succés: Inscription");
      }
    } catch (e) {
      errorMessage("Erreur");
    } finally {
      _isLoading.value = false;
    }
    //validating email and password and checking a static email just for checking

    //var response = remoteServices.signUp(name, phoneNumber, password);
  }

  Future<void> logout() async {
    Get.offAll(() => LoginScreen());
    authProvider.reset();
    // Rebind if need it
    goodMessage("Déconneté");
  }
}
