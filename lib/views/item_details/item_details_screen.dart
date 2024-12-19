import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dma_inc/controller/home_controller.dart';
import 'package:dma_inc/views/home_screen/home.dart';
import 'package:dma_inc/views/item_details/quantity_controller.dart';
import 'package:dma_inc/widgets_common/searchbar.dart';
import 'package:get/get.dart';
import 'package:dma_inc/api_controllers/item_controller.dart';
import 'package:dma_inc/api_controllers/featured_controller.dart';
import 'package:dma_inc/api_controllers/sale_controller.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/item_details/attributes_button.dart';
import 'package:dma_inc/views/item_details/details_getter.dart';
import 'package:dma_inc/views/item_details/add_to_cart.dart';
import 'package:dma_inc/views/item_details/featured_view.dart';
import 'package:dma_inc/views/item_details/sales_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemScreen extends StatefulWidget {
  final String? title;
  final int id;

  const ItemScreen({Key? key, required this.title, required this.id})
      : super(key: key);

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late ItemController itemController;
  final FeaturedController featuredController = Get.put(FeaturedController());
  final SaleController saleController = Get.put(SaleController());
  // ignore: unused_local_variable
  final QuantityController quantityController = Get.put(QuantityController());

  // Track selected options for each attribute by attribute index
  final Map<int, String> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    itemController = Get.put(ItemController(itemID: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String? attributeItemID;
    return Scaffold(
        backgroundColor: dmaWhite,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          title: Row(
            children: [
              const Expanded(child: Searchbar()),
              const SizedBox(width: 8),
              PersistentShoppingCart()
                  .showCartItemCountWidget(
                cartItemCountWidgetBuilder: (itemCount) => Badge(
                  label: Text(itemCount.toString()),
                  child: Image.asset(
                    icCart,
                    width: 26,
                    color: dmaBlack,
                  ),
                ),
              )
                  .onTap(() {
                HomeController homeController = Get.find<HomeController>();
                homeController.currentNavIndex.value = 2;
                Get.to(() => const Home());
              }),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Obx(() {
                        if (itemController.productString.value == null) {
                          return Column(
                            children: [
                              "\n\n\n\n\n".text.make(),
                              LoadingAnimationWidget.dotsTriangle(
                                      color: dmaRed, size: 60)
                                  .centered(),
                              "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                  .text
                                  .make()
                            ],
                          );
                        } else {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailsGetter(
                                    item: itemController.productString.value!),
                                if (itemController.productString.value!
                                        .attributes.isNotEmpty &&
                                    itemController.productString.value!
                                            .attributes[0].variation ==
                                        true)
                                  ...itemController
                                      .productString.value!.attributes
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    final attribute = entry.value;

                                    return AttributesButton(
                                      attribute: attribute,
                                      selectedOption: selectedOptions[index],
                                      onOptionSelected: (option) {
                                        setState(() {
                                          selectedOptions[index] = option;
                                          attributeItemID = itemController
                                              .productString
                                              .value!
                                              .variations[index]
                                              .toString();
                                        });
                                      },
                                    );
                                  }).toList(),
                              ]);
                        }
                      }),
                    ),
                    Container(
                        width: screenWidth,
                        color: dmaDarkGrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenWidth * 0.025),
                            " Featured Products:"
                                .text
                                .size(screenWidth * 0.05)
                                .fontFamily(regular)
                                .bold
                                .color(dmaWhite)
                                .make(),
                            SizedBox(height: screenWidth * 0.04),
                            Obx(() {
                              if (featuredController.isLoading.value) {
                                return Center(
                                    child: LoadingAnimationWidget.dotsTriangle(
                                        color: dmaRed, size: 40));
                              } else if (featuredController
                                  .productList.isEmpty) {
                                return const Text(
                                    'No featured products available');
                              } else {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      featuredController.productList.length,
                                      (index) => FeaturedView(
                                              product: featuredController
                                                  .productList[index])
                                          .onTap(() => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  Get.delete<ItemController>();
                                                  return ItemScreen(
                                                    title: featuredController
                                                        .productList[index]
                                                        .name,
                                                    id: featuredController
                                                        .productList[index].id,
                                                  );
                                                }),
                                              )),
                                    ),
                                  ),
                                );
                              }
                            }),
                            SizedBox(height: screenWidth * 0.05),
                            "Deals for YOU:"
                                .text
                                .size(screenWidth * 0.05)
                                .fontFamily(regular)
                                .bold
                                .color(dmaWhite)
                                .make(),
                            SizedBox(height: screenWidth * 0.04),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  saleController.productList.length,
                                  (index) => SalesView(
                                          product:
                                              saleController.productList[index])
                                      .onTap(() => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              Get.delete<ItemController>();
                                              return ItemScreen(
                                                title: saleController
                                                    .productList[index].name,
                                                id: saleController
                                                    .productList[index].id,
                                              );
                                            }),
                                          )),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
            height: screenWidth * 0.12, // Scale button height
            width: double.infinity,
            child: Obx(() {
              if (itemController.productString.value == null) {
                return Container(
                    color: dmaWhite, height: 1, child: const Center());
              } else if (itemController.productString.value!.price == '') {
                return Container(
                  color: dmaRed,
                  child: Center(
                          child: "Call us for Pricing"
                              .text
                              .white
                              .size(30)
                              .bold
                              .fontFamily(bold)
                              .make())
                      .onTap(() {
                    _launchCaller();
                  }),
                );
              } else {
                return AddToCart(
                  item: itemController.productString.value!,
                  attributeItemID: attributeItemID,
                );
              }
            })));
  }

  Future<void> addToCartApiCall(String itemID, int quantity) async {
    const String apiUrl = "https://dma-inc.net/wp-json/cocart/v1/add-item";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              GetStorage().read('token'), // Replace with your token
        },
        body: jsonEncode({
          "product_id": itemID,
          "quantity": quantity,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        Get.snackbar("Success", "Item added to cart!");
        log("API Response: $responseBody");
      } else {
        log("Failed to add to cart: ${response.statusCode}");
        log("Response body: ${response.body}");
        Get.snackbar("Error", "Failed to add item to cart.");
      }
    } catch (e) {
      log("Error during API call: $e");
      Get.snackbar("Error", "Something went wrong.");
    }
  }

  _launchCaller() async {
    const url = "tel:+1-817-633-6123";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
