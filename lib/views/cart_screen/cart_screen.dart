import 'dart:io';

import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/cart_screen/checkout_screen.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:dma_inc/views/cart_screen/cart_products.dart';
import 'package:url_launcher/url_launcher.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dmaDarkGrey,
        appBar: AppBar(
          title:
              Center(child: "Cart".text.white.size(26).fontFamily(bold).make()),
          automaticallyImplyLeading: false,
          backgroundColor: dmaDarkGrey,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  child: PersistentShoppingCart().showCartItems(
                    cartTileWidget: ({required data}) =>
                        CartProducts(data: data),
                    showEmptyCartMsgWidget: Center(
                        child: "Cart is Empty"
                            .text
                            .color(dmaWhite)
                            .size(25)
                            .fontFamily(bold)
                            .make()),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: PersistentShoppingCart().showTotalAmountWidget(
          cartTotalAmountWidgetBuilder: (totalAmount) => Visibility(
            visible: totalAmount == 0.0 ? false : true,
            child: Container(
              width: double.infinity,
              color: dmaWhite,
              child: Row(
                children: [
                  Expanded(
                      child: ListTile(
                    title: "Total:"
                        .text
                        .size(20)
                        .color(dmaBlack)
                        .fontFamily(bold)
                        .make(),
                    subtitle: "\$${totalAmount.toStringAsFixed(2)}"
                        .text
                        .size(23)
                        .color(dmaRed)
                        .fontFamily(bold)
                        .bold
                        .make(),
                  )),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        if (totalAmount < 150) {
                          Get.snackbar("Total less then \$150",
                              "Please add more items to make your total amount more than \$150");
                        } else {
                          (Platform.isAndroid)
                              ? Get.to(() => const CheckoutScreen())
                              : buyOnWebsite();
                        }
                      },
                      height: 76,
                      color: dmaRed,
                      child: "Checkout"
                          .text
                          .fontFamily(badSu)
                          .color(dmaWhite)
                          .size(26)
                          .make(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void buyOnWebsite() async {
    Get.snackbar("Going to Website",
        'Due to regualtions by app store, please complete the checkout on our website');
    PersistentShoppingCart().clearCart();
    final Uri url = Uri.parse('https://dma-inc.net/cart');
    if (!await launchUrl(url)) {
      Get.snackbar('error', 'Could not launch $url');
      throw Exception('Could not launch $url');
    }
  }
}
