import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 19,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(
            child: Text(
              'Your cart is empty',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final product = controller.cartItems[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.removeProduct(product);
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Color(0xFFFF7A00),
                                      size: 19,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product.category,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    height: 28,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.decreaseQuantity(
                                              product,
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(() => Text(
                                            '${controller.getQuantity(product.id)}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.increaseQuantity(
                                              product,
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Enter Discount Code',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(22),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Color(0xFFFF7A00),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Obx(
                        () => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '\$${controller.subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${controller.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: controller.checkout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A00),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}