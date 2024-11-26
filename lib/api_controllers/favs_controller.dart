import 'package:dma_inc/models/favs_model.dart';
import 'package:dma_inc/services/favs_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavController extends GetxController {
  var favItems = <FavModel>[].obs;
  var isLoading = false.obs;

  final FavServices favServices = FavServices();
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    fetchFavs();
  }

  // Fetch favorite items based on a list of IDs
  void fetchFavs() async {
    isLoading(true);

    try {
      print("in controller");
      print("id: ${storage.read('customer_id')}");
      var favs = await favServices.fetchFavItems();
      favItems.value = favs;
      List<String> prodIds = favs.map((item) => item.prodId).toList();
      storage.write('favorite_ids', prodIds);
      print(storage.read('favorite_ids'));
    } catch (e) {
      print("Error fetching favorite items: $e");
    } finally {
      isLoading(false);
    }
  }

  void updateFav() async {
    isLoading(true);

    try {
      var favs = await favServices.fetchFavItems();
      favItems.value = favs;
      List<String> prodIds = favs.map((item) => item.prodId).toList();
      storage.write('favorite_ids', prodIds);
      print(storage.read('favorite_ids'));
    } catch (e) {
      print("Error fetching favorite items: $e");
    } finally {
      isLoading(false);
    }
  }
}
