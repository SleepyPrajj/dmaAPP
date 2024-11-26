import 'dart:async';
import 'package:dma_inc/views/home_screen/home.dart';
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:dma_inc/views/search_screen/search_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/api_controllers/search_controller.dart' as sch;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchSuggestionScreen extends StatefulWidget {
  const SearchSuggestionScreen({super.key});

  @override
  State<SearchSuggestionScreen> createState() => _SearchSuggestionScreenState();
}

class _SearchSuggestionScreenState extends State<SearchSuggestionScreen> {
  Timer? debounce;
  final sch.SearchController searchController =
      Get.put(sch.SearchController(searchString: ''));

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        searchController.fetchSearch();
      }
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dmaWhite,
      appBar: AppBar(
        backgroundColor: dmaWhite,
        title: TextField(
            autofocus: true,
            onChanged: (value) {
              onSearchChanged(value);
              searchController.searchString = value;
            },
            onSubmitted: (value) {
              Get.to(() => SearchScreen(searchString: value));
            },
            decoration: InputDecoration(
                fillColor: dmaWhite,
                hintText: search,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.search_sharp))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to Home screen when back button is clicked
            Get.offAll(const Home());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            if (searchController.isLoading.value) {
              return Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                      color: dmaRed, size: 40));
            } else if (searchController.productList.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: searchController.productList.length,
                  itemBuilder: (context, index) {
                    var product = searchController.productList[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: product.name.text
                          .size(22)
                          .fontFamily(regular)
                          .semiBold
                          .make(),
                      isThreeLine: false,
                      subtitle: (product.price == ''
                              ? "Call for Pricing"
                              : "\$${product.price}")
                          .text
                          .size(24)
                          .fontFamily(bold)
                          .make(),
                      trailing: Image.network(
                        (product.images.isNotEmpty)
                            ? product.images[0].src
                            : "https://bitsofco.de/img/Qo5mfYDE5v-350.png",
                        height: 100,
                        width: 80,
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                      ),
                      onTap: () {
                        // searchController.searchString = product.name;
                        // searchController.fetchSearch();
                        Get.to(() =>
                            ItemScreen(title: product.name, id: product.id));
                      },
                    );
                  },
                ),
              );
            } else {
              return Center(
                  child: "No Products Found"
                      .text
                      .size(35)
                      .color(dmaRed)
                      .fontFamily(bold)
                      .semiBold
                      .make());
            }
          }),
        ],
      ),
    );
  }
}
