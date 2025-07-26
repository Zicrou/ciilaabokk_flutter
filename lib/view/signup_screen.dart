import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:ciilaabokk/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF493AD5),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Obx(
                () => TextField(
                  controller: authController.phoneNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Color(0xFF493aD5)),
                    labelText: "Numéro de téléphone",
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
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
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: authController.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF493aD5)),
                    labelText: "Mot de passe",
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText: authController.isPasswordValid.value
                        ? null
                        : "mot de passe invalide",
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
              Obx(
                () => TextField(
                  controller: authController.confirmPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF493aD5)),
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Color(0xFF493AD5)),
                    errorText: authController.isConfirmPasswordValid.value
                        ? null
                        : "Password do not match",
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
                onPressed: () => authController.signup(),
                child: Text("Sign Up", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF493AD5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.to(LoginScreen()),
                child: Text(
                  "Already have an account ? Sign In",
                  style: TextStyle(color: Color(0xFF493AD5), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
