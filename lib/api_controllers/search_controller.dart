import 'package:dma_inc/models/search_model.dart';
import 'package:get/get.dart';
import 'package:dma_inc/services/search_services.dart';

class SearchController extends GetxController {
  var isLoading = true.obs;
  var productList = <SearchModel>[].obs;
  String searchString; // Keep it mutable to handle changes
  int totalPages = 1;
  String? selectedSort;
  String? sortby;
  int currentPage = 1;

  SearchController({required this.searchString});

  @override
  void onInit() {
    fetchSearch();
    super.onInit();
  }

  void fetchSearch() async {
    try {
      if (searchString.isEmpty) return;
      isLoading(true);
      var response =
          await SearchServices.fetchSearch(searchString, currentPage, sortby);
      productList.value = response['products'];
      totalPages = response['totalPages'];
      currentPage = 1;
    } finally {
      isLoading(false);
    }
  }

  void fetchSearchPage() async {
    try {
      if (searchString.isEmpty) return;
      isLoading(true);
      var response =
          await SearchServices.fetchSearch(searchString, currentPage, sortby);
      productList.value = response['products'];
      totalPages = response['totalPages'];
      currentPage = response['currentPage'];
    } finally {
      isLoading(false);
    }
  }

  void updateSort(String newSortby) {
    sortby = newSortby;
    selectedSort = newSortby; // Update the selected sort method
    currentPage = 1; // Reset to first page on sort change
    fetchSearch();
  }

  void fetchProductsByPage(int page) {
    currentPage = page;
    fetchSearchPage();
  }

  void resetSearch(String newSearchString) {
    searchString = newSearchString;
    currentPage = 1;
    fetchSearch();
  }
}
