import 'package:dma_inc/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class FavoriteButton extends StatefulWidget {
  final int productId;

  const FavoriteButton({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  // Check if the product is already favorited by looking in the favorite_ids list
  void _checkIfFavorited() {
    List favoriteIds = box.read<List>('favorite_ids') ?? [];
    setState(() {
      isFavorited = favoriteIds.contains(widget.productId.toString());
    });
  }

  // Add the product to the favorites list and server
  Future<void> _addFavorite() async {
    final url = Uri.parse(
        'https://dma-inc.net/wp-json/yith/wishlist/v1/items?user_id=${box.read('customer_id')}&product_id=${widget.productId}');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${box.read('token')}',
    });

    if (response.statusCode == 200) {
      setState(() => isFavorited = true);
      List favoriteIds = box.read<List>('favorite_ids') ?? [];
      favoriteIds.add(widget.productId.toString());
      box.write('favorite_ids', favoriteIds);
      Get.snackbar('Added!', 'Item added to your wishlist.');
    } else {
      Get.snackbar('Error', 'Failed to add to favorites');
    }
  }

  // Remove the product from the favorites list and server
  Future<void> _removeFavorite() async {
    final url = Uri.parse(
        'https://dma-inc.net/wp-json/yith/wishlist/v1/items?user_id=${box.read('customer_id')}&product_id=${widget.productId}');
    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer ${box.read('token')}',
    });

    if (response.statusCode == 200) {
      setState(() => isFavorited = false);
      List favoriteIds = box.read<List>('favorite_ids') ?? [];
      favoriteIds.remove(widget.productId);
      box.write('favorite_ids', favoriteIds);
      Get.snackbar('Removed!', 'Item removed to your wishlist.');
    } else {
      Get.snackbar('Error', 'Failed to remove from favorites');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: dmaGreytrans,
      child: IconButton(
        icon: Icon(
          isFavorited ? Icons.favorite : Icons.favorite_border,
          color: isFavorited ? Colors.red : null,
        ),
        onPressed: () {
          if (isFavorited) {
            _removeFavorite();
          } else {
            _addFavorite();
          }
        },
      ),
    );
  }
}
