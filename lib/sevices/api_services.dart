import 'dart:convert';
import 'package:asset_mangement/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = "https://yourapi.com/products";

  static Future<void> saveProduct(Product product) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to save product");
    }
  }
}
