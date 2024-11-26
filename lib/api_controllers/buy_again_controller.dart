import 'package:dma_inc/models/orders_model.dart';
import 'package:dma_inc/services/your_orders_services.dart';
import 'package:get/get.dart';

import 'package:get/state_manager.dart';

class BuyAgainController extends GetxController {
  var isLoading = true.obs;
  var productList = <OrdersModel>[].obs;

  @override
  void onInit() {
    fetchBuyAgain();
    super.onInit();
  }

  void fetchBuyAgain() async {
    try {
      isLoading(true); // Start the loading indicator
      var response =
          await YourOrdersServices.fetchBuyAgain(); // Fetch search results
      productList.value = response;
    } catch (e) {
      throw ("error in controller: $e");
    } finally {
      isLoading(false); // Stop the loading indicator
    }
  }
}
