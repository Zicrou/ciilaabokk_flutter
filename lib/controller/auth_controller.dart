import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPhoneNumberValid = true.obs;
  var isPasswordValid = true.obs;
  var isConfirmPasswordValid = true.obs;

  void login() {
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
    if (isPhoneNumberValid.value &&
        isPasswordValid.value &&
        phoneNumberController.text == "771234567") {
      phoneNumberController.clear();
      passwordController.clear();
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
