import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/search_model.dart' as mod;
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:dma_inc/widgets_common/favs_button.dart';
import 'package:get/get.dart';

class SearchTile extends StatelessWidget {
  final mod.SearchModel product;
  const SearchTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use a Stack to overlap the favorite button on the image
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  color: Vx.white,
                  width: 200,
                  height: 200,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.network(
                      (product.images.isNotEmpty)
                          ? product.images[0].src
                          : "https://bitsofco.de/img/Qo5mfYDE5v-350.png",
                    ),
                  ),
                ),
                FavoriteButton(productId: product.id)
              ],
            ),
            const Spacer(),
            // Product name
            Text(
              product.name,
              style: const TextStyle(fontSize: 15, fontFamily: bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            5.heightBox,
            // Product price

            (product.stockStatus == 'outofstock'
                    ? "OUT OF STOCK!"
                    : (product.price == ''
                        ? "Call for Pricing"
                        : "\$${product.price}"))
                .text
                .fontFamily(bold)
                .bold
                .size(17)
                .make()
          ],
        )
            .box
            .color(dmaWhite)
            .margin(const EdgeInsets.symmetric(horizontal: 4))
            .roundedSM
            .padding(const EdgeInsets.all(12))
            .make()
            .onTap(() {
          Get.to(() => ItemScreen(title: product.name, id: product.id));
        }),
      ),
    );
  }
}
