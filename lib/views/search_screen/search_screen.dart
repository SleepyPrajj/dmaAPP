import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/api_controllers/search_controller.dart' as sch;
import 'package:dma_inc/controller/home_controller.dart';
import 'package:dma_inc/views/home_screen/home.dart';
import 'package:dma_inc/widgets_common/pagination_widget.dart';
import 'package:dma_inc/widgets_common/search_tile.dart';
import 'package:dma_inc/widgets_common/searchbar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

// class SearchScreen extends StatelessWidget {
//   final String searchString;

//   const SearchScreen({Key? key, required this.searchString}) : super(key: key);

//   void _showSortByMenu(BuildContext context) {
//     final controller = Get.find<sch.SearchController>();
//     String? sortby;
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               "SORT BY".text.size(20).fontFamily(badSu).make(),
//               ListTile(
//                 leading: const Icon(Icons.whatshot, color: Colors.red),
//                 title: const Text("Popularity"),
//                 trailing: controller.selectedSort == "popularity"
//                     ? const Icon(Icons.check, color: Colors.red)
//                     : null,
//                 onTap: () {
//                   Navigator.pop(context);
//                   sortby = 'popularity';
//                   controller.updateSort(sortby!);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.new_releases, color: Colors.blue),
//                 title: const Text("Latest"),
//                 trailing: controller.selectedSort == "date"
//                     ? const Icon(Icons.check, color: Colors.blue)
//                     : null,
//                 onTap: () {
//                   Navigator.pop(context);
//                   sortby = 'date';
//                   controller.updateSort(sortby!);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.timelapse, color: Colors.blueGrey),
//                 title: const Text("Oldest"),
//                 trailing: controller.selectedSort == "Odate"
//                     ? const Icon(Icons.check, color: Colors.blueGrey)
//                     : null,
//                 onTap: () {
//                   Navigator.pop(context);
//                   sortby = 'Odate';

//                   controller.updateSort(sortby!);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.arrow_downward, color: Colors.green),
//                 title: const Text("Price low to high"),
//                 trailing: controller.selectedSort == "Lprice"
//                     ? const Icon(Icons.check, color: Colors.green)
//                     : null,
//                 onTap: () {
//                   Navigator.pop(context);
//                   sortby = 'Lprice';

//                   controller.updateSort(sortby!);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.arrow_upward, color: Colors.green),
//                 title: const Text("Price high to low"),
//                 trailing: controller.selectedSort == "price"
//                     ? const Icon(Icons.check, color: Colors.green)
//                     : null,
//                 onTap: () {
//                   Navigator.pop(context);
//                   Future.delayed(const Duration(milliseconds: 50), () {
//                     ScrollController().animateTo(
//                       0,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   });
//                   sortby = 'price';

//                   controller.updateSort(sortby!);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final sch.SearchController searchController =
//         Get.put(sch.SearchController(searchString: searchString));
//     ScrollController scrollController = ScrollController();

//     return Scaffold(
//         backgroundColor: dmaDarkGrey,
//         appBar: AppBar(
//           title: Row(
//             children: [
//               const Expanded(child: Searchbar()),
//               const SizedBox(width: 8),
//               PersistentShoppingCart()
//                   .showCartItemCountWidget(
//                 cartItemCountWidgetBuilder: (itemCount) => Badge(
//                   label: Text(itemCount.toString()),
//                   child: Image.asset(
//                     icCart,
//                     width: 26,
//                     color: dmaBlack,
//                   ),
//                 ),
//               )
//                   .onTap(() {
//                 HomeController homeController = Get.find<HomeController>();
//                 homeController.currentNavIndex.value = 2;
//                 Get.to(() => const Home());
//               }),
//             ],
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: CustomScrollView(
//             controller: scrollController,
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               // Title and Search String

//               SliverPadding(
//                 padding: const EdgeInsets.all(12),
//                 sliver: SliverList(
//                   delegate: SliverChildListDelegate([
//                     10.heightBox,
//                     searchString.text
//                         .size(35)
//                         .color(dmaRed)
//                         .fontFamily(badSu)
//                         .make(),
//                     15.heightBox,
//                   ]),
//                 ),
//               ),

//               // GridView wrapped in SliverGrid for scrollable grid content
//               Obx(() {
//                 if (searchController.isLoading.value) {
//                   return SliverFillRemaining(
//                     child: LoadingAnimationWidget.dotsTriangle(
//                         color: dmaRed, size: 40),
//                   );
//                 }

//                 if (searchController.productList.isEmpty) {
//                   return const SliverFillRemaining(
//                     child: Center(child: Text('No products found')),
//                   );
//                 }

//                 return SliverGrid(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       return SearchTile(searchController.productList[index]);
//                     },
//                     childCount: searchController.productList.length,
//                   ),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 18,
//                     crossAxisSpacing: 12,
//                     mainAxisExtent: 325,
//                   ),
//                 );
//               }),
//               Obx(() {
//                 if (searchController.isLoading.value) {
//                   return SliverFillRemaining(
//                     child: LoadingAnimationWidget.dotsTriangle(
//                         color: dmaRed, size: 40),
//                   );
//                 } else {
//                   return SliverToBoxAdapter(
//                     child: Center(
//                       child: PaginationWidget(
//                         totalPages: searchController.totalPages,
//                         currentPage: searchController.currentPage,
//                         onPageSelected: (page) {
//                           searchController.fetchProductsByPage(page);
//                           scrollController.animateTo(
//                             0,
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 }
//               })
//             ],
//           ),
//         ),
//         bottomNavigationBar: Obx(() {
//           if (searchController.isLoading.value) {
//             return Container(
//               color: dmaDarkGrey,
//               height: 1,
//               width: double.infinity,
//             );
//           } else {
//             return Container(
//               height: MediaQuery.of(context).size.height * 0.06,
//               width: MediaQuery.of(context).size.width,
//               color: dmaWhite,
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.sort, color: dmaDarkGrey),
//                           const SizedBox(width: 4),
//                           "Sort"
//                               .text
//                               .size(18)
//                               .fontWeight(FontWeight.bold)
//                               .fontFamily(badSu)
//                               .color(dmaDarkGrey)
//                               .make(),
//                         ],
//                       ).onTap(() {
//                         _showSortByMenu(context);
//                       }),
//                     ),
//                   ]),
//             );
//           }
//         }));
//   }
// }

class SearchScreen extends StatefulWidget {
  final String searchString;

  const SearchScreen({Key? key, required this.searchString}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ScrollController scrollController;
  late sch.SearchController searchController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    searchController =
        Get.put(sch.SearchController(searchString: widget.searchString));
  }

  void _showSortByMenu(BuildContext context) {
    final controller = Get.find<sch.SearchController>();
    String? sortby;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              "SORT BY".text.size(20).fontFamily(badSu).make(),
              ListTile(
                leading: const Icon(Icons.whatshot, color: Colors.red),
                title: const Text("Popularity"),
                trailing: controller.selectedSort == "popularity"
                    ? const Icon(Icons.check, color: Colors.red)
                    : null,
                onTap: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  Navigator.pop(context);
                  sortby = 'popularity';
                  controller.updateSort(sortby!);
                },
              ),
              ListTile(
                leading: const Icon(Icons.new_releases, color: Colors.blue),
                title: const Text("Latest"),
                trailing: controller.selectedSort == "date"
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  Navigator.pop(context);
                  sortby = 'date';
                  controller.updateSort(sortby!);
                },
              ),
              ListTile(
                leading: const Icon(Icons.timelapse, color: Colors.blueGrey),
                title: const Text("Oldest"),
                trailing: controller.selectedSort == "Odate"
                    ? const Icon(Icons.check, color: Colors.blueGrey)
                    : null,
                onTap: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  Navigator.pop(context);
                  sortby = 'Odate';
                  controller.updateSort(sortby!);
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_downward, color: Colors.green),
                title: const Text("Price low to high"),
                trailing: controller.selectedSort == "Lprice"
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  Navigator.pop(context);
                  sortby = 'Lprice';
                  controller.updateSort(sortby!);
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_upward, color: Colors.green),
                title: const Text("Price high to low"),
                trailing: controller.selectedSort == "price"
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  Navigator.pop(context);
                  sortby = 'price';
                  controller.updateSort(sortby!);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dmaDarkGrey,
        appBar: AppBar(
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    10.heightBox,
                    widget.searchString.text
                        .size(35)
                        .color(dmaRed)
                        .fontFamily(badSu)
                        .make(),
                    15.heightBox,
                  ]),
                ),
              ),
              Obx(() {
                if (searchController.isLoading.value) {
                  return SliverFillRemaining(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: dmaRed, size: 40),
                  );
                }

                if (searchController.productList.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No products found')),
                  );
                }

                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return SearchTile(searchController.productList[index]);
                    },
                    childCount: searchController.productList.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 325,
                  ),
                );
              }),
              Obx(() {
                if (searchController.isLoading.value) {
                  return SliverFillRemaining(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: dmaRed, size: 40),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: PaginationWidget(
                        totalPages: searchController.totalPages,
                        currentPage: searchController.currentPage,
                        onPageSelected: (page) {
                          searchController.fetchProductsByPage(page);
                          scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  );
                }
              })
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          if (searchController.isLoading.value) {
            return Container(
              color: dmaDarkGrey,
              height: 1,
              width: double.infinity,
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              color: dmaWhite,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sort, color: dmaDarkGrey),
                          const SizedBox(width: 4),
                          "Sort"
                              .text
                              .size(18)
                              .fontWeight(FontWeight.bold)
                              .fontFamily(badSu)
                              .color(dmaDarkGrey)
                              .make(),
                        ],
                      ).onTap(() {
                        _showSortByMenu(context);
                      }),
                    ),
                  ]),
            );
          }
        }));
  }
}
