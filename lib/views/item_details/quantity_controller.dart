import 'package:get/get.dart';

class QuantityController extends GetxController {
  var quantity = 1.obs; // Make quantity observable

  // Method to increase quantity
  void increment() {
    quantity++;
  }

  // Method to decrease quantity, but not below 1
  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
