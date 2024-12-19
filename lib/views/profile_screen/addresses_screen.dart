import 'package:dma_inc/consts/consts.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressUpdateScreen extends StatefulWidget {
  const AddressUpdateScreen({Key? key}) : super(key: key);

  @override
  _AddressUpdateScreenState createState() => _AddressUpdateScreenState();
}

class _AddressUpdateScreenState extends State<AddressUpdateScreen> {
  final Map<String, dynamic> billingData = {};
  final Map<String, dynamic> shippingData = {};
  bool showBillingForm = false;
  bool showShippingForm = false;

  final TextEditingController billingFirstNameController =
      TextEditingController();
  final TextEditingController billingLastNameController =
      TextEditingController();
  final TextEditingController billingAddress1Controller =
      TextEditingController();
  final TextEditingController billingAddress2Controller =
      TextEditingController();
  final TextEditingController billingCityController = TextEditingController();
  final TextEditingController billingStateController = TextEditingController();
  final TextEditingController billingPostcodeController =
      TextEditingController();
  final TextEditingController billingCountryController =
      TextEditingController();
  final TextEditingController billingEmailController = TextEditingController();
  final TextEditingController billingPhoneController = TextEditingController();

  final TextEditingController shippingFirstNameController =
      TextEditingController();
  final TextEditingController shippingLastNameController =
      TextEditingController();
  final TextEditingController shippingAddress1Controller =
      TextEditingController();
  final TextEditingController shippingAddress2Controller =
      TextEditingController();
  final TextEditingController shippingCityController = TextEditingController();
  final TextEditingController shippingStateController = TextEditingController();
  final TextEditingController shippingPostcodeController =
      TextEditingController();
  final TextEditingController shippingCountryController =
      TextEditingController();
  final TextEditingController shippingPhoneController = TextEditingController();

  void updateBillingDetails() {
    setState(() {
      if (showBillingForm == false) {
        showBillingForm = true;
      } else {
        showBillingForm = false;
      }
    });
  }

  void updateShippingDetails() {
    setState(() {
      if (showShippingForm == false) {
        showShippingForm = true;
      } else {
        showShippingForm = false;
      }
    });
  }

  void collectUpdatedData() {
    if (billingFirstNameController.text.isNotEmpty) {
      billingData['first_name'] = billingFirstNameController.text;
    }
    if (billingLastNameController.text.isNotEmpty) {
      billingData['last_name'] = billingLastNameController.text;
    }
    if (billingAddress1Controller.text.isNotEmpty) {
      billingData['address_1'] = billingAddress1Controller.text;
    }
    if (billingAddress2Controller.text.isNotEmpty) {
      billingData['address_2'] = billingAddress2Controller.text;
    }
    if (billingCityController.text.isNotEmpty) {
      billingData['city'] = billingCityController.text;
    }
    if (billingStateController.text.isNotEmpty) {
      billingData['state'] = billingStateController.text;
    }
    if (billingPostcodeController.text.isNotEmpty) {
      billingData['postcode'] = billingPostcodeController.text;
    }
    if (billingCountryController.text.isNotEmpty) {
      billingData['country'] = billingCountryController.text;
    }
    if (billingEmailController.text.isNotEmpty) {
      billingData['email'] = billingEmailController.text;
    }
    if (billingPhoneController.text.isNotEmpty) {
      billingData['phone'] = billingPhoneController.text;
    }
    if (shippingFirstNameController.text.isNotEmpty) {
      shippingData['first_name'] = shippingFirstNameController.text;
    }
    if (shippingLastNameController.text.isNotEmpty) {
      shippingData['last_name'] = shippingLastNameController.text;
    }
    if (shippingAddress1Controller.text.isNotEmpty) {
      shippingData['address_1'] = shippingAddress1Controller.text;
    }
    if (shippingAddress2Controller.text.isNotEmpty) {
      shippingData['address_2'] = shippingAddress2Controller.text;
    }
    if (shippingCityController.text.isNotEmpty) {
      shippingData['city'] = shippingCityController.text;
    }
    if (shippingStateController.text.isNotEmpty) {
      shippingData['state'] = shippingStateController.text;
    }
    if (shippingPostcodeController.text.isNotEmpty) {
      shippingData['postcode'] = shippingPostcodeController.text;
    }
    if (shippingCountryController.text.isNotEmpty) {
      shippingData['country'] = shippingCountryController.text;
    }
    if (shippingPhoneController.text.isNotEmpty) {
      shippingData['phone'] = shippingPhoneController.text;
    }
  }

  Future<void> submitUpdatedDetails() async {
    collectUpdatedData();

    final updatedData = {
      if (billingData.isNotEmpty) 'billing': billingData,
      if (shippingData.isNotEmpty) 'shipping': shippingData,
    };

    final String url =
        'https://dma-inc.net/wp-json/wc/v3/customers/${GetStorage().read('customer_id')}';
    const String username =
        key; // Replace with your WooCommerce API consumer key
    const String password =
        shhh; // Replace with your WooCommerce API consumer secret
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    try {
      if (billingData.isEmpty && shippingData.isEmpty) {
        throw ("Please input your details first!");
      }
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success!", "Information Updated Successfully!");
        showBillingForm = false;
        showShippingForm = false;
        // Show success message or navigate to a different screen
      } else {
        Get.snackbar("Error",
            "Could not update information\nError Code ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "$e"); // Handle network or other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dmaDarkGrey, // Replace with dmaDarkGrey color code
      appBar: AppBar(
        title: "Update Address Details"
            .text
            .fontFamily(badSu)
            .bold
            .color(dmaWhite)
            .size(28)
            .make(),
        backgroundColor: dmaDarkGrey,
        iconTheme: const IconThemeData(color: dmaWhite),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            15.heightBox,
            ElevatedButton(
              onPressed: updateBillingDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: dmaRed,
              ),
              child: const Text(
                'Update Billing details',
                style: TextStyle(color: dmaWhite),
              ),
            ),
            if (showBillingForm) ...[
              5.heightBox,
              "Billing Details"
                  .text
                  .fontFamily(bold)
                  .color(dmaWhite)
                  .size(24)
                  .make(),
              buildTextField(
                  controller: billingFirstNameController, label: 'First Name'),
              buildTextField(
                  controller: billingLastNameController, label: 'Last Name'),
              buildTextField(
                  controller: billingAddress1Controller,
                  label: 'Address Line 1'),
              buildTextField(
                  controller: billingAddress2Controller,
                  label: 'Address Line 2'),
              buildTextField(controller: billingCityController, label: 'City'),
              buildTextField(
                  controller: billingStateController, label: 'State'),
              buildTextField(
                  controller: billingPostcodeController, label: 'Postal Code'),
              buildTextField(
                  controller: billingCountryController, label: 'Country'),
              buildTextField(
                  controller: billingEmailController, label: 'Email'),
              buildTextField(
                  controller: billingPhoneController, label: 'Phone'),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: updateShippingDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: dmaRed,
              ),
              child: const Text(
                'Update Shipping details',
                style: TextStyle(color: dmaWhite),
              ),
            ),
            if (showShippingForm) ...[
              5.heightBox,
              "Shipping Details"
                  .text
                  .fontFamily(bold)
                  .color(dmaWhite)
                  .size(24)
                  .make(),
              buildTextField(
                  controller: shippingFirstNameController, label: 'First Name'),
              buildTextField(
                  controller: shippingLastNameController, label: 'Last Name'),
              buildTextField(
                  controller: shippingAddress1Controller,
                  label: 'Address Line 1'),
              buildTextField(
                  controller: shippingAddress2Controller,
                  label: 'Address Line 2'),
              buildTextField(controller: shippingCityController, label: 'City'),
              buildTextField(
                  controller: shippingStateController, label: 'State'),
              buildTextField(
                  controller: shippingPostcodeController, label: 'Postal Code'),
              buildTextField(
                  controller: shippingCountryController, label: 'Country'),
              buildTextField(
                  controller: shippingPhoneController, label: 'Phone'),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitUpdatedDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: dmaRed,
              ),
              child: const Text(
                'Update Billing details',
                style: TextStyle(color: dmaWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      {required TextEditingController controller, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade900,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade600),
          ),
          labelStyle: TextStyle(color: Colors.grey.shade400),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
