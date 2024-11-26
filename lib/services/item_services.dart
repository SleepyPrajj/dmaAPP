import 'package:dma_inc/consts/strings.dart';
import 'package:dma_inc/models/item_details_model.dart';

import 'package:http/http.dart' as http;

class ItemServices {
  static var client = http.Client();

  // ignore: non_constant_identifier_names
  static Future<ItemDetails> fetchItem(int ID) async {
    http.Response response;
    print(ID);
    response = await client.get(Uri.parse(
        'http://dma-inc.net/wp-json/wc/v3/products/$ID?consumer_key=$key&consumer_secret=$shhh'));
    print(response.body);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return itemFromJson(jsonString);
    } else {
      //show error
      return itemFromJson(response.statusCode.toString());
    }
  }
}
