import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:ciilaabokk/view/signup_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LoginScreen extends StatelessWidget {
  AuthController authController = AuthController();
  // autif (userInfo != null) {
  //     Get.offAll(() => VentesScreen());
  //     Get.snackbar(
  //       "Success",
  //       "You are already logged in",
  //       colorText: Colors.white,
  //       backgroundColor: Colors.green,
  //     );
  //   }hContr

  void checkLoginStatus() async {
    final storage = Get.find<AuthProvider>();
    final token = await storage.authToken;
    logger.i("token: ${token}");
    if (token.isNotEmpty || storage.isAuthenticated == true) {
      Get.to(() => VentesScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 173, 253),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Obx(
                () => TextField(
                  controller: authController.phoneNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 10, 151, 217),
                    ),
                    labelText: "Numéro de téléphone",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    errorText: authController.isPhoneNumberValid.value
                        ? null
                        : "Numéro de téléphone invalide",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: authController.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Mot de passe",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    errorText: authController.isPasswordValid.value
                        ? null
                        : "Mot de passe invalide",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => authController.login(),
                child: Text("Se connecter", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 173, 253),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.to(SignupScreen()),
                child: Text(
                  "Créer un compte",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 173, 253),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
