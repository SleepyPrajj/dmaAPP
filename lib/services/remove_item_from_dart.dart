import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<void> removeItemFromCart(String productId) async {
  Map<String, String>? cartItemsMap =
      GetStorage().read<Map<String, String>>("cart_items_map");
  String? item_key = cartItemsMap?[productId];
  String apiUrl = "https://dma-inc.net/wp-json/cocart/v2/cart/item/$item_key";
  print(apiUrl);
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
      print("Item removed successfully: $responseBody");
      Get.snackbar("Success", "Item removed from cart!");
    } else {
      print("Failed to remove item: ${response.body}");
      Get.snackbar("Error", "Failed to remove item from cart.");
    }
  } catch (e) {
    print("Error during API call: $e");
    Get.snackbar("Error", "Something went wrong.");
  }
}
