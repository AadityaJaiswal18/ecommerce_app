import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_details_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });
  final int productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ProductDetailsController(productId),
      tag: productId.toString(),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF7A00),
            ),
          );
        }
        final product = controller.product.value;
        if (product == null) {
          return const Center(
            child: Text('Product not found'),
          );
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 360,
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECECEC),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Image.network(
                            product.image,
                            height: 270,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: Get.back,
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 17,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Color(0xFFFF7A00),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Seller: ShopMate',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF7A00),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 13,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  product.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            '(${product.ratingCount} Reviews)',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(
                          5, (index) => GestureDetector(
                            onTap: () => controller.selectColor(index),
                            child: Obx(() => Container(
                                width: 28,
                                height: 28,
                                margin: const EdgeInsets.only(right: 9),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                    controller.selectedColor.value ==
                                        index
                                        ? Colors.black
                                        : Colors.transparent,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: [
                                    const Color(0xFF333333),
                                    const Color(0xFFFF6B6B),
                                    const Color(0xFFFF9F43),
                                    const Color(0xFF1597BB),
                                    const Color(0xFF888888),
                                  ][index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFFF7A00),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    color: Color(0xFFFF7A00),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Specifications',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: controller.decreaseQuantity,
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    Obx(() => Text(
                        '${controller.quantity.value}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: controller.increaseQuantity,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7A00),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}