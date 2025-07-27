import 'package:ciilaabokk/app/core/interceptors/api_interceptors.dart';
import 'package:ciilaabokk/app/data/models/login.dart';
import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LoginController extends GetxController {
  final auth_services = Get.find<AuthServices>();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPhoneNumberValid = true.obs;
  var isPasswordValid = true.obs;
  var isConfirmPasswordValid = true.obs;

  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data or state here
  }

  void login() async {
    //try {
    //isLoading.value = true;
    var login = Login();
    login.phoneNumber = phoneNumberController.text.trim();
    login.password = passwordController.text.trim();
    logger.i("Login data to Json: ${login.toJson()}");
    final response = await auth_services.login(
      login.phoneNumber!,
      login.password!,
    );

    logger.i("Login response: $response");
    //} catch (e) {
    //  logger.e("Error in login method: $e");
    // } finally {
    //  isLoading.value = false;
    // }
  }
}
