import 'dart:io';

import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/services/add_to_cart_call.dart';
import 'package:dma_inc/services/remove_item_from_dart.dart';
import 'package:hive/hive.dart';
import 'package:persistent_shopping_cart/controller/cart_controller.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart' as pers;

class AddToCartListener extends StatelessWidget {
  final String itemID;
  final int quantity;
  final String name;
  final String price;
  final String src;
  const AddToCartListener(
      {super.key,
      required this.itemID,
      required this.quantity,
      required this.price,
      required this.src,
      required this.name});

  @override
  Widget build(BuildContext context) {
    final pers.PersistentShoppingCart persistentShoppingCart =
        pers.PersistentShoppingCart();
    return ValueListenableBuilder<Box<PersistentShoppingCartItem>>(
      valueListenable: CartController().cartListenable,
      builder: (context, box, child) {
        bool existsInCart = CartController().isItemExistsInCart(itemID);
        return IconButton(
          onPressed: () async {
            if (existsInCart) {
              if (Platform.isIOS) {
                await removeItemFromCart(itemID);
              }
              await persistentShoppingCart.removeFromCart(itemID);
            } else {
              if (Platform.isIOS) {
                addToCartApiCall(itemID, quantity);
              }
              await persistentShoppingCart.addToCart(
                PersistentShoppingCartItem(
                  productId: itemID,
                  productName: name,
                  unitPrice: double.parse(price),
                  quantity: quantity,
                  productThumbnail: src,
                ),
              );
            }
          },
          icon: existsInCart
              ? "Remove from Cart"
                  .text
                  .color(dmaWhite)
                  .size(25)
                  .fontFamily(bold)
                  .make()
              : "Add to cart"
                  .text
                  .color(dmaWhite)
                  .size(25)
                  .fontFamily(bold)
                  .make(),
        );
      },
    );
  }
}
