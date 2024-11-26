import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/categories_screen/categories_screen.dart';
import 'package:get/get.dart';

Widget catButton(
    VoidCallback onPress, String image, String? title, double size) {
  return GestureDetector(
    onTap: () {
      Get.to(() => CategoriesScreen(title: title));
    },
    child: Container(
      width: size, // Set the width of the button container
      padding: EdgeInsets.all(size * 0.1), // Adjust padding for better spacing
      decoration: BoxDecoration(
        color: dmaWhite,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image with responsive sizing
          Image.network(
            image,
            height: size, // Height of the image relative to the button size
            width: size, // Width of the image relative to the button size
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5), // Space between image and text
          // Text with responsive styling
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size * 0.15, // Font size based on the button size
              fontWeight: FontWeight.bold,
              color: dmaDarkGrey,
            ),
          ),
        ],
      ),
    ),
  );
}
