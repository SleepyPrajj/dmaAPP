import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/item_details_model.dart';
import 'package:dma_inc/views/item_details/quantity_controller.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

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
    return Container(
      color: dmaRed,
      child: Obx(() {
        // Rebuilds whenever quantityController.quantity changes
        return PersistentShoppingCart().showAndUpdateCartItemWidget(
          inCartWidget: "Remove from Cart"
              .text
              .color(dmaWhite)
              .size(25)
              .fontFamily(bold)
              .make(),
          notInCartWidget: "Add to cart"
              .text
              .color(dmaWhite)
              .size(25)
              .fontFamily(bold)
              .make(),
          product: PersistentShoppingCartItem(
            productId: itemID,
            productName: item.name,
            unitPrice: double.parse(item.price),

            quantity: quantityController.quantity.value, // Dynamic quantity
            productThumbnail: item.images[0].src,
          ),
        );
      }),
    );
  }
}
