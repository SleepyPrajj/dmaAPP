import 'package:dma_inc/models/sale_model.dart';
import 'package:dma_inc/services/sale_services.dart';
import 'package:get/state_manager.dart';

class SaleController extends GetxController {
  var isLoading = true.obs;
  var productList = <SaleModel>[].obs;

  @override
  void onInit() {
    fetchSale();
    super.onInit();
  }

  void fetchSale() async {
    try {
      isLoading(true);
      var products = await SaleServices.fetchFeatured();
      productList.value = products;
    } finally {
      isLoading(false);
    }
  }
}
