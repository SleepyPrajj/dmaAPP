import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/category_product_model.dart' as mod;
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:dma_inc/widgets_common/favs_button.dart';
import 'package:get/get.dart';

class ProductTile extends StatefulWidget {
  final mod.CategoryModel product;
  const ProductTile(this.product, {super.key});

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        (widget.product.images.isNotEmpty)
                            ? widget.product.images[0].src
                            : "https://bitsofco.de/img/Qo5mfYDE5v-350.png",
                      ),
                    ),
                  ),
                  FavoriteButton(productId: widget.product.id)
                ],
              ),
              Text(
                widget.product.name,
                style: const TextStyle(fontSize: 15, fontFamily: bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              5.heightBox,
              buildPriceText(),
            ])
            .box
            .color(dmaWhite)
            .margin(const EdgeInsets.symmetric(horizontal: 4))
            .roundedSM
            .padding(const EdgeInsets.all(12))
            .make()
            .onTap(() {
          Get.to(() =>
              ItemScreen(title: widget.product.name, id: widget.product.id));
        }),
      ),
    );
  }

  Widget buildPriceText() {
    if (widget.product.stockStatus == "outofstock") {
      return "OUT OF STOCK!".text.fontFamily(bold).bold.size(17).make();
    } else if (widget.product.price == '') {
      return "Call for Pricing".text.fontFamily(bold).bold.size(17).make();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPriceWidgets(widget.product),
      );
    }
  }

  List<Widget> _buildPriceWidgets(mod.CategoryModel product) {
    if (product.regularPrice.isNotEmpty && product.salePrice.isNotEmpty) {
      return [
        Text(
          "\$${product.regularPrice}", // Old price
          style: const TextStyle(
            fontSize: 15,
            fontFamily: bold,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough, // Strikethrough
          ),
        ),
        "\$${product.salePrice}"
            .text
            .bold
            .fontFamily(bold)
            .align(TextAlign.center)
            .size(17)
            .color(dmaBlack)
            .make(),
      ];
    } else {
      return [
        "\$${product.price}"
            .text
            .bold
            .fontFamily(bold)
            .align(TextAlign.center)
            .size(17)
            .color(dmaBlack)
            .make(),
      ];
    }
  }
}
