import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/item_details_model.dart' as deet;
import 'package:dma_inc/views/item_details/quantity_controller.dart';
import 'package:dma_inc/widgets_common/favs_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:widget_zoom/widget_zoom.dart';

class DetailsGetter extends StatelessWidget {
  final deet.ItemDetails item;
  const DetailsGetter({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final QuantityController quantityController =
        Get.find<QuantityController>(); // Access existing instance
    String disc = Bidi.stripHtmlIfNeeded(item.description);
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        item.name.text
            .size(screenWidth * 0.045)
            .color(dmaBlack)
            .fontFamily(regular)
            .bold
            .make(),
        SizedBox(height: screenWidth * 0.01),
        Stack(alignment: Alignment.topRight, children: [
          (item.images.length != 1)
              ? WidgetZoom(
                  heroAnimationTag: 'tag',
                  zoomWidget: VxSwiper.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: false,
                    height: screenWidth * 0.8,
                    itemCount: item.images.length,
                    viewportFraction: 1.0,
                    aspectRatio: 16 / 9,
                    itemBuilder: (context, index) {
                      return Image.network(
                        item.images[index].src,
                        height: screenWidth * 0.75,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                )
              : WidgetZoom(
                  heroAnimationTag: 'tag',
                  zoomWidget: Image.network(
                    item.images[0].src,
                    height: screenWidth * 0.75,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  )),
          FavoriteButton(productId: item.id)
        ]),
        SizedBox(height: screenWidth * 0.02),
        (item.stockStatus == "outofstock"
                ? "OUT OF STOCK!"
                : (item.price == '' ? "" : "\$${item.price}"))
            .text
            .fontFamily(bold)
            .bold
            .size(38)
            .make(),
        SizedBox(height: screenWidth * 0.02),
        Row(
          children: [
            "Quantity: "
                .text
                .size(screenWidth * 0.05)
                .fontFamily(bold)
                .bold
                .make(),
            IconButton(
              onPressed: quantityController.decrement,
              icon: Icon(
                Icons.remove,
                size: screenWidth * 0.06,
                color: dmaBlack,
              ),
            ),
            Obx(() => quantityController.quantity
                .toString()
                .text
                .size(screenWidth * 0.06)
                .color(darkFontGrey)
                .fontFamily(bold)
                .bold
                .make()),
            IconButton(
              onPressed: quantityController.increment,
              icon: Icon(
                Icons.add,
                size: screenWidth * 0.06,
                color: dmaRed,
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.02),
        "SKU: ${item.sku} \nProduct ID: ${item.id}"
            .text
            .size(screenWidth * 0.04)
            .fontFamily(regular)
            .semiBold
            .make(),
        SizedBox(height: screenWidth * 0.05),
        "Description:"
            .text
            .bold
            .fontFamily(bold)
            .size(screenWidth * 0.05)
            .align(TextAlign.left)
            .make(),
        SizedBox(height: screenWidth * 0.01),
        disc
            .replaceAll('\n', ' ')
            .replaceAll('\t', ',')
            .trim()
            .text
            .size(screenWidth * 0.045)
            .fontFamily(regular)
            .semiBold
            .make(),
        SizedBox(height: screenWidth * 0.05),
      ],
    );
  }
}
