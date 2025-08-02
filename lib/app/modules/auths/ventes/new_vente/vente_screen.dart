import 'package:ciilaabokk/app/modules/auths/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/auths/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/controller/auth_controller.dart';
import 'package:ciilaabokk/app/modules/auths/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenteScreen extends StatelessWidget {
  final VenteController venteController = Get.put(VenteController());

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
                "Vente",
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
                  controller: venteController.designation,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.label,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Désignation",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    errorText: venteController.isDesignationValid.value
                        ? null
                        : "Désignation invalide",
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
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: venteController.prix,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Prix",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    errorText: venteController.isPrixValid.value
                        ? null
                        : "Prix invalide",
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
                  obscureText: false,
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: venteController.nombre,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Nombre",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    errorText: venteController.isNombreValid.value
                        ? null
                        : "Nombre invalide",
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
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: venteController.types,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.category,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Types",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    errorText: venteController.isNombreValid.value
                        ? null
                        : "Type invalide",
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
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => {}, //  venteController.createVente(),
                child: Text("Créer vente", style: TextStyle(fontSize: 18)),
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
                onPressed: () => Get.to(() => VentesScreen()),
                child: Text(
                  "Voir les ventes",
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
