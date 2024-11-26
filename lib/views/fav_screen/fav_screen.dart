import 'package:dma_inc/api_controllers/favs_controller.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/fav_screen/fav_tile.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavController favController = Get.find<FavController>();

    return Scaffold(
      appBar: AppBar(
        title: "Favorites"
            .text
            .white
            .color(dmaWhite)
            .size(30)
            .fontFamily(bold)
            .make(),
        centerTitle: true,
        backgroundColor: dmaDarkGrey,
      ),
      backgroundColor: dmaDarkGrey,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          if (favController.isLoading.value) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: dmaRed, size: 50));
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favController.favItems.length,
            itemBuilder: (context, index) {
              return FavTile(
                product: favController.favItems[index],
              );
            },
          );
        }),
      ),
    );
  }
}
