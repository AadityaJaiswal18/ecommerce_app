import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../services/api_service.dart';
import '../cart/cart_controller.dart';

class ProductDetailsController extends GetxController {
  ProductDetailsController(this.productId);

  final int productId;
  final ApiService _apiService = ApiService();
  final product = Rxn<ProductModel>();
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final quantity = 1.obs;
  final selectedColor = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      product.value = await _apiService.getProductById(productId);
    } catch (e) {
      errorMessage.value = 'Unable to load product';
    } finally {
      isLoading.value = false;
    }
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectColor(int index) {
    selectedColor.value = index;
  }

  Future<void> addToCart() async {
    final item = product.value;
    if (item == null) return;
    final cartController = Get.find<CartController>();
    for (int i = 0; i < quantity.value; i++) {
      await cartController.addProduct(item);
    }

    Get.snackbar(
      'Added to Cart',
      'Product added successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}