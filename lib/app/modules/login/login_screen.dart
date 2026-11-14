import 'package:ciilaabokk/app/data/providers/auth_providers.dart';
import 'package:ciilaabokk/app/modules/operations/operations/operations_screen.dart';
import 'package:ciilaabokk/app/modules/auths/auth_controller.dart';
import 'package:ciilaabokk/app/modules/sign%20up/signup_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LoginScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: controller.loginFormKey,
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
                TextFormField(
                    validator: (value) {
                       final email = value?.trim() ?? '';
                      if (email.isEmpty) {
                        return "Svp veuillez remplir le champs";
                      }
                      if (!RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(email)) {
                        return "Veuillez saisir une adresse email valide";
                      }
                      return null;
                    },
                    controller: controller.loginController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 10, 151, 217),
                      ),
                      labelText: "Login",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      errorText: controller.isLoginValid.value
                          ? null
                          : "Login invalide",
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
                    keyboardType: TextInputType.text,
                  ),
                
                SizedBox(height: 20),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Svp veuillez remplir le champs";
                      }
                      return null;
                    },
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      labelText: "Mot de passe",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 173, 253),
                      ),
                      errorText: controller.isPasswordValid.value
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
                // ),
                SizedBox(height: 20),
                Obx(
                  () => controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 0, 173, 253),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () => controller.login(),
                          child: Text(
                            "Se connecter",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 173, 253),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                ),

                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.offAll(SignupScreen()),
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
      ),
    );
  }
}
