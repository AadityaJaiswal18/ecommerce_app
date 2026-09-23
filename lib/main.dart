import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/cart/cart_controller.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController(), permanent: true);
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}