import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/sale_model.dart' as mod;
import 'package:dma_inc/widgets_common/favs_button.dart';

class SaleProducts extends StatelessWidget {
  final mod.SaleModel product;

  const SaleProducts({super.key, required this.product});

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
                height: 120,
                fit: BoxFit.fill,
              ).centered(),
              const Spacer(),
              10.heightBox,
              // Updated product name to limit to 2 lines
              product.name.text
                  .fontFamily(regular)
                  .bold
                  .align(TextAlign.center)
                  .color(darkFontGrey)
                  .size(15)
                  .maxLines(2) // Limit to 2 lines
                  .overflow(TextOverflow.ellipsis) // Show ellipsis if exceeded
                  .make(),
              // Display old price with strikethrough
              ..._buildPriceWidgets(product),
            ],
          )
              .box
              .white
              .margin(const EdgeInsets.symmetric(horizontal: 4))
              .roundedSM
              .padding(const EdgeInsets.all(8))
              .make(),
        ),
      ),
    );
  }
}

List<Widget> _buildPriceWidgets(mod.SaleModel product) {
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
