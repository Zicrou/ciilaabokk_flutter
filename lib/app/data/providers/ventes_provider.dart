import 'package:dio/dio.dart';

class VentesProvider {
  final Dio _dio = Dio();

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<List<dynamic>> getListVentes() async {
    final response = await _dio.get('http://127.0.0.1:8000/api/V1/ventes/');
    if (response.statusCode == 200) {
      return response.data as List<dynamic>;
    } else {
      throw Exception('Failed to load ventes');
    }
  }
}
