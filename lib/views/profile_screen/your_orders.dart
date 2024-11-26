import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/orders_model.dart' as mod;
import 'package:dma_inc/views/profile_screen/past_orders_screen.dart';
import 'package:get/get.dart';

class YourOrders extends StatelessWidget {
  final mod.OrdersModel orders;
  const YourOrders({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: dmaDarkGrey,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            // Display the first item image
            Image.network(
              orders.lineItems[0].image.src,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            16.widthBox, // Spacer
            // Order details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Price
                  Text(
                    'Total Price: \$${orders.total}',
                    style: const TextStyle(
                        color: dmaWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  // Payment Method
                  Text(
                    'Order Status: ${orders.status}',
                    style: const TextStyle(color: dmaWhite, fontSize: 14),
                  ),
                  // Total Items Ordered
                  Text(
                    'Total Items: ${orders.lineItems.length}',
                    style: const TextStyle(color: dmaWhite, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).onTap(() {
        Get.to(() => PastOrdersScreen(order: orders));
      }),
    );
  }
}
