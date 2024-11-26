import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/sale_model.dart' as mod;

class SalesView extends StatelessWidget {
  final mod.SaleModel product;
  const SalesView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: BoxConstraints.expand(
        height: screenWidth * 0.4, // Adjust height dynamically
        width: screenWidth * 0.5, // Adjust width dynamically
      ),
      child: IntrinsicHeight(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                product.images[0].src,
                height: screenWidth * 0.18, // Scale image height
                width: screenWidth * 0.25, // Scale image width
                fit: BoxFit.fill,
              ).centered(),
              const Spacer(),
              Center(
                child: product.name.text
                    .fontFamily(regular)
                    .bold
                    .maxLines(2)
                    .overflow(TextOverflow.ellipsis)
                    .align(TextAlign.center)
                    .color(darkFontGrey)
                    .maxLines(1)
                    .size(screenWidth * 0.035) // Scale text size for name
                    .make(),
              ),
              // SizedBox(height: screenWidth * 0.02),
              ..._buildPriceWidgets(product),
            ],
          )
              .box
              .white
              .margin(EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01)) // Scale margin
              .roundedSM
              .padding(EdgeInsets.all(screenWidth * 0.02)) // Scale padding
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
