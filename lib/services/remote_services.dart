import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/category_product_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<Map<String, dynamic>> fetchProducts(
      String title, int page, String? sortby) async {
    switch (title) {
      case "Knives":
        title = knivesCat;
        break;
      case "Martial Arts":
        title = martialArtsCat;
        break;
      case "BlowGuns":
        title = blowgunsCat;
        break;
      case "Personal Security":
        title = personalSecurityTag;
        break;
      case "Tactical Gear":
        title = tacticalGearCat;
        break;
      case "XTS Products":
        title = xtsTag;
        break;
      case 'Glock Slides':
        title = glockSlide;
        break;
      case 'Glock Barrels':
        title = glockBarrelsCat;
        break;
      case 'Stun Guns':
        title = stunGunsCat;
        break;
      case 'DVR Security':
        title = homeSec;
        break;
      case 'Auto Knives':
        title = autoKnives;
        break;
      case 'Steel Plates':
        title = plates;
        break;
      case 'Dual Rifle Cases':
        title = rifleCase;
        break;
      case 'Uppers':
        title = '4982';
        break;
      case 'Lowers':
        title = '5099';
        break;
    }

    String baseUrl = 'http://dma-inc.net/wp-json/wc/v3/products?';
    String categoryOrTag =
        (title == xtsTag || title == personalSecurityTag || title == rifleCase)
            ? 'tag=$title'
            : 'category=$title';

    String url =
        '$baseUrl$categoryOrTag&per_page=14&page=$page&consumer_key=$key&consumer_secret=$shhh';

    if (sortby != null) {
      if (sortby == 'Lprice') {
        url += '&orderby=price&order=asc';
      } else if (sortby == 'Odate') {
        url += '&orderby=date&order=asc';
      } else {
        url += '&orderby=$sortby';
      }
    }
    http.Response response;
    if (title == 'Black Friday Sale!!') {
      response = await client.get(Uri.parse(
          'http://dma-inc.net/wp-json/wc/v3/products?on_sale=true&per_page=100&consumer_key=$key&consumer_secret=$shhh'));
    } else {
      response = await client.get(Uri.parse(url));
    }

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var catResults = catFromJson(jsonString);
      int totalPages =
          int.tryParse(response.headers['x-wp-totalpages'] ?? '0') ?? 1;
      int totalItems = int.tryParse(response.headers['x-wp-total'] ?? '0') ?? 0;

      return {
        'products': catResults,
        'totalPages': totalPages,
        'currentPage': page,
        'totalItems': totalItems,
      };
    } else {
      return {
        'products': [],
        'totalPages': 0,
      };
    }
  }

  static Future<Map<String, dynamic>> fetchFilteredProducts(
      String title,
      int page,
      String? sortby,
      String? categoryID,
      String? subCategoryID,
      String? stockStatus,
      RangeValues? priceRange,
      String? sort) async {
    String baseUrl = 'http://dma-inc.net/wp-json/wc/v3/products?';
    String categoryOrTag = '';

// First check if subCategoryID is provided
    if (subCategoryID != null) {
      categoryOrTag = 'category=$subCategoryID';
    } else if (categoryID != null) {
      // Handle specific category cases
      if (['6255', '6262', '5002', '5640'].contains(categoryID)) {
        categoryOrTag = 'tag=$categoryID';
      } else {
        categoryOrTag = 'category=$categoryID';
      }
    } else {
      // If no category or subcategory, set default based on title
      Map<String, String> titleToValue = {
        "Knives": knivesCat,
        "Martial Arts": martialArtsCat,
        "BlowGuns": blowgunsCat,
        "Personal Security": personalSecurityTag,
        "Tactical Gear": tacticalGearCat,
        "XTS Products": xtsTag,
        'Glock Slides': glockSlide,
        'Glock Barrels': glockBarrelsCat,
        'Stun Guns': stunGunsCat,
        'DVR Security': homeSec,
        'Steel Plates': plates,
        'Dual Rifle Cases': rifleCase,
        'Uppers': '4982',
        'Lowers': '5099',
        'Auto Knives': autoKnives,
      };

      // If the title matches, use the corresponding category/tag
      if (titleToValue.containsKey(title)) {
        title = titleToValue[title]!;
      }

      // Use category or tag based on the title value
      categoryOrTag = (title == xtsTag ||
              title == personalSecurityTag ||
              title == rifleCase)
          ? 'tag=$title'
          : 'category=$title';
    }

    print(categoryOrTag); // This will print the final result

    // String categoryOrTag = '';
    // print(subCategoryID);
    // if (subCategoryID != null) {
    //   'category=$subCategoryID';
    // } else if (categoryID != null) {
    //   if (categoryID == '6255' ||
    //       categoryID == '6262' ||
    //       categoryID == '5002' ||
    //       categoryID == '5640') {
    //     categoryOrTag = 'tag=$categoryID';
    //   } else {
    //     categoryOrTag = 'category=$categoryID';
    //   }
    // } else {
    //   // Default to using title as a tag if no category or subcategory is provided
    //   switch (title) {
    //     case "Knives":
    //       title = knivesCat;
    //       break;
    //     case "Martial Arts":
    //       title = martialArtsCat;
    //       break;
    //     case "BlowGuns":
    //       title = blowgunsCat;
    //       break;
    //     case "Personal Security":
    //       title = personalSecurityTag;
    //       break;
    //     case "Tactical Gear":
    //       title = tacticalGearCat;
    //       break;
    //     case "XTS Products":
    //       title = xtsTag;
    //       break;
    //     case 'Glock Slides':
    //       title = glockSlide;
    //       break;
    //     case 'Glock Barrels':
    //       title = glockBarrelsCat;
    //       break;
    //     case 'Stun Guns':
    //       title = stunGunsCat;
    //       break;
    //     case 'DVR Security':
    //       title = homeSec;
    //       break;
    //     case 'Steel Plates':
    //       title = plates;
    //       break;
    //     case 'Dual Rifle Cases':
    //       title = rifleCase;
    //       break;
    //     case 'Uppers':
    //       title = '4982';
    //       break;
    //     case 'Lowers':
    //       title = '5099';
    //       break;
    //     case 'Auto Knives':
    //       title = autoKnives;
    //       break;
    //   }
    //   (title == xtsTag || title == personalSecurityTag || title == rifleCase)
    //       ? 'tag=$title'
    //       : 'category=$title';
    // }

    // Construct the base URL
    String url =
        '$baseUrl$categoryOrTag&per_page=14&page=$page&consumer_key=$key&consumer_secret=$shhh';

    // Add sorting parameter if not null
    if (sortby != null && sortby != '') {
      if (sortby == 'Lprice') {
        url += '&orderby=price&order=asc';
      } else if (sortby == 'Odate') {
        url += '&orderby=date&order=asc';
      } else {
        url += '&orderby=$sortby';
      }
    }

    if (stockStatus != null) {
      url += '&stock_status=$stockStatus';
    }

    if (priceRange != null && priceRange != const RangeValues(1, 1000)) {
      url += '&min_price=${priceRange.start}&max_price=${priceRange.end}';
    }

    http.Response response = await client.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var catResults = catFromJson(jsonString);
      int totalPages =
          int.tryParse(response.headers['x-wp-totalpages'] ?? '0') ?? 1;
      int totalItems = int.tryParse(response.headers['x-wp-total'] ?? '0') ?? 0;

      return {
        'products': catResults,
        'totalPages': totalPages,
        'currentPage': page,
        'totalItems': totalItems,
      };
    } else {
      return {
        'products': [],
        'totalPages': 0,
      };
    }
  }
}
