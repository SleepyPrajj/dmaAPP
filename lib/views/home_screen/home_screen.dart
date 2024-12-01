import 'package:dma_inc/api_controllers/favs_controller.dart';
import 'package:dma_inc/api_controllers/featured_controller.dart';
import 'package:dma_inc/api_controllers/new_products_controller.dart';
import 'package:dma_inc/api_controllers/sale_controller.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/consts/lists.dart';
import 'package:dma_inc/views/categories_screen/categories_screen.dart';
import 'package:dma_inc/views/home_screen/featured_products.dart';
import 'package:dma_inc/views/home_screen/new_products.dart';
import 'package:dma_inc/views/home_screen/sale_products.dart';
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:dma_inc/widgets_common/categories_button.dart';
import 'package:dma_inc/widgets_common/searchbar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FeaturedController featuredController = Get.put(FeaturedController());
    final SaleController saleController = Get.put(SaleController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final FavController favController = Get.put(FavController());
    final NewProductsController newProductsController =
        Get.put(NewProductsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dmaDarkGrey,
        elevation: 5,
        toolbarHeight: screenHeight * 0.08,
        automaticallyImplyLeading: false,
        title: const Searchbar(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        color: dmaDarkGrey,
        width: screenWidth,
        height: screenHeight,
        child: SafeArea(
          child: Column(
            children: [
              10.heightBox,
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      // Swiper
                      VxSwiper.builder(
                        aspectRatio: screenWidth / screenHeight * 0.9,
                        autoPlay: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 300),
                        height: screenHeight * 0.25,
                        viewportFraction: 1.0,
                        itemCount: swiperList.length,
                        itemBuilder: (context, index) {
                          return Image.network(swiperList[index],
                                  fit: BoxFit.fitWidth)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make()
                              .onTap(() {
                            if (index != 2) {
                              Get.to(CategoriesScreen(
                                  title: swiperListString[index]));
                            } else {
                              Get.to(const ItemScreen(
                                  title:
                                      "XTS-1IN-30MM MULTI-SIZED UNI-MOUNT SCOPE RINGS",
                                  id: 195068));
                            }
                          });
                        },
                      ),
                      10.heightBox,

                      // Categories Title
                      "Categories"
                          .text
                          .fontFamily(thicc)
                          .color(dmaRed)
                          .bold
                          .size(screenWidth * 0.08)
                          .make(),
                      10.heightBox,

                      // Categories Grid
                      Container(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2, // 3 items per row
                          crossAxisSpacing: 10, // Spacing between columns
                          mainAxisSpacing: 10, // Spacing between rows

                          children: [
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2024/10/cat1-2.png',
                                "XTS Products",
                                screenWidth * 0.3),
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2024/10/cat3-2.png',
                                "Personal Security",
                                screenWidth * 0.3),
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2024/10/cat2-2.png',
                                "Tactical Gear",
                                screenWidth * 0.3),
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2024/10/dma-img11-1024x1024-2.jpg',
                                "BlowGuns",
                                screenWidth * 0.3),
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2024/10/cat6-2.png',
                                "Knives",
                                screenWidth * 0.3),
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2024/10/cat4-2.png',
                                "Martial Arts",
                                screenWidth * 0.3),
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2023/06/7inch2-1.jpg',
                                "Uppers",
                                screenWidth * 0.3),
                            catButton(
                                () {},
                                'https://dma-inc.net/wp-content/uploads/2023/08/LPK-308-1-300x300.jpg',
                                "Lowers",
                                screenWidth * 0.3)
                          ],
                        ),
                      ),

                      20.heightBox,

                      // Featured Products Title
                      "Featured Products"
                          .text
                          .fontFamily(thicc)
                          .color(dmaRed)
                          .bold
                          .size(screenWidth * 0.08)
                          .make(),
                      5.heightBox,

                      // Featured Products Grid
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              if (featuredController.isLoading.value) {
                                return Center(
                                  child: LoadingAnimationWidget.dotsTriangle(
                                      color: dmaRed, size: 40),
                                );
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
                                      (index) => FeaturedProducts(
                                              product: featuredController
                                                  .productList[index])
                                          .onTap(() {
                                        Get.to(() => ItemScreen(
                                            title: featuredController
                                                .productList[index].name,
                                            id: featuredController
                                                .productList[index].id));
                                      }),
                                    ),
                                  ),
                                );
                              }
                            }),
                          ],
                        ),
                      ),

                      20.heightBox,

                      // Deals for You! Title
                      "Deals for You!"
                          .text
                          .fontFamily(thicc)
                          .bold
                          .color(dmaRed)
                          .size(screenWidth * 0.08)
                          .make(),
                      15.heightBox,

                      // Deals for You! Products
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Obx(() {
                              if (saleController.isLoading.value) {
                                return Center(
                                  child: LoadingAnimationWidget.dotsTriangle(
                                      color: dmaRed, size: 40),
                                );
                              } else if (saleController.productList.isEmpty) {
                                return const Text('No products on Sale!');
                              } else {
                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: saleController.productList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 18,
                                          crossAxisSpacing: 12,
                                          mainAxisExtent: 325),
                                  itemBuilder: (context, index) {
                                    return SaleProducts(
                                            product: saleController
                                                .productList[index])
                                        .onTap(() {
                                      Get.to(() => ItemScreen(
                                          title: saleController
                                              .productList[index].name,
                                          id: saleController
                                              .productList[index].id));
                                    });
                                  },
                                );
                              }
                            })
                          ],
                        ),
                      ),

                      20.heightBox,

                      "New Products"
                          .text
                          .fontFamily(thicc)
                          .bold
                          .color(dmaRed)
                          .size(screenWidth * 0.08)
                          .make(),
                      15.heightBox,

                      // Deals for You! Products
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Obx(() {
                              if (newProductsController.isLoading.value) {
                                return Center(
                                  child: LoadingAnimationWidget.dotsTriangle(
                                      color: dmaRed, size: 40),
                                );
                              } else if (newProductsController
                                  .productList.isEmpty) {
                                return const Text('No products on Sale!');
                              } else {
                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      newProductsController.productList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 18,
                                          crossAxisSpacing: 12,
                                          mainAxisExtent: 325),
                                  itemBuilder: (context, index) {
                                    return NewProducts(
                                            product: newProductsController
                                                .productList[index])
                                        .onTap(() {
                                      Get.to(() => ItemScreen(
                                          title: newProductsController
                                              .productList[index].name,
                                          id: newProductsController
                                              .productList[index].id));
                                    });
                                  },
                                );
                              }
                            })
                          ],
                        ),
                      ),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
