import 'package:dma_inc/api_controllers/buy_again_controller.dart';
import 'package:dma_inc/api_controllers/past_three_months_controller.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/profile_screen/buy_again_products.dart';
import 'package:dma_inc/views/profile_screen/your_orders.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class YourOrdersScreen extends StatelessWidget {
  const YourOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int productIndex = 0;
    int itemIndex = 0;
    BuyAgainController buyAgainController = Get.find<BuyAgainController>();
    PastThreeMonthsController pastThreeMonthsController =
        Get.put(PastThreeMonthsController());
    return Scaffold(
      appBar: AppBar(
        title: "Your Orders"
            .text
            .size(25)
            .color(dmaWhite)
            .fontFamily(bold)
            .semiBold
            .make(),
        iconTheme: const IconThemeData(color: dmaWhite),
        backgroundColor: dmaDarkGrey,
      ),
      backgroundColor: dmaDarkGrey,
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            "Buy Again!"
                .text
                .color(dmaRed)
                .fontFamily(badSu)
                .size(30)
                .widest
                .bold
                .make(),
            10.heightBox,
            Obx(() {
              if (buyAgainController.isLoading.value) {
                return Center(
                  child: LoadingAnimationWidget.fallingDot(
                    color: dmaWhite,
                    size: 60,
                  ),
                );
              }

              if (buyAgainController.productList.isEmpty) {
                return "\nNo items available.\nBuy Some :D\n\n"
                    .text
                    .fontFamily(bold)
                    .size(16)
                    .color(dmaWhite)
                    .center
                    .makeCentered();
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        buyAgainController.productList.length, (index) {
                      if (itemIndex ==
                              buyAgainController.productList[productIndex]
                                      .lineItems.length -
                                  1 &&
                          productIndex <
                              buyAgainController.productList.length) {
                        itemIndex = -1;
                        productIndex++;
                      }
                      itemIndex++;
                      return BuyAgainProducts(
                          product: buyAgainController
                              .productList[productIndex].lineItems[itemIndex]);
                    }),
                  ),
                );
              }
            }),
            10.heightBox,
            const Divider(
              thickness: 1,
            ),
            "Past three Months".text.size(20).white.make(),
            const Divider(
              thickness: 1,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Obx(() {
                if (pastThreeMonthsController.isLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: dmaWhite,
                      size: 40,
                    ),
                  );
                }

                if (pastThreeMonthsController.productList.isEmpty) {
                  return "No orders yet!\nBuy Some :D"
                      .text
                      .size(16)
                      .fontFamily(bold)
                      .color(dmaWhite)
                      .center
                      .makeCentered();
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: List.generate(
                          pastThreeMonthsController.productList.length,
                          (index) {
                        return YourOrders(
                          orders: pastThreeMonthsController.productList[index],
                        );
                      }),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
