import 'package:dma_inc/models/orders_model.dart';
import 'package:dma_inc/services/past_three_months_services.dart';
import 'package:get/get.dart';

import 'package:get/state_manager.dart';

class PastThreeMonthsController extends GetxController {
  var isLoading = true.obs;
  var productList = <OrdersModel>[].obs;

  @override
  void onInit() {
    fetchThreeMonths();
    super.onInit();
  }

  void fetchThreeMonths() async {
    try {
      isLoading(true); // Start the loading indicator
      var response = await PastThreeMonthsServices
          .fetchPastThree(); // Fetch search results
      productList.value = response;
    } catch (e) {
      throw ("error in controller: $e");
    } finally {
      isLoading(false); // Stop the loading indicator
    }
  }
}
