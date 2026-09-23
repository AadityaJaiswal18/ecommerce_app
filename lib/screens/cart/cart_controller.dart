import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final LocalStorage _storage = LocalStorage();
  final cartItems = <ProductModel>[].obs;
  final quantities = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    final savedCart = await _storage.loadCart();
    cartItems.clear();
    quantities.clear();
    for (final item in savedCart) {
      final product = ProductModel.fromJson(
        item['product'] as Map<String, dynamic>,
      );
      final quantity = (item['quantity'] as num?)?.toInt() ?? 1;
      cartItems.add(product);
      quantities[product.id] = quantity;
    }
  }

  Future<void> addProduct(ProductModel product) async {
    if (cartItems.any((item) => item.id == product.id)) {
      quantities[product.id] = getQuantity(product.id) + 1;
    } else {
      cartItems.add(product);
      quantities[product.id] = 1;
    }
    await saveCart();
  }

  int getQuantity(int productId) {
    return quantities[productId] ?? 1;
  }

  Future<void> increaseQuantity(ProductModel product) async {
    quantities[product.id] = getQuantity(product.id) + 1;
    await saveCart();
  }

  Future<void> decreaseQuantity(ProductModel product) async {
    final quantity = getQuantity(product.id);
    if (quantity > 1) {
      quantities[product.id] = quantity - 1;
      await saveCart();
    }
  }

  Future<void> removeProduct(ProductModel product) async {
    cartItems.removeWhere((item) => item.id == product.id);
    quantities.remove(product.id);
    await saveCart();
  }

  Future<void> saveCart() async {
    await _storage.saveCart(cartItems, quantities);
  }

  double get subtotal {
    return cartItems.fold(
      0,
          (total, product) {
        return total + product.price * getQuantity(product.id);
      },
    );
  }
  double get total => subtotal;
  void checkout() {
    Get.snackbar(
      'Checkout',
      'Checkout is not available yet',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }
}