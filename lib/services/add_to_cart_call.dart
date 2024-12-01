import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<void> addToCartApiCall(String itemID, int quantity) async {
  const String apiUrl = "https://dma-inc.net/wp-json/cocart/v1/add-item";
  Map<String, String>? cartItemsMap =
      GetStorage().read<Map<String, String>>("cart_items_map");
  print('calling');
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${GetStorage().read('token')}",
        "Connection": "keep-alive"
      },
      body: jsonEncode({
        "product_id": itemID,
        "quantity": "$quantity",
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final Map<String, dynamic> parsedResponse = responseBody;
      String key = parsedResponse['key'];
      int productId = parsedResponse['product_id'];

      Get.snackbar("Success", "Item added to cart!");
      cartItemsMap?[productId.toString()] = key;
      GetStorage().write("cart_items_map", cartItemsMap);

      print("API Response: $responseBody");
    } else {
      print("Failed to add to cart: ${response.statusCode}");
      print("Response body: ${response.body}");
      Get.snackbar("Error", "Failed to add item to cart.");
    }
  } catch (e) {
    print("Error during API call: $e");
    Get.snackbar("Error", "Something went wrong.");
  }
}
