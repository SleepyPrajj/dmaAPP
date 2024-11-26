import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/featured_products_model.dart' as mod;

class FeaturedView extends StatelessWidget {
  final mod.FeaturedModel product;
  const FeaturedView({super.key, required this.product});

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
              SizedBox(height: screenWidth * 0.02),
              "\$${product.price}"
                  .text
                  .bold
                  .fontFamily(bold)
                  .align(TextAlign.center)
                  .size(screenWidth * 0.04) // Scale text size for price
                  .color(dmaBlack)
                  .make(),
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
