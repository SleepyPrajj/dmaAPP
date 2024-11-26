import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/api_controllers/categories_controller.dart';
import 'package:dma_inc/controller/home_controller.dart';
import 'package:dma_inc/views/home_screen/home.dart';
import 'package:dma_inc/widgets_common/pagination_widget.dart';
import 'package:dma_inc/widgets_common/product_tile.dart';
import 'package:dma_inc/widgets_common/searchbar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class CategoriesScreen extends StatefulWidget {
  final String? title;
  final String? sortby;
  const CategoriesScreen({Key? key, required this.title, this.sortby})
      : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? selectedCategory;
  String? selectedMainCategory; // Track selected main category
  String? selectedSubcategory; // Track selected subcategory
  String? selectedStockStatus;
  late ScrollController scrollController;
  String? categoryID;
  String? stockStatus;
  String? sortby;
  RxBool showfilter = true.obs;
  String? subCategoryID;
  bool areFiltersApplied = false;
  bool subcategoriesVisible = false;
  bool coloredSubcategory = false;
  RangeValues? newPriceRange;
  RangeValues priceRange = const RangeValues(1, 1000); // Initial price range
  late Map<String, Map<String, String>> filterOptionsMap;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    filterOptionsMap = getFilterOptionsMap(widget.title);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Map<String, Map<String, String>> getFilterOptionsMap(String? title) {
    if (widget.title == "XTS Products") {
      return {
        "Categories": {
          "All Gun Parts": gunPartsFilter,
          "AR 15": arFifteenPartsFilter,
          "AR 10": arTenPartsFilter,
          "AK 47": akPartsFilter,
          "GLOCK®": glockPartsFilter,
          "Gun Accessories": gunAccessoriesFilter
        },
        "Subcategories": {},
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else if (widget.title == "Martial Arts") {
      return {
        "Categories": {
          "Ninja Gear": ninjaGear,
          "Nunchuks": nunchuks,
          "Throwing Knife": throwingKnives,
          "Throwing Star": throwingStars
        },
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else if (widget.title == "BlowGuns") {
      return {
        "Categories": {
          "Blowguns": blowgunsCat,
          "Blowguns & Crossbows": blowGunsAndCrossbows,
          "Blowgun accessories": tagBlowgunAccessories
        },
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else if (widget.title == "Tactical Gear") {
      return {
        "Categories": {
          "Backpacks": backPacks,
          "Range Bags": rangeBags,
          "Vests": vests,
          "Plates": plates,
          "Gloves": gloves,
          "Stockings": stockings
        },
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else if (widget.title == "Personal Security") {
      return {
        "Categories": {
          "\$5 and Under Security Products": fiveandUnderSecItem,
          "Batons": batons,
          "Bullet proof vests": tagBulletProofVests,
          "Knuckles": knuckles,
          "Kubotans": kubotans,
          "Monkey Fist": monkeyFists,
          "Pepper Spray": pepperSpray,
          "Stun Guns": stunGunsCat,
          "Tactical Bags": tagTacticalBag,
          "Vests": vests
        },
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else if (widget.title == "Knives") {
      return {
        "Categories": {
          "\$5 and Under Knives": fiveandUnderKnives,
          "Automatic Knives": autoKnives,
          "Butterfly Knives": butterFlyKnives,
          "Fixed Blade Knives": fixedBladeKnives,
          "Machetes": machetes,
          "Manual Folding Knives": manualFoldingKnives,
          "OTF Knives": oTFKnives,
          "Spring Assisted Knives": springAssistedKnives,
          "Stilettos": stiletto,
          "Throwing Knives": throwingKnives,
          "Throwing Stars": throwingKnives
        },
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else if (widget.title == 'Uppers') {
      return {
        "Categories": {
          "AR 15 Uppers": arFifteenCompleteUpper,
          "AR 10 Uppers": arTenUpperParts,
        },
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else if (widget.title == 'Lowers') {
      return {
        "Categories": {
          "AR 15 Lowers": gunLowerPartsKit,
          "AR 10 Lowers": arTenLowerPartsKit,
          "GLOCK®": glockLowerPartsKit
        },
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    } else {
      showfilter(false);
      return {
        "Categories": {
          "Default Category 1": "id_for_default_category_1",
          "Default Category 2": "id_for_default_category_2"
        },
        "Subcategories": {},
        "Price Range": {},
        "Stock Status": {"In Stock": "instock", "Out of Stock": "outofstock"},
      };
    }
  }

  void _showFilterMenu(BuildContext context) {
    final controller = Get.find<CategoriesController>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  // Filter Menu Header
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "FILTERS",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // Reset selections
                            setState(() {
                              selectedMainCategory = null;
                              selectedSubcategory = null;
                              selectedCategory = ""; // Reset selected category
                              subcategoriesVisible = false;
                              filterOptionsMap["Subcategories"] = {};
                              priceRange = const RangeValues(1, 1000);
                              areFiltersApplied = false;
                            });
                            Navigator.pop(context); // Close the filter menu

                            // Navigate back to CategoriesScreen to trigger a complete rebuild
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoriesScreen(title: widget.title)),
                            );
                          },
                          child: const Text("CLEAR ALL",
                              style: TextStyle(color: dmaRed, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 170,
                          color: Colors.grey.shade300,
                          child: ListView(
                            children: filterOptionsMap.keys.where((category) {
                              // Conditionally show "Subcategories"
                              if (category == "Subcategories") {
                                return subcategoriesVisible;
                              }
                              return true;
                            }).map((category) {
                              return _buildFilterCategory(category, () {
                                setState(() {
                                  selectedCategory = category;

                                  if (category == "Subcategories" &&
                                      selectedMainCategory != null) {
                                    subcategoriesVisible = true;
                                    coloredSubcategory = true;
                                  } else {}
                                });
                              });
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                              padding: const EdgeInsets.all(16),
                              children: [
                                if (selectedCategory == "Price Range")
                                  Column(
                                    children: [
                                      const Text(
                                          "Set Price Range (\$1 - \$1000)"),
                                      RangeSlider(
                                        values: priceRange,
                                        min: 1,
                                        max: 1000,
                                        divisions: 100,
                                        labels: RangeLabels(
                                          "\$${priceRange.start.toStringAsFixed(0)}",
                                          "\$${priceRange.end.toStringAsFixed(0)}",
                                        ),
                                        onChanged: (newRange) {
                                          setState(() {
                                            priceRange = newRange;
                                            newRange = priceRange;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ...filterOptionsMap[selectedCategory]
                                        ?.entries
                                        .map((entry) {
                                      final optionKey = entry.key;
                                      return _buildFilterOption(optionKey, () {
                                        setState(() {
                                          if (selectedCategory ==
                                                  "Categories" &&
                                              widget.title == 'XTS Products') {
                                            selectedMainCategory = optionKey;
                                            subcategoriesVisible = true;
                                            filterOptionsMap["Subcategories"] =
                                                _getSubcategoriesFor(optionKey);
                                          } else if (selectedCategory ==
                                              "Categories") {
                                            selectedMainCategory = optionKey;
                                          } else if (selectedCategory ==
                                              "Subcategories") {
                                            selectedSubcategory = optionKey;
                                          } else if (selectedCategory ==
                                              "Stock Status") {
                                            selectedStockStatus = optionKey;
                                          }
                                        });
                                      });
                                    }) ??
                                    [],
                              ]),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("CLOSE",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            scrollController.animateTo(
                              0, // Scroll position at the top
                              duration: const Duration(
                                  milliseconds: 300), // Duration of the scroll
                              curve: Curves.easeInOut, // Animation curve
                            );
                            categoryID =
                                getFilterOptionsMap(widget.title)['Categories']
                                    ?[selectedMainCategory];
                            // if(selectedSubcategory!=null)
                            subCategoryID = _getSubcategoriesFor(
                                selectedMainCategory!)[selectedSubcategory];
                            stockStatus = getFilterOptionsMap(widget.title)[
                                'Stock Status']?[selectedStockStatus];
                            areFiltersApplied = true;
                            controller.updateFilters(categoryID, subCategoryID,
                                stockStatus, priceRange, '');
                            Navigator.pop(context);
                          },
                          style:
                              ElevatedButton.styleFrom(backgroundColor: dmaRed),
                          child: const Text("Apply",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterCategory(String categoryTitle, VoidCallback onTap) {
    bool hasSelection = false;

    if (categoryTitle == "Categories" && selectedMainCategory != null) {
      hasSelection = true;
      coloredSubcategory = true;
    } else if (categoryTitle == "Subcategories" &&
        selectedSubcategory != null) {
      hasSelection = true;
    } else if (categoryTitle == "Stock Status" && selectedStockStatus != null) {
      hasSelection = true;
    } else if (categoryTitle == 'Price Range' &&
        priceRange != const RangeValues(1, 1000)) {
      hasSelection = true;
    }
    return ListTile(
      title: Row(
        children: [
          Text(categoryTitle, style: const TextStyle(fontSize: 16)),
          if (hasSelection)
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text("*", style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildFilterOption(String option, VoidCallback onTap) {
    bool isSelected = false;
    if (selectedCategory == "Categories" && selectedMainCategory == option) {
      isSelected = true;
    } else if (selectedCategory == "Subcategories" &&
        selectedSubcategory == option) {
      isSelected = true;
    } else if (selectedCategory == "Stock Status" &&
        selectedStockStatus == option) {
      isSelected = true;
    }
    return ListTile(
      title: Text(option),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.red) : null,
      onTap: onTap,
    );
  }

  Map<String, String> _getSubcategoriesFor(String mainCategory) {
    switch (mainCategory) {
      case "All Gun Parts":
        return {
          "Angle Mounts": angleMountFilter,
          "Barrels": gunBarrels,
          "BCG": arFifteenBCG,
          "Bi-Pods": biPods,
          "Bolt Catch": boltCatch,
          "Bolt Release": boltRelease,
          "Buffer": gunBuffers,
          "Buffer Spring": gunBufferSpring,
          "Buffer Tube": gunBufferTube,
          "Buffer Tube Assembly": gunBufferTubeAssembly,
          "Butt Pad": buttPad,
          "Carry Handles": carryHandles,
          "Castle Nut": castleNut,
          "Charging Handles": gunChargingHandle,
          "Delta Ring Kits": deltaRingKits,
          "Ejection Port Covers": ejectionPortCovers,
          "End Cap": endCap,
          "Forward Assist": forwardAssist,
          "Gas Blocks": arFifteenGasBlocks,
          "Gas Tubes": arFifteenGasTubes,
          "Grips": grips,
          "Hand Guards / Rails": gunHandGuardRails,
          "Hammers": gunHammers,
          "Lower Parts Kit": gunLowerPartsKit,
          "Mag catch": magCatch,
          "Mounts & Risers": gunMountsRisers,
          "Muzzle Brakes": gunMuzzleBreaks,
          "Risers": risers,
          "Rail Pieces": railPieces,
          "Pins": gunPins,
          "Safety Selector": safetySelector,
          "Shotgun": shotgun,
          "Sights": sights,
          "Sling Plates": slingPlates,
          "Spring Kits": springKits,
          "Slings": slings,
          "Stripped Uppers": strippedUppers,
          "Stock Assemblies": stockAssemblies,
          "Stocks": gunStocks,
          "Triggers": gunTriggres,
          "Trigger Disconnect": triggerDisconnects,
          "Take Down Pins": takeDownPins
        };
      case "AR 15":
        return {
          "Colored Parts": arFifteenColors,
          "Anti-Walk Pins": arFifteenAntiWalkPins,
          "Barrels": arFifteenBarrelsFilter,
          "BCG": arFifteenBCG,
          "Bolt Catch": boltCatch,
          "Bolt Release": boltRelease,
          "Buffer": gunBufferTube,
          "Buffer Spring": gunBufferSpring,
          "Buffer Tube": gunBufferTube,
          "Buffer Tube Assembly": gunBufferTubeAssembly,
          "Butt Pad": buttPad,
          "Castle Nut": castleNut,
          "Charging Handles": arFifteenChargingHandle,
          "Combo Kits": arFifteenComboKit,
          "Complete Upper": arFifteenCompleteUpper,
          "Delta Ring Kits": deltaRingKits,
          "Ejection Port Covers": ejectionPortCovers,
          "End Cap": endCap,
          "Forward Assist": forwardAssist,
          "Gas Blocks": arFifteenGasBlocks,
          "Gas Tubes": arFifteenGasTubes,
          "Grips": grips,
          "Hammers": gunHammers,
          "Hand Guards / Rails": gunHandGuardRails,
          "Lower Parts Kit": gunLowerPartsKit,
          "Muzzle Brakes": gunMuzzleBreaks,
          "Pins": gunPins,
          "Risers": risers,
          "Rail Pieces": railPieces,
          "Sights": sights,
          "Slings": slings,
          "Safety Selector": safetySelector,
          "Sling Plates": slingPlates,
          "Spring Kits": springKits,
          "Stock Assemblies": stockAssemblies,
          "Stocks": gunStocks,
          "Stripped Uppers": strippedUppers,
          "Triggers": gunTriggres,
          "Trigger Disconnect": triggerDisconnects,
          "Trigger Guard": arFifteenTriggerGuards,
          "Take Down Pins": takeDownPins
        };
      case "AR 10":
        return {
          "Anti-Walk Pins": arFifteenAntiWalkPins,
          "Barrels": arTenBarrelsFilter,
          "BCG": arTenBCG,
          "Buffers": arTenBuffers,
          "Buffer Tube": gunBufferTube,
          "Butt Pad": buttPad,
          "AR-10 Buffer Spring": gunBufferSpring,
          "Castle Nuts": castleNut,
          "Charging Handles": gunChargingHandle,
          "Gas Blocks": arTenGasBlocks,
          "Hammers": gunHammers,
          "Lower Parts Kit": arTenLowerPartsKit,
          "Magazine Catch": magCatch,
          "Muzzle Brakes": arTenMuzzleBreaks,
          "Rail Pieces": arTenRailPieces,
          "Safety Selector": safetySelector,
          // "Spring":,
          "Stocks": gunStocks,
          "Stock Assemblies": stockAssemblies,
          "Upper Parts": arTenUpperParts
        };
      case "AK 47":
        return {
          "Folding Adapter": akFoldingAdapters,
          "Muzzle Brakes": akMuzzleBreaks,
          "Rail Pieces": railPieces,
          "Stocks": gunStocks
        };
      case "GLOCK®":
        return {
          "Barrels": glockBarrelsCat,
          "Lower Parts Kit": glockLowerPartsKit,
          "Holsters": glockHolsters,
          "Slide Parts": glockSlide,
          "Tools": glockTools,
          "Vice Block": glockViceBlocks
        };
      case "Gun Accessories":
        return {
          "Bags": backPacks,
          "Bore Sights": boreSights,
          "Dot Sights": dotSights,
          "Flashlights": flashLights,
          "Holsters": holsters,
          "Lasers": lasers,
          "Magazine & Drums": magsAndDrums,
          "MCK": mck,
          "Plate Carrier": tagPlateCarrier,
          "Slings": slings,
          "Scopes": scopes
        };

      default:
        return {};
    }
  }

  void _showSortByMenu(BuildContext context) {
    final controller = Get.find<CategoriesController>();

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
                  Navigator.pop(context);
                  scrollController.animateTo(
                    0, // Scroll position at the top
                    duration: const Duration(
                        milliseconds: 300), // Duration of the scroll
                    curve: Curves.easeInOut, // Animation curve
                  );
                  sortby = 'popularity';
                  if (!areFiltersApplied) {
                    controller.updateSort(sortby!);
                  } else {
                    controller.updateFilters(categoryID, subCategoryID,
                        stockStatus, priceRange, sortby);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.new_releases, color: Colors.blue),
                title: const Text("Latest"),
                trailing: controller.selectedSort == "date"
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  scrollController.animateTo(
                    0, // Scroll position at the top
                    duration: const Duration(
                        milliseconds: 300), // Duration of the scroll
                    curve: Curves.easeInOut, // Animation curve
                  );
                  sortby = 'date';
                  if (!areFiltersApplied) {
                    controller.updateSort(sortby!);
                  } else {
                    controller.updateFilters(categoryID, subCategoryID,
                        stockStatus, priceRange, sortby);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.timelapse, color: Colors.blueGrey),
                title: const Text("Oldest"),
                trailing: controller.selectedSort == "Odate"
                    ? const Icon(Icons.check, color: Colors.blueGrey)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  scrollController.animateTo(
                    0, // Scroll position at the top
                    duration: const Duration(
                        milliseconds: 300), // Duration of the scroll
                    curve: Curves.easeInOut, // Animation curve
                  );
                  sortby = 'Odate';
                  if (!areFiltersApplied) {
                    controller.updateSort(sortby!);
                  } else {
                    controller.updateFilters(categoryID, subCategoryID,
                        stockStatus, priceRange, sortby);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_downward, color: Colors.green),
                title: const Text("Price low to high"),
                trailing: controller.selectedSort == "Lprice"
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  sortby = 'Lprice';
                  scrollController.animateTo(
                    0, // Scroll position at the top
                    duration: const Duration(
                        milliseconds: 300), // Duration of the scroll
                    curve: Curves.easeInOut, // Animation curve
                  );
                  if (!areFiltersApplied) {
                    controller.updateSort(sortby!);
                  } else {
                    controller.updateFilters(categoryID, subCategoryID,
                        stockStatus, priceRange, sortby);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_upward, color: Colors.green),
                title: const Text("Price high to low"),
                trailing: controller.selectedSort == "price"
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                  scrollController.animateTo(
                    0, // Scroll position at the top
                    duration: const Duration(
                        milliseconds: 300), // Duration of the scroll
                    curve: Curves.easeInOut, // Animation curve
                  );
                  sortby = 'price';
                  if (!areFiltersApplied) {
                    controller.updateSort(sortby!);
                  } else {
                    controller.updateFilters(categoryID, subCategoryID,
                        stockStatus, priceRange, sortby);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CategoriesController categoriesController =
        Get.put(CategoriesController(categoryTitle: widget.title));
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: dmaDarkGrey,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: dmaWhite),
          backgroundColor: dmaDarkGrey,
          elevation: 5,
          toolbarHeight: screenHeight * 0.08,
          automaticallyImplyLeading: true,
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
                    color: dmaWhite,
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
        body: Container(
          padding: const EdgeInsets.all(8),
          width: context.screenWidth,
          height: context.screenHeight,
          child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    10.heightBox,
                    widget.title!.text
                        .size(35)
                        .color(dmaRed)
                        .fontFamily(badSu)
                        .make(),
                    15.heightBox,
                  ]),
                ),
              ),
              Obx(() {
                if (categoriesController.isLoading.value) {
                  return SliverFillRemaining(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: dmaRed, size: 40),
                  );
                }

                if (categoriesController.productList.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No products found')),
                  );
                }

                return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductTile(
                          categoriesController.productList[index]);
                    },
                    childCount: categoriesController.productList.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 340,
                  ),
                );
              }),
              Obx(() {
                if (categoriesController.isLoading.value) {
                  return SliverFillRemaining(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: dmaRed, size: 40),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: PaginationWidget(
                        totalPages: categoriesController.totalPages,
                        currentPage: (areFiltersApplied == false)
                            ? categoriesController.currentPage
                            : categoriesController.currentFilterPage,
                        onPageSelected: (page) {
                          if (areFiltersApplied == false) {
                            categoriesController.fetchProductsByPage(page);
                          } else {
                            categoriesController.updateFiltersPage(
                                categoryID,
                                subCategoryID,
                                stockStatus,
                                priceRange,
                                sortby,
                                page);
                          }
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
          if (categoriesController.isLoading.value) {
            return Container(
              color: dmaDarkGrey,
              height: 1,
              width: double.infinity,
            );
          } else {
            return Container(
              height: screenHeight * 0.06,
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
                    const VerticalDivider(
                      color: dmaDarkGrey,
                      thickness: 2,
                      width: 1,
                    ),
                    Expanded(
                      child: Obx(() {
                        return showfilter.value
                            ? Column(
                                children: [
                                  const VerticalDivider(
                                      color: dmaDarkGrey, thickness: 1),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.filter_alt,
                                            color: dmaDarkGrey),
                                        const SizedBox(width: 4),
                                        "Filter"
                                            .text
                                            .size(18)
                                            .fontFamily(badSu)
                                            .fontWeight(FontWeight.bold)
                                            .color(dmaDarkGrey)
                                            .make(),
                                      ],
                                    ).onTap(() {
                                      _showFilterMenu(context);
                                    }),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink();
                      }),
                    )
                  ]),
            );
          }
        }));
  }
}
