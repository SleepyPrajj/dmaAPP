import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CartProducts extends StatelessWidget {
  final PersistentShoppingCartItem data;

  CartProducts({Key? key, required this.data}) : super(key: key);

  final PersistentShoppingCart _shoppingCart = PersistentShoppingCart();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        5.heightBox,
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: dmaWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.network(
                data.productThumbnail!,
                height: 100,
                width: 100,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.productName,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: dmaBlack),
                    ),
                    5.heightBox,
                    Row(
                      children: [
                        "\$${data.unitPrice}"
                            .text
                            .size(25)
                            .fontFamily(bold)
                            .make(),
                        const SizedBox(width: 20),
                        20.widthBox,
                        InkWell(
                          onTap: () async {
                            bool removed = await _shoppingCart
                                .removeFromCart(data.productId);
                            if (removed) {
                              // Handle successful removal
                              showSnackBar(context, removed);
                            } else {
                              // Handle the case where if product was not found in the cart
                            }
                          },
                          child: Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2, color: dmaRed),
                            ),
                            child: Center(
                                child: "Remove"
                                    .text
                                    .size(12)
                                    .bold
                                    .fontFamily(regular)
                                    .make()),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      _shoppingCart.incrementCartItemQuantity(data.productId);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                  Text(
                    data.quantity.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  InkWell(
                    onTap: () {
                      _shoppingCart.decrementCartItemQuantity(data.productId);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.remove),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ).onTap(() => Get.to(() =>
        ItemScreen(title: data.productName, id: int.parse(data.productId))));
  }

  void showSnackBar(BuildContext context, bool removed) {
    final snackBar = SnackBar(
      content: Text(
        removed
            ? 'Product removed from cart.'
            : 'Product not found in the cart.',
      ),
      backgroundColor: removed ? Colors.green : Colors.red,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
