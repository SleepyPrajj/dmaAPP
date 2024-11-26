// import 'package:dma_inc/models/orders_model.dart' as mod;
// import 'package:dma_inc/consts/consts.dart';
// import 'package:dma_inc/views/item_details/item_details_screen.dart';
// import 'package:get/get.dart';

// class PastOrdersScreen extends StatelessWidget {
//   final mod.OrdersModel order;

//   const PastOrdersScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: "Order Details".text.size(20).fontFamily(bold).make(),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: dmaWhite,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Order Summary",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               "Order ID: ${order.id}"
//                   .text
//                   .size(16)
//                   .fontFamily(regular)
//                   .semiBold
//                   .make(),
//               "Order Date: ${order.dateCreated}"
//                   .text
//                   .size(16)
//                   .fontFamily(regular)
//                   .semiBold
//                   .make(),
//               const SizedBox(height: 16),
//               const Text(
//                 "Delivery Address",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               order.shipping.address1.text
//                   .fontFamily(regular)
//                   .semiBold
//                   .size(16)
//                   .make(),
//               if (order.shipping.address2 != '')
//                 order.shipping.address2.text
//                     .fontFamily(regular)
//                     .semiBold
//                     .size(16)
//                     .make(),
//               const SizedBox(height: 16),
//               const Text(
//                 "Items Ordered",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               ...order.lineItems.map((item) => Card(
//                     elevation: 2,
//                     child: ListTile(
//                       leading:
//                           Image.network(item.image.src, height: 60, width: 60),
//                       title: item.name.text
//                           .size(16)
//                           .fontFamily(badSu)
//                           .semiBold
//                           .make(),
//                       subtitle: "Quantity: ${item.quantity}"
//                           .text
//                           .size(16)
//                           .fontFamily(badSu)
//                           .semiBold
//                           .make(),
//                       trailing: "\$${item.price}"
//                           .text
//                           .size(16)
//                           .fontFamily(badSu)
//                           .semiBold
//                           .make(),
//                     ),
//                   ).onTap(() => Get.to(
//                       ItemScreen(title: item.name, id: item.productId)))),
//               const SizedBox(height: 16),
//               const Text(
//                 "Price Breakdown",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   "Subtotal".text.size(18).fontFamily(regular).semiBold.make(),
//                   "\$${double.parse(order.total) - double.parse(order.shippingTotal) - double.parse(order.totalTax)}"
//                       .text
//                       .size(18)
//                       .fontFamily(regular)
//                       .semiBold
//                       .make(),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Shipping"),
//                   Text("\$${order.shippingTotal}"),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   "Tax".text.size(18).fontFamily(regular).semiBold.make(),
//                   "\$${order.totalTax}"
//                       .text
//                       .size(18)
//                       .fontFamily(regular)
//                       .semiBold
//                       .make(),
//                 ],
//               ),
//               const Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Total",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "\$${order.total}",
//                     style: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:dma_inc/models/orders_model.dart' as mod;
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:get/get.dart';

class PastOrdersScreen extends StatelessWidget {
  final mod.OrdersModel order;

  const PastOrdersScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Order Details".text.size(20).fontFamily(bold).make(),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: dmaWhite,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              "Order ID: ${order.id}"
                  .text
                  .size(16)
                  .fontFamily(regular)
                  .semiBold
                  .make(),
              "Order Date: ${order.dateCreated}"
                  .text
                  .size(16)
                  .fontFamily(regular)
                  .semiBold
                  .make(),
              const SizedBox(height: 16),
              const Text(
                "Delivery Address",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              order.shipping.address1.text
                  .fontFamily(regular)
                  .semiBold
                  .size(16)
                  .make(),
              if (order.shipping.address2 != '')
                order.shipping.address2.text
                    .fontFamily(regular)
                    .semiBold
                    .size(16)
                    .make(),
              const SizedBox(height: 16),
              const Text(
                "Items Ordered",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...order.lineItems.map((item) => Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            item.image.src,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                item.name.text
                                    .size(16)
                                    .maxLines(3)
                                    .fontFamily(badSu)
                                    .semiBold
                                    .overflow(TextOverflow.ellipsis)
                                    .make(),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    "Quantity: ${item.quantity}"
                                        .text
                                        .size(14)
                                        .fontFamily(badSu)
                                        .make(),
                                    10.widthBox,
                                    "Product ID: #${item.productId}"
                                        .text
                                        .size(13)
                                        .fontFamily(badSu)
                                        .make()
                                  ],
                                ),
                              ],
                            ),
                          ),
                          "\$${item.price}"
                              .text
                              .size(16)
                              .fontFamily(badSu)
                              .semiBold
                              .make(),
                          10.heightBox,
                        ],
                      ),
                    ),
                  ).onTap(() => Get.to(
                      ItemScreen(title: item.name, id: item.productId)))),
              const SizedBox(height: 16),
              const Text(
                "Price Breakdown",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Subtotal".text.size(18).fontFamily(regular).semiBold.make(),
                  "\$${double.parse(order.total) - double.parse(order.shippingTotal) - double.parse(order.totalTax)}"
                      .text
                      .size(18)
                      .fontFamily(regular)
                      .semiBold
                      .make(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Shipping"),
                  Text("\$${order.shippingTotal}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Tax".text.size(18).fontFamily(regular).semiBold.make(),
                  "\$${order.totalTax}"
                      .text
                      .size(18)
                      .fontFamily(regular)
                      .semiBold
                      .make(),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${order.total}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
