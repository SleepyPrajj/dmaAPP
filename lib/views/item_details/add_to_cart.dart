import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/item_details_model.dart';
import 'package:dma_inc/views/item_details/add_to_cart_listener.dart';
import 'package:dma_inc/views/item_details/quantity_controller.dart';
import 'package:get/get.dart';

class AddToCart extends StatelessWidget {
  final ItemDetails item;
  final String? attributeItemID;

  const AddToCart({super.key, required this.item, this.attributeItemID});

  @override
  Widget build(BuildContext context) {
    final QuantityController quantityController =
        Get.find<QuantityController>();
    String itemID;
    if (attributeItemID == null) {
      itemID = item.id.toString();
    } else {
      itemID = attributeItemID!;
    }
    return GestureDetector(
        child: Container(
      color: dmaRed,
      child: Obx(() {
        return AddToCartListener(
            itemID: itemID,
            quantity: quantityController.quantity.value,
            price: item.price,
            src: item.images[0].src,
            name: item.name);

        // Rebuilds whenever quantityController.quantity changes
        // return PersistentShoppingCart().showAndUpdateCartItemWidget(
        // inCartWidget: "Remove from Cart"
        //     .text
        //     .color(dmaWhite)
        //     .size(25)
        //     .fontFamily(bold)
        //     .make(),
        // notInCartWidget: "Add to cart"
        //     .text
        //     .color(dmaWhite)
        //     .size(25)
        //     .fontFamily(bold)
        //     .make(),
        // product: PersistentShoppingCartItem(
        //   productId: itemID,
        //   productName: item.name,
        //   unitPrice: double.parse(item.price),

        //   quantity: quantityController.quantity.value, // Dynamic quantity
        //   productThumbnail: item.images[0].src,
        // ),
      }),
    ));
  }
}
