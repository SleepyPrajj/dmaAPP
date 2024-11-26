import 'package:dma_inc/models/category_product_model.dart';
import 'package:dma_inc/services/new_products_services.dart';
import 'package:get/state_manager.dart';

class NewProductsController extends GetxController {
  var isLoading = true.obs;
  var productList = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchSale();
    super.onInit();
  }

  void fetchSale() async {
    try {
      isLoading(true);
      var products = await NewProductsServices.fetchNew();
      productList.value = products;
    } finally {
      isLoading(false);
    }
  }
}
