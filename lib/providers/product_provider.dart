import 'package:asset_mangement/models/product_model.dart';
import 'package:asset_mangement/sevices/api_services.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> addProduct(Product product) async {
    _products.add(product);
    notifyListeners();

    // Save
    await ApiService.saveProduct(product);
  }
}
