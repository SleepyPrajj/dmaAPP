import 'dart:convert';
import 'package:dma_inc/views/home_screen/home.dart';
import 'package:dma_inc/widgets_common/private_policy_dialogue.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/widgets_common/custom_text_field.dart';
import 'package:dma_inc/widgets_common/loading_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:get_storage/get_storage.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _billingFormKey = GlobalKey<FormState>();
  final _shippingFormKey = GlobalKey<FormState>();
  final _couponController = TextEditingController();
  double discountAmount = 0.0;
  String? couponID;
  bool showShippingDetails = false;
  bool isCouponValid = false;
  double totalAmount = 0.0;
  double couponDiscount = 0.0;
  bool isApplyingCoupon = false;
  bool isLoading = true;
  String? selectedShippingMethord;
  String? discountType;
  final String basicAuth = 'Basic ' + base64Encode(utf8.encode('$key:$shhh'));
  Map<String, dynamic> billingDetails = {};
  Map<String, dynamic> shippingDetails = {};
  List<PersistentShoppingCartItem> cartItems =
      []; // Using PersistentShoppingCartItem

  PersistentShoppingCart cart = PersistentShoppingCart();

  @override
  void initState() {
    super.initState();
    _loadCustomerDetails();
    _loadCartDetails();
  }

  Future<void> _loadCustomerDetails() async {
    // Fetch customer details using stored customer ID
    final customerId = GetStorage().read('customer_id');
    if (customerId != null) {
      final response = await http.get(
        Uri.parse('https://dma-inc.net/wp-json/wc/v3/customers/$customerId'),
        headers: {'Authorization': basicAuth},
      );
      try {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            billingDetails = data['billing'] ?? {};
            shippingDetails = data['shipping'] ?? {};
            isLoading = false;
          });
        } else {
          Get.snackbar('Error', 'Failed to load customer details.');
        }
      } finally {
        isLoading = false;
      }
    }
  }

  Future<void> _loadCartDetails() async {
    // Use PersistentShoppingCart to get the cart data
    final cartData = cart.getCartData();
    setState(() {
      cartItems = cartData['cartItems'];
      totalAmount = cartData['totalPrice'];
    });
  }

  void _applyCoupon() async {
    final coupon = _couponController.text.trim();
    isApplyingCoupon = true;
    if (coupon.isNotEmpty) {
      final response = await http.get(
        Uri.parse('https://dma-inc.net/wp-json/wc/v3/coupons?code=$coupon'),
        headers: {'Authorization': basicAuth},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body).first;
        setState(() {
          isCouponValid = true;
          isApplyingCoupon = false;
          couponDiscount = double.tryParse(data['amount'].toString()) ?? 0.0;
          couponID = data['id'];
          discountType = data['discount_type'];
          if (discountType == "fixed_cart") {
            totalAmount -= couponDiscount;
          } else if (discountType == "percent") {
            discountAmount = totalAmount * (couponDiscount / 100);
            totalAmount -= discountAmount;
          } else {
            Get.snackbar("Error",
                "There is some error with your coupon, please contact us!");
          }
        });
        Get.snackbar('Coupon Applied',
            'You saved \$${couponDiscount.toStringAsFixed(2)}');
      } else {
        Get.snackbar('Invalid Coupon', 'Please try a different coupon.');
        isApplyingCoupon = false;
      }
    }
  }

  Future<void> _placeOrder() async {
    if (_billingFormKey.currentState!.validate() &&
        (!showShippingDetails || _shippingFormKey.currentState!.validate())) {
      final orderDetails = {
        "billing": billingDetails,
        "shipping": showShippingDetails ? shippingDetails : billingDetails,
        "line_items": cartItems
            .map((item) => {
                  "product_id": item.productId,
                  "quantity": item.quantity,
                })
            .toList(),
        "payment_method": "invoice",
        "payment_method_title": "Invoice",
        "total": totalAmount.toStringAsFixed(2),
        "coupon_discount": couponDiscount,
        "shipping_lines": [
          {
            "method_id": (selectedShippingMethord == "Local store pickup")
                ? "local_pickup"
                : "other",
            "method_title": selectedShippingMethord,
          }
        ],
        "customer_id": GetStorage().read('customer_id'),
        "coupon_lines": isCouponValid
            ? [
                {
                  "id": couponID,
                  "code": _couponController.text.trim(),
                  "discount": couponDiscount
                }
              ]
            : [],
      };
      try {
        final response = await http.post(
          Uri.parse('https://dma-inc.net/wp-json/wc/v3/orders'),
          headers: {
            'Authorization': basicAuth,
            'Content-Type': 'application/json'
          },
          body: json.encode(orderDetails),
        );

        if (response.statusCode == 201) {
          Get.snackbar(
              'Order Placed', 'Your order has been placed successfully.');
          await Future.delayed(const Duration(seconds: 2));
          Get.offAll(() => const Home());
        } else {
          Get.snackbar('Error', 'Failed to place order.');
        }
      } catch (e) {
        Get.snackbar("Error", "Error:$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dmaDarkGrey,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: dmaWhite, fontSize: 26),
        ),
        backgroundColor: dmaDarkGrey,
        iconTheme: const IconThemeData(color: dmaWhite),
      ),
      body: (isLoading == true)
          ? Column(
              children: [
                "\n\n\n\n\n".text.make(),
                Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                      color: dmaRed, size: 50),
                ),
                "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n".text.make()
              ],
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Billing Details',
                    style: TextStyle(color: dmaWhite, fontSize: 22),
                  ),
                  Form(
                      key: _billingFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'First Name *',
                            initialValue: billingDetails['first_name'] ?? '',
                            onChanged: (value) =>
                                billingDetails['first_name'] = value,
                          ),
                          CustomTextField(
                            label: 'Last Name *',
                            initialValue: billingDetails['last_name'] ?? '',
                            onChanged: (value) =>
                                billingDetails['last_name'] = value,
                          ),
                          CustomTextField(
                            label: 'Company Name (optional)',
                            initialValue: billingDetails['company_name'] ?? '',
                            isRequired: false,
                            onChanged: (value) =>
                                billingDetails['company_name'] = value,
                          ),
                          CustomTextField(
                            label: 'Country / Region *',
                            initialValue: billingDetails['country'] ?? '',
                            onChanged: (value) =>
                                billingDetails['country'] = value,
                          ),
                          CustomTextField(
                            label: 'Street Address *',
                            initialValue: billingDetails['address_1'] ?? '',
                            onChanged: (value) =>
                                billingDetails['address_1'] = value,
                          ),
                          CustomTextField(
                            label: 'Apartment, suite, unit, etc. (optional)',
                            initialValue: billingDetails['address_2'] ?? '',
                            onChanged: (value) =>
                                billingDetails['address_2'] = value,
                          ),
                          CustomTextField(
                            label: 'Town / City *',
                            initialValue: billingDetails['city'] ?? '',
                            onChanged: (value) =>
                                billingDetails['city'] = value,
                          ),
                          CustomTextField(
                            label: 'State *',
                            initialValue: billingDetails['state'] ?? '',
                            onChanged: (value) =>
                                billingDetails['state'] = value,
                          ),
                          CustomTextField(
                            label: 'ZIP Code *',
                            initialValue: billingDetails['postcode'] ?? '',
                            onChanged: (value) =>
                                billingDetails['postcode'] = value,
                          ),
                          CustomTextField(
                            label: 'Phone *',
                            initialValue: billingDetails['phone'] ?? '',
                            onChanged: (value) =>
                                billingDetails['phone'] = value,
                          ),
                          CustomTextField(
                            label: 'Email Address *',
                            initialValue: billingDetails['email'] ?? '',
                            onChanged: (value) =>
                                billingDetails['email'] = value,
                          ),
                        ],
                      )),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ship to a different address?',
                        style: TextStyle(color: dmaWhite, fontSize: 18),
                      ),
                      Switch(
                        value: showShippingDetails,
                        onChanged: (value) {
                          setState(() {
                            showShippingDetails = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (showShippingDetails == true) ...[
                    Form(
                      key: _shippingFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'First Name *',
                            initialValue: shippingDetails['first_name'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['first_name'] = value,
                          ),
                          CustomTextField(
                            label: 'Last Name *',
                            initialValue: shippingDetails['last_name'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['last_name'] = value,
                          ),
                          CustomTextField(
                            label: 'Country / Region *',
                            initialValue: shippingDetails['country'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['country'] = value,
                          ),
                          CustomTextField(
                            label: 'Street Address *',
                            initialValue: shippingDetails['address_1'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['address_1'] = value,
                          ),
                          CustomTextField(
                            label: 'Apartment, suite, unit, etc. (optional)',
                            initialValue: shippingDetails['address_2'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['address_2'] = value,
                          ),
                          CustomTextField(
                            label: 'Town / City *',
                            initialValue: shippingDetails['city'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['city'] = value,
                          ),
                          CustomTextField(
                            label: 'State *',
                            initialValue: shippingDetails['state'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['state'] = value,
                          ),
                          CustomTextField(
                            label: 'ZIP Code *',
                            initialValue: shippingDetails['postcode'] ?? '',
                            onChanged: (value) =>
                                shippingDetails['postcode'] = value,
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Order',
                          style: TextStyle(color: dmaWhite, fontSize: 22),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          itemCount: cartItems.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.network(item.productThumbnail!,
                                  height: 50, width: 50),
                              title: Text(
                                item.productName,
                                style: const TextStyle(
                                    color: dmaWhite, fontSize: 16),
                              ),
                              subtitle: Text(
                                "Quantity: ${item.quantity}",
                                style: const TextStyle(color: dmaWhite),
                              ),
                              trailing: Text(
                                "\$${(item.unitPrice * item.quantity).toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: dmaWhite, fontSize: 16),
                              ),
                            );
                          },
                        ),
                        10.heightBox,
                        TextField(
                          controller: _couponController,
                          style: const TextStyle(color: dmaWhite),
                          decoration: InputDecoration(
                            labelText: 'Coupon Code',
                            suffixIcon: IconButton(
                              onPressed: () => _applyCoupon(),
                              icon: isApplyingCoupon
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: dmaRed, size: 10)
                                  : const Icon(
                                      Icons.check,
                                      color: dmaWhite,
                                    ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                          ),
                        ),
                        10.heightBox,
                        const Divider(color: dmaWhite, thickness: 2),
                        const Text(
                          'Order Summary',
                          style: TextStyle(color: dmaWhite, fontSize: 22),
                        ),
                        const SizedBox(height: 10),
                        if (isCouponValid)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Coupon Discount',
                                style: TextStyle(color: dmaWhite)),
                            trailing: Text(
                              "-\$${couponDiscount.toStringAsFixed(2)}",
                              style: const TextStyle(color: dmaWhite),
                            ),
                          ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Total',
                              style: TextStyle(color: dmaWhite, fontSize: 18)),
                          trailing: Text(
                            "\$${(totalAmount - couponDiscount).toStringAsFixed(2)}",
                            style:
                                const TextStyle(color: dmaWhite, fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Shipping',
                              style: TextStyle(color: dmaWhite, fontSize: 16)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: 'Shipping',
                                groupValue: selectedShippingMethord,
                                onChanged: (value) {
                                  setState(() {
                                    selectedShippingMethord = value;
                                  });
                                },
                              ),
                              const Text(
                                'Shipping',
                                style: TextStyle(color: dmaWhite),
                              ),
                              Radio<String>(
                                value: 'Local store pickup',
                                groupValue: selectedShippingMethord,
                                onChanged: (value) {
                                  setState(() {
                                    selectedShippingMethord = value;
                                  });
                                },
                              ),
                              const Text(
                                'Local store pickup',
                                style: TextStyle(color: dmaWhite),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        "Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our"
                            .text
                            .white
                            .make()
                            .centered(),
                        "privacy policy."
                            .text
                            .color(dmaRed)
                            .make()
                            .centered()
                            .onTap(() {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const PrivacyPolicyWidget(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  LoadingButton(
                    text: 'Place Order',
                    onPressed: _placeOrder,
                  ),
                ],
              ),
            ),
    );
  }
}
