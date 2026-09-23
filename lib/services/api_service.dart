import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<String>> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/categories'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((category) => category.toString()).toList();
    }
    throw Exception('Failed to load categories');
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map(
            (product) => ProductModel.fromJson(
          product as Map<String, dynamic>,
        ),
      ).toList();
    }
    throw Exception('Failed to load products');
  }

  Future<List<ProductModel>> getProductsByCategory(
      String category,
      ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/products/category/${Uri.encodeComponent(category)}',
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data
          .map(
            (product) => ProductModel.fromJson(
          product as Map<String, dynamic>,
        ),
      ).toList();
    }
    throw Exception('Failed to load products by category');
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$id'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductModel.fromJson(data);
    }
    throw Exception('Failed to load product');
  }
}