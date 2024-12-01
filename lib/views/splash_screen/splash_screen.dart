import 'dart:io';

import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/services/get_cart.dart';
import 'package:dma_inc/views/auth_screen/login_screen.dart';
import 'package:dma_inc/views/home_screen/home.dart';
import 'package:dma_inc/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isLoggedIn();
    });
    fetchAndStoreCartItems();
  }

  // Check for token presence and validity
  Future<void> isLoggedIn() async {
    String? token = storage.read('token');

    if (token == null || !(await verifyToken(token))) {
      // No token or invalid token, navigate to login
      Get.offAll(() => const Login());
    } else {
      print(token);
      Get.offAll(() => const Home());
    }
  }

  // Verify token by calling a test API endpoint (adjust endpoint as needed)
  Future<bool> verifyToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://dma-inc.net/wp-json/jwt-auth/v1/token/validate'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 200; // Token is valid if response is OK
    } catch (e) {
      return false; // Invalid if any error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dmaDarkGrey,
      body: Center(
        child: Column(
          children: [
            5.heightBox,
            const Spacer(),
            applogoWidget(),
            5.heightBox,
            const Spacer(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
