import 'dart:convert';

import 'package:ciilaabokk/app/data/models/user.dart';
import 'package:ciilaabokk/app/data/models/user_info.dart';
import 'package:ciilaabokk/app/data/models/user_register.dart';
import 'package:ciilaabokk/app/data/models/ventes.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class RemoteServices {
  static final Dio _dio = Dio();

  Future<dynamic> login(String phone, String password) async {
    try {
      final response = await _dio.post('http://10.0.2.2:8000/api/V1/login');
      logger.i("Response from remote service: ${response.data})");
      if (response.statusCode == 200 && response.data != null) {
        // Dio automatically parses JSON, so we use response.data
        return UserInfo.fromJson(response.data);
      } else {
        throw Exception("Failed to load userInfo with Dio");
      }
    } catch (e) {
      throw Exception("Error fetching UserInfo: $e");
    }
  }

  Future<dynamic> signUp(String name, String phone, String password) async {
    try {
      // User _user = User();
      // _user.name = name;
      // _user.phoneNumber = phone;
      // _user.password = password;
      var body = {'name': name, 'phone_number': phone, 'password': password};

      var bodyToJson = jsonEncode(body);
      final response = await _dio.post(
        'http://10.0.2.2:8000/api/V1/register',
        data: body,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      logger.i("Response from remote service: ${response})");
      if (response.statusCode == 200 && response.data != null) {
        // Dio automatically parses JSON, so we use response.data
        var userRegister = UserRegister.fromJson(response.data);
        logger.i("Response User from Remote Services: ${userRegister}");
        return userRegister;
      } else {
        throw Exception("Failed to load UserRegister with Dio");
      }
    } catch (e) {
      throw Exception("Error fetching UserRegister: $e");
    }
  }

  static Future<VenteResponse> fetchVentes() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8000/api/V1/ventes');
      if (response.statusCode == 200 && response.data != null) {
        // Dio automatically parses JSON, so we use response.data
        return VenteResponse.fromJson(response.data);
        // if venteFromJson expects raw JSON string
        // OR: return VenteResponse.fromJson(response.data); // if you have fromJson constructor
      } else {
        throw Exception("Failed to load ventes with Dio");
      }
    } catch (e) {
      throw Exception("Error fetching ventes: $e");
    }
  }
  // Using HTTP
  //static var client = http.Client();

  // static Future<List<Product>> fetchProducts() async {
  //   var response = await client.get(
  //     Uri.parse(
  //       'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline',
  //     ),
  //   );

  //   if (response.statusCode == 200 && response.body.isNotEmpty) {
  //     var jsonString = response.body;
  //     logger.i("RemoteServices: Fetching products from API: $jsonString");
  //     return productFromJson(jsonString);
  //   } else {
  //     return [];
  //   }
  // }

  // static Future<VenteResponse> fetchVentes() async {
  //   var response = await client.get(
  //     Uri.parse('http://10.0.2.2:8000/api/V1/ventes'),
  //   );

  //   if (response.statusCode == 200 && response.body.isNotEmpty) {
  //     return venteFromJson(response.body);
  //   } else {
  //     throw Exception("Failed to load ventes");
  //   }
  // }
}
