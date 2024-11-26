import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/orders_model.dart' as mod;
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:get/get.dart';

class BuyAgainProducts extends StatelessWidget {
  final mod.LineItem product; // Change the type to a LineItem

  const BuyAgainProducts({super.key, required this.product});

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
                child: CircleAvatar(
                  backgroundColor: dmaGreytrans,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ),
              ),
              // Access lineItem image
              Image.network(
                product.image.src, // Access image from lineItem
                width: 150,
                fit: BoxFit.fill,
              ).centered(),
              const Spacer(),
              10.heightBox,
              // Display lineItem name with ellipsis if too long
              product.name.text
                  .fontFamily(regular)
                  .bold
                  .align(TextAlign.center)
                  .color(darkFontGrey)
                  .size(15)
                  .maxLines(2)
                  .overflow(TextOverflow.ellipsis)
                  .make(),
              10.heightBox,
            ],
          )
              .box
              .white
              .margin(const EdgeInsets.symmetric(horizontal: 4))
              .roundedSM
              .padding(const EdgeInsets.all(8))
              .make()
              .onTap(() {
            print("name: ${product.name}\n id: ${product.id}");
            Get.to(() => ItemScreen(
                  title: product.name,
                  id: product.productId,
                ));
          }),
        ),
      ),
    );
  }
}
