import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../product_details/product_details_screen.dart';
import 'product_list_controller.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProductListController(category),
      tag: category,
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19,
          ),
        ),
        centerTitle: true,
        title: Text(
          _categoryTitle(category),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF222222),
          ),
        ),
      ),
      body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF8A00),
              ),
            );
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cloud_off_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.loadProducts,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A00),
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (controller.products.isEmpty) {
            return const Center(
              child: Text(
                'No products found',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.products.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 14,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.to(() => ProductDetailsScreen(
                      productId: product.id,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Container(
                            width: double.infinity,
                            color: const Color(0xFFF5F5F5),
                            padding: const EdgeInsets.all(18),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) {
                                return const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 35,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }

                                return const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFFF8A00),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 9, 11, 12,),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFF7A00),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _categoryTitle(String value) {
    switch (value.toLowerCase()) {
      case "men's clothing":
        return "Men's Clothing";
      case "women's clothing":
        return "Women's Clothing";
      case 'jewelery':
        return 'Jewelery';
      case 'electronics':
        return 'Electronics';
      default:
        return value;
    }
  }
}