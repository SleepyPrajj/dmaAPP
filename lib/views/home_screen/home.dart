import 'package:dma_inc/api_controllers/favs_controller.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/controller/home_controller.dart';
import 'package:dma_inc/views/cart_screen/cart_screen.dart';
import 'package:dma_inc/views/fav_screen/fav_screen.dart';
import 'package:dma_inc/views/home_screen/home_screen.dart';
import 'package:dma_inc/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = Get.put(HomeController());
  final FavController favController = Get.put(FavController());

  int lastNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
            color: const Color.fromRGBO(124, 124, 124, 1),
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icFav,
              width: 26, color: const Color.fromRGBO(124, 124, 124, 1)),
          label: favs),
      BottomNavigationBarItem(
        icon: PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => Badge(
                  label: Text(itemCount.toString()),
                  child: Image.asset(
                    icCart,
                    width: 26,
                    color: const Color.fromRGBO(124, 124, 124, 1),
                  ),
                )),
        label: cart,
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
            color: const Color.fromRGBO(124, 124, 124, 1),
          ),
          label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const FavScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            if (controller.currentNavIndex.value == 1 && lastNavIndex != 1) {
              favController.fetchFavs();
            }
            lastNavIndex = controller.currentNavIndex.value;

            return Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value),
            );
          }),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          fixedColor: dmaRed,
          selectedLabelStyle: const TextStyle(fontFamily: bold),
          unselectedLabelStyle: const TextStyle(fontFamily: bold),
          items: navBarItem,
          backgroundColor: dmaWhite,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
