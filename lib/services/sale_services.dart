import 'package:dma_inc/consts/strings.dart';
import 'package:dma_inc/models/sale_model.dart';
import 'package:http/http.dart' as http;

class SaleServices {
  static var client = http.Client();

  static Future<List<SaleModel>> fetchFeatured() async {
    http.Response response;

    response = await client.get(Uri.parse(
        'http://dma-inc.net/wp-json/wc/v3/products?on_sale=true&per_page=100&consumer_key=$key&consumer_secret=$shhh'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return saleFromJson(jsonString);
    } else {
      //show error
      throw Exception(
          "Failed to load favorites, Status Code: ${response.statusCode}");
    }
  }
}
