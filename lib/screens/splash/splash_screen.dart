import 'dart:async';
import 'package:flutter/material.dart';

import '../../shared_preferences/shared_preferences.dart';
import '../dashboard/dashboard_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  Timer? _timer;
  final LocalStorage _storage = LocalStorage();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
    _timer = Timer(const Duration(seconds: 3), () async {
      if (!mounted) return;
      final isLoggedIn = await _storage.isLoggedIn();
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isLoggedIn
              ? const DashboardScreen()
              : const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/main_logo.jpeg',
                width: 220,
                height: 220,
                fit: BoxFit.contain,
              ),
              const Text(
                'ShopMate',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFF8A00),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}