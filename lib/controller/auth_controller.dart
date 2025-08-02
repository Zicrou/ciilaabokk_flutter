import 'dart:convert';

import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart' hide logger;
import 'package:ciilaabokk/app/data/services/remote_services.dart' hide logger;
import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_screen.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_controller.dart'
    hide logger;
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart'
    hide logger;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class AuthController extends GetxController {
  final AuthProvider authProvider = Get.find<AuthProvider>();
  final AuthServices authServices = AuthServices();
  final dio = Dio();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPhoneNumberValid = true.obs;
  var isPasswordValid = true.obs;
  var isConfirmPasswordValid = true.obs;

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
      // phoneNumberController.clear();
      // passwordController.clear();

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

  void signup() {
    String phoneNumber = phoneNumberController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmPasswordController.text.trim();

    if (phoneNumber.isEmpty || !phoneNumberController.text.isPhoneNumber) {
      isPhoneNumberValid.value = false;
    } else {
      isPhoneNumberValid.value = true;
    }

    if (password.isEmpty || password.length < 6) {
      isPasswordValid.value = false;
    }
    if (confirmpassword != password) {
      isConfirmPasswordValid.value = false;
    } else {
      isConfirmPasswordValid.value = true;
    }

    //validating email and password and checking a static email just for checking
    if (isPhoneNumberValid.value &&
        isPasswordValid.value &&
        isConfirmPasswordValid.value) {
      phoneNumberController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
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
}
