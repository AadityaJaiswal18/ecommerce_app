import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../services/api_service.dart';

class ProductListController extends GetxController {
  ProductListController(this.category);
  final String category;
  final ApiService _apiService = ApiService();
  final products = <ProductModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = category.toLowerCase() == 'all'
          ? await _apiService.getProducts()
          : await _apiService.getProductsByCategory(category);
      products.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Unable to load products';
    } finally {
      isLoading.value = false;
    }
  }
}