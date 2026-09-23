import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../cart/cart_screen.dart';
import '../product_details/product_details_screen.dart';
import '../product_list/product_list_screen.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.put(DashboardController());
  final TextEditingController searchController = TextEditingController();
  final PageController bannerController = PageController(
    viewportFraction: 0.94,
  );
  Timer? bannerTimer;
  int currentBanner = 0;
  final banners = [
    'assets/images/banner_1.png',
    'assets/images/banner_2.png',
    'assets/images/banner_3.png',
  ];

  final categoryItems = [
    {
      'name': 'All',
      'icon': Icons.grid_view_rounded,
    },
    {
      'name': 'Shoes',
      'image': 'assets/icons/running-shoe.png',
    },
    {
      'name': "Men's",
      'image': 'assets/icons/jacket.png',
    },
    {
      'name': 'Watches',
      'image': 'assets/icons/wristwatch.png',
    },
    {
      'name': 'Electronics',
      'image': 'assets/icons/headphone.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    bannerTimer = Timer.periodic(
      const Duration(seconds: 3), (_) {
        if (!bannerController.hasClients) return;
        currentBanner = (currentBanner + 1) % banners.length;
        bannerController.animateToPage(
          currentBanner,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    bannerTimer?.cancel();
    searchController.dispose();
    bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Obx(() {
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
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.loadDashboard,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A00),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildBanner(),
                  const SizedBox(height: 10),
                  _buildBannerIndicator(),
                  const SizedBox(height: 18),
                  _buildCategories(),
                  const SizedBox(height: 22),
                  _buildSpecialForYou(),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.grid_view_rounded,
            size: 21,
            color: Color(0xFF333333),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/main_logo.jpeg',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 7),
              const Text(
                'ShopMate',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            size: 22,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: searchController,
        onChanged: controller.searchProducts,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xFF9A9A9A),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 21,
            color: Color(0xFF777777),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              searchController.clear();
              controller.searchProducts('');
            },
            icon: const Icon(
              Icons.tune_rounded,
              size: 19,
              color: Color(0xFF555555),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: bannerController,
        itemCount: banners.length,
        onPageChanged: (index) {
          setState(() {
            currentBanner = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(
                banners[index],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBannerIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        banners.length,
            (index) {
          final selected = currentBanner == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: selected ? 18 : 5,
            height: 5,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFFF7A00)
                  : const Color(0xFFD0D0D0),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categoryItems.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categoryItems[index];
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Get.to(() => ProductListScreen(
                  category: category['name'].toString(),
                ),
              );
            },
            child: SizedBox(
              width: 66,
              child: Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? const Color(0xFFFFF1E6)
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: index == 0
                            ? const Color(0xFFFF8A00)
                            : const Color(0xFFE4E4E4),
                        width: index == 0 ? 1.5 : 1,
                      ),
                    ),
                    child: index == 0
                        ? const Icon(
                      Icons.grid_view_rounded,
                      size: 22,
                      color: Color(0xFFFF7A00),
                    ) : Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        category['image'].toString(),
                        width: 36,
                        height: 36,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category['name'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                      index == 0 ? FontWeight.w600 : FontWeight.w500,
                      color: index == 0
                          ? const Color(0xFFFF7A00)
                          : const Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpecialForYou() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Special For You',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF222222),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF777777),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() {
            final products = controller.filteredProducts;
            if (products.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }
            final count = products.length > 6 ? 6 : products.length;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: count,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(
                          productId: product.id,
                        ));
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
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  color: const Color(0xFFF5F5F5),
                                  padding: const EdgeInsets.all(15),
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) {
                                      return const Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border_rounded,
                                    size: 16,
                                    color: Color(0xFFFF7A00),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 10,),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF222222),
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
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Obx(() => NavigationBar(
        height: 68,
        selectedIndex: controller.selectedTab.value,
        onDestinationSelected: (index) {
          controller.changeTab(index);
          if (index == 1) {
            Get.to(() => const CartScreen());
          }
        },
        backgroundColor: Colors.white,
        indicatorColor:
        const Color(0xFFFF8A00).withValues(alpha: 0.12),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'Wishlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}