import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class LocalStorage {
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  static const String _loginKey = 'is_logged_in';
  static const String _emailKey = 'user_email';
  static const String _cartKey = 'cart_items';

  Future<void> saveLogin(String email) async {
    final prefs = await _prefs;
    await prefs.setBool(_loginKey, true);
    await prefs.setString(_emailKey, email);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_loginKey) ?? false;
  }

  Future<String?> getUserEmail() async {
    final prefs = await _prefs;
    return prefs.getString(_emailKey);
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_loginKey);
    await prefs.remove(_emailKey);
  }

  Future<void> saveCart(
      List<ProductModel> products,
      Map<int, int> quantities,
      ) async {
    final prefs = await _prefs;
    final cartData = products.map((product) {
      return jsonEncode({
        'product': product.toJson(),
        'quantity': quantities[product.id] ?? 1,
      });
    }).toList();
    await prefs.setStringList(_cartKey, cartData);
  }

  Future<List<Map<String, dynamic>>> loadCart() async {
    final prefs = await _prefs;
    final cartData = prefs.getStringList(_cartKey) ?? [];
    return cartData.map((item) {
      return jsonDecode(item) as Map<String, dynamic>;
    }).toList();
  }

  Future<void> clearCart() async {
    final prefs = await _prefs;
    await prefs.remove(_cartKey);
  }
}