import 'package:dma_inc/consts/strings.dart';
import 'package:dma_inc/models/orders_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PastThreeMonthsServices {
  static var client = http.Client();

  static Future<List<OrdersModel>> fetchPastThree() async {
    try {
      // Calculate the date three months ago from the current date
      DateTime threeMonthsAgo =
          DateTime.now().subtract(const Duration(days: 90));
      String formattedDate = DateFormat('yyyy-MM-dd').format(threeMonthsAgo);

      // Add the `after` parameter to the URI
      http.Response response = await client.get(Uri.parse(
          'http://dma-inc.net/wp-json/wc/v3/orders?customer=${GetStorage().read('customer_id')}&per_page=100&after=${formattedDate}T00:00:00Z&consumer_key=$key&consumer_secret=$shhh'));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return ordersFromJson(jsonString);
      } else {
        throw Exception(
            "Failed to fetch past three months orders, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
