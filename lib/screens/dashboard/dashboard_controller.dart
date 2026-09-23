import 'package:get/get.dart';
import '../../models/product_model.dart';
import '../../services/api_service.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();
  final categories = <String>[].obs;
  final products = <ProductModel>[].obs;
  final filteredProducts = <ProductModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final selectedTab = 0.obs;
  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final results = await Future.wait([
        _apiService.getCategories(),
        _apiService.getProducts(),
      ]);
      categories.assignAll(results[0] as List<String>);
      products.assignAll(results[1] as List<ProductModel>);
      filteredProducts.assignAll(products);
    } catch (e) {
      errorMessage.value = 'Unable to load products';
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String value) {
    searchText.value = value.trim().toLowerCase();
    if (searchText.isEmpty) {
      filteredProducts.assignAll(products);
      return;
    }
    filteredProducts.assignAll(
      products.where((product) => product.title.toLowerCase().contains(searchText.value),
      ),
    );
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }
}