import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LocalStorage _storage = LocalStorage();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      await _storage.saveLogin(_emailController.text.trim());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFB5B5B5),
        fontSize: 14,
      ),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFFF8A00),
          width: 1.2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFF8F6),
              Color(0xFFFFF4F1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(30, 55, 30, 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Hello Again!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome back you\'ve\nbeen missed!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 45),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: _inputDecoration(hint: 'Enter email'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(
                        r'^[\w.-]+@[\w.-]+\.[A-Za-z]{2,}$',
                      );
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _login(),
                    decoration: _inputDecoration(
                      hint: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Text(
                        'Recovery Password',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A00),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey.shade400),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or continue with',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/google_logo.png',
                              width: 21,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/apple_logo.png',
                              width: 21,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/facebook_logo.png',
                              width: 21,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member? ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF666666),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4285F4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}