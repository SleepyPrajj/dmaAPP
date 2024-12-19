import 'dart:convert';
import 'dart:developer';

import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/services/get_cart.dart';
import 'package:dma_inc/views/home_screen/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = GetStorage();

  Future<void> loginUser() async {
    isLoading(true);
    try {
      var response = await http.post(
        Uri.parse(
            'https://dma-inc.net/wp-json/jwt-auth/v1/token'), // Replace with your API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        storage.write('token', data['token']);
        storage.write('user_email', data['user_email']);
        storage.write('username', data['user_nicename']);
        storage.write('user_display_name', data['user_display_name']);

        // Retrieve customer ID based on email
        await getCustomerIdByEmail(data['user_email']);
        fetchAndStoreCartItems();
        Get.offAll(() => const Home()); // Navigate to Home screen
      } else {
        Get.snackbar('Login Failed', 'Invalid email or password');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading(false);
    }
  }

  // Method to retrieve the customer ID by email
  Future<void> getCustomerIdByEmail(String email) async {
    try {
      var token = storage.read('token');
      var response = await http.get(
        Uri.parse(
            'https://dma-inc.net/wp-json/wc/v3/customers?email=$email&role=all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use the JWT token if required
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          var customerId = data[0]['id']; // Assuming the email is unique
          var avatarUrl = data[0]['avatar_url'];
          storage.write(
              'customer_id', customerId); // Store customer ID if needed
          storage.write('avatar_url', avatarUrl);
        } else {
          log('No customer found with this email.');
        }
      } else {
        log('Failed to retrieve customer data');
      }
    } catch (e) {
      log('Error fetching customer ID: $e');
    }
  }

  String? get token => storage.read('token'); // Retrieve the token
}
