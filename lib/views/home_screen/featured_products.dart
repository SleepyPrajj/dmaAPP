import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/featured_products_model.dart' as mod;
import 'package:dma_inc/widgets_common/favs_button.dart';

class FeaturedProducts extends StatelessWidget {
  final mod.FeaturedModel product;
  const FeaturedProducts({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(height: 300, width: 350),
        child: IntrinsicHeight(
            child: Container(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: FavoriteButton(productId: product.id)),
            Image.network(
              product.images[0].src,
              width: 150,
              fit: BoxFit.fill,
            ).centered(),
            const Spacer(),
            10.heightBox,
            product.name.text
                .fontFamily(regular)
                .bold
                .maxLines(1)
                .align(TextAlign.center)
                .color(darkFontGrey)
                .size(15)
                .make(),
            10.heightBox,
            (product.stockStatus == "outofstock"
                        ? "OUT OF STOCK!"
                        : (product.price == '')
                            ? "Call for Pricing"
                            : null)
                    ?.text
                    .bold
                    .fontFamily(bold)
                    .align(TextAlign.center)
                    .size(17)
                    .color(dmaBlack)
                    .make() ??
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPriceWidgets(product),
                ),
          ],
        )
                    .box
                    .white
                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                    .roundedSM
                    .padding(const EdgeInsets.all(8))
                    .make())));
  }
}

List<Widget> _buildPriceWidgets(mod.FeaturedModel product) {
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
