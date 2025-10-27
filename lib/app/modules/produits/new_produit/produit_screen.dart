import 'dart:convert';
import 'dart:io';

import 'package:ciilaabokk/app/data/models/produit.dart';
import 'package:ciilaabokk/app/data/models/types.dart';
import 'package:ciilaabokk/app/data/models/vente.dart';
import 'package:ciilaabokk/app/modules/produits/new_produit/produit_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_controller.dart';
import 'package:ciilaabokk/app/modules/produits/produits/produits_screen.dart';
import 'package:ciilaabokk/app/modules/types/types_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/new_vente/vente_controller.dart';
import 'package:ciilaabokk/app/modules/ventes/ventes/ventes_screen.dart';
import 'package:ciilaabokk/app/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// ignore: must_be_immutable
class ProduitScreen extends StatelessWidget {
  final ProduitController controller = Get.put(ProduitController());
  final Produit produit = Get.arguments ?? Produit();
  var stl = ''.obs;

  var title = "Nouveau Produit";
  @override
  Widget build(BuildContext context) {
    if (produit.id != null && produit is Produit) {
      title = "Modifier Produit";
      controller.designation.text = produit.designation!;
      controller.montant.text = produit.montant.toString();
      controller.nombre.text = produit.nombre.toString();
      controller.selectedImage.value = produit.image != null
          ? File(produit.image!) // ✅ convert path → File
          : null;
      // final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      // if (produit.image != null) {
      //   selectedImage = File(pickedFile.path); // ✅ convert path → File
      // }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'avenir',
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 0, 173, 253),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: produit.id != null
                ? controller.updateProduitKeyForm
                : controller.createProduitKeyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Produit",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 173, 253),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                // Obx(() {
                // final image = controller.selectedImage.value;
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: produit.image != null
                      ? Image.network(
                          produit.image!,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      : const Center(child: Text("Pas d'image")),
                ),
                // }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: controller.pickImageFromGallery,
                      icon: const Icon(Icons.photo),
                      label: const Text("Gallery"),
                    ),
                    ElevatedButton.icon(
                      onPressed: controller.pickImageFromCamera,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Camera"),
                    ),
                    IconButton(
                      onPressed: controller.clearImage,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.designation,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.label,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),

                    labelText: "Désignation",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: controller.isDesignationValid.value
                    //     ? null
                    //     : "Désignation invalide",
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
                  controller: controller.montant,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Nombres uniquement';
                    }
                    if (int.parse(controller.montant.text) <= 0) {
                      return "Le prix n'est pas valide";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Prix",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: controller.isPrixValid.value
                    //     ? null
                    //     : "Prix invalide",
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
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.nombre,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Svp veuillez remplir le champs";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Nombre uniquement';
                    }
                    if (int.parse(value) <= 0) {
                      return "Le nombre n'est pas valide";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    labelText: "Nombre",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 0, 173, 253),
                    ),
                    // errorText: controller.isNombreValid.value
                    //     ? null
                    //     : "Nombre invalide",
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

                SizedBox(height: 20),
                (produit.id != null && produit is Produit)
                    ? ElevatedButton(
                        onPressed: () => {
                          controller.updateProduit(produit), // Update the vente
                        }, //  controller.updateVente(vente),
                        child: Text(
                          "Modifier le produit",
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
                      )
                    : ElevatedButton(
                        onPressed: () => {
                          controller
                              .createProduitWithImage(), //createProduit(),
                        }, //  controller.createVente(),
                        child: Text(
                          "Créer Produit",
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
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.offAll(() => ProduitsScreen()),
                  child: Text(
                    "Voir les produits",
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
