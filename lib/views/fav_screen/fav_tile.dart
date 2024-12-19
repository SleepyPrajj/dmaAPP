import 'dart:developer';

import 'package:dma_inc/api_controllers/favs_controller.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/favs_model.dart' as mod;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FavTile extends StatefulWidget {
  final mod.FavModel product;
  const FavTile({super.key, required this.product});

  @override
  State<FavTile> createState() => _FavTileState();
}

class _FavTileState extends State<FavTile> {
  void removeFromWishlist(int productId) async {
    final url = Uri.parse(
        'https://dma-inc.net/wp-json/yith/wishlist/v1/items?user_id=${GetStorage().read('customer_id')}&product_id=$productId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
          'Content-Type': 'application/json', // optional, depends on your API
        },
      );
      if (response.statusCode == 200) {
        Get.find<FavController>().fetchFavs();
        Get.snackbar("Removed!", "Item Removed from Wishlist");
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      log('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              (widget.product.imageUrl.isNotEmpty)
                  ? widget.product.imageUrl
                  : "https://bitsofco.de/img/Qo5mfYDE5v-350.png",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.productName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            CupertinoIcons.clear_circled_solid,
                            color: dmaRed,
                            size: 30,
                          ),
                          onPressed: () {
                            removeFromWishlist(
                                int.parse(widget.product.prodId));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  (widget.product.originalPrice == '0.000')
                      ? "Call for Pricing".text.size(16).fontFamily(bold).make()
                      : Text(
                          "\$${widget.product.originalPrice}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                  // if (widget.product.discount != null)
                  //   Text(
                  //     "\$${widget.product.discount}",
                  //     style: const TextStyle(
                  //       fontSize: 14,
                  //       decoration: TextDecoration.lineThrough,
                  //       color: Colors.red,
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).onTap(() {
      Get.to(() => ItemScreen(
          title: widget.product.productName,
          id: int.parse(widget.product.prodId)));
    });
  }
}
