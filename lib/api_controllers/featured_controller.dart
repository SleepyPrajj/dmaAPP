import 'package:dma_inc/models/featured_products_model.dart';
import 'package:dma_inc/services/featured_services.dart';
import 'package:get/state_manager.dart';

class FeaturedController extends GetxController {
  var isLoading = true.obs;
  var productList = <FeaturedModel>[].obs;

  @override
  void onInit() {
    fetchFeatured();
    super.onInit();
  }

  void fetchFeatured() async {
    try {
      isLoading(true);
      var products = await FeaturedServieces.fetchFeatured();
      productList.value = products;
    } finally {
      isLoading(false);
    }
  }
}
