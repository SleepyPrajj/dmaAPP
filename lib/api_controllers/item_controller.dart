// import 'package:dma_inc/models/item_details_model.dart';
import 'package:dma_inc/models/item_details_model.dart';
import 'package:dma_inc/services/item_services.dart';
import 'package:get/state_manager.dart';

class ItemController extends GetxController {
  var isLoading = true.obs;
  var productString = Rx<ItemDetails?>(null);
  final int itemID;

  ItemController({required this.itemID});

  @override
  void onInit() {
    fetchItem();
    super.onInit();
  }

  void fetchItem() async {
    try {
      isLoading(true);
      var products = await ItemServices.fetchItem(itemID);
      productString.value = products;
    } finally {
      isLoading(false);
    }
  }
}
