import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/consts/strings.dart';
import 'package:dma_inc/models/search_model.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  static var client = http.Client();

  static Future<Map<String, dynamic>> fetchSearch(
      String searchString, int page, String? sortby) async {
    http.Response response;
    String url =
        'http://dma-inc.net/wp-json/wc/v3/products?search=$searchString&per_page=20&page=$page&consumer_key=$key&consumer_secret=$shhh';
    if (sortby != null) {
      if (sortby == 'Lprice') {
        url += '&orderby=price&order=asc';
      } else if (sortby == 'Odate') {
        url += '&orderby=date&order=asc';
      } else {
        url += '&orderby=$sortby';
      }
    }
    response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var searchResults = searchFromJson(jsonString);
      // Get the total pages from the response headers
      int totalPages =
          int.tryParse(response.headers['x-wp-totalpages'] ?? '0') ?? 1;

      return {
        'products': searchResults,
        'totalPages': totalPages,
        'currentPage': page
      };
    } else {
      // Handle error
      return {
        'products': [],
        'totalPages': 0,
      };
    }
  }
}
