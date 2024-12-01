import 'package:dma_inc/api_controllers/buy_again_controller.dart';
import 'package:dma_inc/views/auth_screen/login_screen.dart';
import 'package:dma_inc/views/profile_screen/account_details_screen.dart';
import 'package:dma_inc/views/profile_screen/addresses_screen.dart';
import 'package:dma_inc/views/profile_screen/buy_again_products.dart';
import 'package:dma_inc/views/profile_screen/catalog_screen.dart';
import 'package:dma_inc/views/profile_screen/delete_account.dart';
import 'package:dma_inc/views/profile_screen/your_orders_screen.dart';
import 'package:dma_inc/widgets_common/bg_widget.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GetStorage storage = GetStorage();
    BuyAgainController buyAgainController = Get.put(BuyAgainController());

    int productIndex = 0;
    int itemIndex = 0;
    return Scaffold(
      body: bgWidget(
        SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  15.heightBox,
                  Row(
                    children: [
                      15.heightBox,
                      Image.network(
                        storage.read('avatar_url'),
                        width: 65,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${storage.read('user_display_name')}"
                                .text
                                .fontFamily(regular)
                                .semiBold
                                .color(dmaWhite)
                                .make(),
                            5.heightBox,
                            "${storage.read('user_email')}"
                                .text
                                .color(dmaWhite)
                                .maxLines(1)
                                .make()
                          ],
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: dmaWhite,
                          ),
                        ),
                        onPressed: () async {
                          final shouldLogout = await Get.dialog<bool>(
                            AlertDialog(
                              title: const Text("Confirm Logout"),
                              content: const Text(
                                  "Are you sure you want to log out?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: const Text("Logout"),
                                ),
                              ],
                            ),
                          );

                          if (shouldLogout == true) {
                            await GetStorage().remove('token');
                            await GetStorage().remove('user_email');
                            Get.offAll(() => const Login());
                          }
                        },
                        child: "logout"
                            .text
                            .fontFamily(regular)
                            .semiBold
                            .white
                            .make(),
                      ),
                    ],
                  ),
                  30.heightBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      "Your Orders"
                          .text
                          .color(dmaWhite)
                          .bold
                          .size(25)
                          .align(TextAlign.left)
                          .fontFamily(bold)
                          .make()
                          .onTap(() {
                        Get.to(() => const YourOrdersScreen());
                      }),
                      const Divider(thickness: 2),
                      InkWell(
                        onTap: () {
                          Get.to(() => const CatalogScreen());
                        },
                        child: "Catalog"
                            .text
                            .color(dmaWhite)
                            .bold
                            .size(25)
                            .align(TextAlign.left)
                            .fontFamily(bold)
                            .make(),
                      ),
                      const Divider(thickness: 2),
                      InkWell(
                        onTap: () {
                          Get.to(() => const AccountDetailsScreen());
                        },
                        child: "Account Details"
                            .text
                            .color(dmaWhite)
                            .bold
                            .size(25)
                            .align(TextAlign.left)
                            .fontFamily(bold)
                            .make(),
                      ),
                      const Divider(thickness: 2),
                      InkWell(
                        onTap: () {
                          Get.to(() => const AddressUpdateScreen());
                        },
                        child: "Addresses"
                            .text
                            .color(dmaWhite)
                            .bold
                            .size(25)
                            .align(TextAlign.left)
                            .fontFamily(bold)
                            .make(),
                      ),
                      const Divider(thickness: 2),
                      InkWell(
                        onTap: () {
                          Get.to(() => const DeleteAccount());
                        },
                        child: "Delete Account!"
                            .text
                            .color(dmaWhite)
                            .bold
                            .size(25)
                            .align(TextAlign.left)
                            .fontFamily(bold)
                            .make(),
                      ),
                      const Divider(thickness: 2),
                      10.heightBox,
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
                          print(buyAgainController.isLoading.value);
                          return Column(children: [
                            Container(
                              color: dmaDarkGrey,
                              child: Center(
                                  child: LoadingAnimationWidget.fallingDot(
                                      color: dmaWhite, size: 60)),
                            ),
                            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                .text
                                .make()
                          ]);
                        }
                        if (buyAgainController.productList.isEmpty) {
                          return "No items available.\nBuy Some :D\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                              .text
                              .fontFamily(bold)
                              .size(16)
                              .color(dmaWhite)
                              .center
                              .makeCentered();
                        }

                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 12,
                                  mainAxisExtent: 325),
                          itemCount: buyAgainController.productList.length,
                          itemBuilder: (context, index) {
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
                                  .productList[productIndex]
                                  .lineItems[itemIndex],
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
