import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<void> removeItemFromCart(String productId) async {
  Map<String, String>? cartItemsMap =
      GetStorage().read<Map<String, String>>("cart_items_map");
  String? itemKey = cartItemsMap?[productId];
  String apiUrl = "https://dma-inc.net/wp-json/cocart/v2/cart/item/$itemKey";
  try {
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${GetStorage().read('token')}",
      },
      // body: jsonEncode({
      //   "cart_item_key": ,
      // }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      log("Item removed successfully: $responseBody");
      Get.snackbar("Success", "Item removed from cart!");
    } else {
      log("Failed to remove item: ${response.body}");
      Get.snackbar("Error", "Failed to remove item from cart.");
    }
  } catch (e) {
    log("Error during API call: $e");
    Get.snackbar("Error", "Something went wrong.");
  }
}
