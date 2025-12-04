import 'package:dio/dio.dart';
import '../models/car_model.dart';

class CarService {
  final Dio _dio = Dio();
  // Use 10.0.2.2 for Android emulator to access localhost, or localhost for web/iOS simulator
  // Since this is likely web or windows, localhost should work.
  // If running on Android emulator, use 'http://10.0.2.2:5000/api/cars'
  // Deployed API on Hugging Face
  static const String _apiDomain = 'https://drappy-cat-geargauge-api.hf.space';
  static const String _baseUrl = '$_apiDomain/api/cars'; 

  Future<List<String>> fetchBrands() async {
    try {
      print('CarService: Fetching brands from $_apiDomain/api/brands');
      final response = await _dio.get('$_apiDomain/api/brands');
      print('CarService: Brands response status: ${response.statusCode}');
      print('CarService: Brands data type: ${response.data.runtimeType}');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('CarService: Received ${data.length} brands');
        return List<String>.from(data);
      } else {
        throw Exception('Failed to load brands');
      }
    } catch (e) {
      print('CarService: Error fetching brands: $e');
      return [];
    }
  }

  Future<List<Car>> fetchCars({int page = 1, int limit = 20, String? brand, String? search}) async {
    try {
      String url = '$_baseUrl?page=$page&limit=$limit';
      if (brand != null) {
        url += '&brand=${Uri.encodeComponent(brand)}';
      }
      if (search != null && search.isNotEmpty) {
        url += '&search=${Uri.encodeComponent(search)}';
      }
      
      print('CarService: Fetching from $url');
      final response = await _dio.get(url);
      print('CarService: Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> carsData = responseData['data'];
        print('CarService: Received ${carsData.length} items (Page $page)');
        return carsData.map((json) => Car.fromJson(json)).toList();
      } else {
        print('CarService: Failed with status ${response.statusCode}');
        throw Exception('Failed to load cars: ${response.statusCode}');
      }
    } catch (e) {
      print('CarService: Error fetching cars: $e');
      throw Exception('Error fetching cars: $e');
    }
  }
}
