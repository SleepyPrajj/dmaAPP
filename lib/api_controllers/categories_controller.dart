import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/services/remote_services.dart';
import 'package:get/state_manager.dart';
import 'package:dma_inc/models/category_product_model.dart';

class CategoriesController extends GetxController {
  var isLoading = true.obs;
  var productList = <CategoryModel>[].obs;
  String? sortby;
  String? selectedSort;
  final String? categoryTitle;
  int totalPages = 1;
  int currentFilterPage = 1;
  int currentPage = 1;
  List<String> selectedFilters = [];

  CategoriesController({required this.categoryTitle, this.sortby});

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void updateFilters(String? categoryID, String? subCategoryID,
      String? stockStatus, RangeValues? priceRange, String? sortby) async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchFilteredProducts(
          categoryTitle!,
          currentFilterPage,
          sortby,
          categoryID,
          subCategoryID,
          stockStatus,
          priceRange,
          sortby);
      productList.value = products['products'];
      totalPages = products['totalPages'];
      currentFilterPage = 1;
    } finally {
      isLoading(false);
    }
  }

  void updateFiltersPage(
      String? categoryID,
      String? subCategoryID,
      String? stockStatus,
      RangeValues? priceRange,
      String? sortby,
      int page) async {
    currentFilterPage = page;
    try {
      isLoading(true);
      print("controller subCategoryID: $subCategoryID");

      var products = await RemoteServices.fetchFilteredProducts(
          categoryTitle!,
          currentFilterPage,
          sortby,
          categoryID,
          subCategoryID,
          stockStatus,
          priceRange,
          sortby);
      productList.value = products['products'];
      totalPages = products['totalPages'];
      currentFilterPage = products['currentPage'];
    } finally {
      isLoading(false);
    }
  }

  void updateSortFilters(String newSortby) {
    sortby = newSortby;
    selectedSort = newSortby; // Update the selected sort method
    currentPage = 1; // Reset to first page on sort change
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts(
          categoryTitle!, currentPage, sortby);
      productList.value = products['products'];
      totalPages = products['totalPages'];
      currentPage = 1;
    } finally {
      isLoading(false);
    }
  }

  void updateSort(String newSortby) {
    sortby = newSortby;
    selectedSort = newSortby; // Update the selected sort method
    currentPage = 1; // Reset to first page on sort change
    fetchProducts();
  }

  void fetchProductsPage() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts(
          categoryTitle!, currentPage, sortby);
      productList.value = products['products'];
      totalPages = products['totalPages'];
      currentPage = products['currentPage'];
    } finally {
      isLoading(false);
    }
  }

  void fetchProductsByPage(int page) {
    currentPage = page;
    fetchProductsPage();
  }
}
