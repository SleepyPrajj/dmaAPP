import 'package:dma_inc/consts/strings.dart';
import 'package:dma_inc/models/featured_products_model.dart';
import 'package:http/http.dart' as http;

class FeaturedServieces {
  static var client = http.Client();

  static Future<List<FeaturedModel>> fetchFeatured() async {
    http.Response response;

    response = await client.get(Uri.parse(
        'http://dma-inc.net/wp-json/wc/v3/products?featured=true&per_page=100&consumer_key=$key&consumer_secret=$shhh'));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return featuredFromJson(jsonString);
    } else {
      //show error
      throw Exception(
          "Failed to load favorites, Status Code: ${response.statusCode}");
    }
  }
}
