import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

Future<void> fetchAndStoreCartItems() async {
  const String apiUrl = "https://dma-inc.net/wp-json/cocart/v2/cart";

  try {
    // Make the GET request
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${GetStorage().read('token')}",
      },
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final responseBody = jsonDecode(response.body);

      // Extract `id` and `item_key` from `items` and create the map
      Map<String, String> cartItemsMap = {};
      if (responseBody["items"] != null) {
        for (var item in responseBody["items"]) {
          cartItemsMap[item["id"].toString()] = item["item_key"];
        }

        // Store the map in GetStorage
        GetStorage().write("cart_items_map", cartItemsMap);

        print("Cart items map saved successfully: $cartItemsMap");
      } else {
        print("No items found in the cart.");
      }
    } else {
      print("Failed to fetch cart: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  } catch (e) {
    print("Error during API call: $e");
  }
}
