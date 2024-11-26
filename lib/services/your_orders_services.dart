import 'dart:developer';

import 'package:dma_inc/consts/strings.dart';
import 'package:dma_inc/models/orders_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class YourOrdersServices {
  static var client = http.Client();

  static Future<List<OrdersModel>> fetchBuyAgain() async {
    try {
      http.Response response = await client.get(Uri.parse(
          'http://dma-inc.net/wp-json/wc/v3/orders?customer=${GetStorage().read('customer_id')}&per_page=100&consumer_key=$key&consumer_secret=$shhh'));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return ordersFromJson(jsonString);
      } else {
        throw Exception(
            "Failed to buy again, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching orders: $e");
      throw Exception("Error: $e");
    }
  }
}
