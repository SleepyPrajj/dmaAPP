import 'package:dma_inc/models/favs_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class FavServices {
  GetStorage storage = GetStorage();
  Future<List<FavModel>> fetchFavItems() async {
    final response = await http.get(Uri.parse(
        'http://dma-inc.net/wp-json/custom/v1/wishlist/${storage.read('customer_id')}'));

    if (response.statusCode == 200) {
      var jsonData = response.body;
      return favFromJson(jsonData);
    } else {
      throw Exception(
          "Failed to load favorites, Status Code: ${response.statusCode}");
    }
  }
}
