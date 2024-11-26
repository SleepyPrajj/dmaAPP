import 'dart:convert';

import 'package:dma_inc/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool showPasswordFields = false;

  Future<void> updateAccountDetails() async {
    // Collect updated data
    final updatedData = {
      if (_firstNameController.text.isNotEmpty)
        'first_name': _firstNameController.text,
      if (_lastNameController.text.isNotEmpty)
        'last_name': _lastNameController.text,
      if (_displayNameController.text.isNotEmpty)
        'display_name': _displayNameController.text,
      if (_emailController.text.isNotEmpty) 'email': _emailController.text,
    };

    if (showPasswordFields) {
      if (_currentPasswordController.text.isEmpty ||
          _newPasswordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        Get.snackbar("Error", "Please fill in all password fields.");
        return;
      } else if (_newPasswordController.text !=
          _confirmPasswordController.text) {
        Get.snackbar("Error", "New password and confirmation do not match.");
        return;
      } else {
        updatedData['password'] = _newPasswordController.text;
      }
    }

    final String url =
        'https://dma-inc.net/wp-json/wc/v3/customers/${GetStorage().read('customer_id')}';
    const String username = key; // Replace with WooCommerce API consumer key
    const String password =
        shhh; // Replace with WooCommerce API consumer secret
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    try {
      if (updatedData.isEmpty) {
        throw ("Please input information to update!");
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
        Get.snackbar("Success!", "Account details updated successfully.");
        print('Update successful: ${response.body}');
      } else {
        Get.snackbar("Error",
            "Failed to update account details.\nError Code ${response.statusCode}");
        print('Failed to update. Status code: ${response.body}');
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade900,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dmaDarkGrey,
      appBar: AppBar(
        title: "Update Account Details"
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: _inputDecoration("First Name"),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: _inputDecoration("Last Name"),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _displayNameController,
                decoration: _inputDecoration("Display Name"),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: _inputDecoration("Email").copyWith(
                  hintText: "${GetStorage().read('user_email')}",
                ),
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {

              //     setState(() {
              //       showPasswordFields = !showPasswordFields;
              //     });
              //   },
              //   child: const Text('Change Password'),
              // ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showPasswordFields = !showPasswordFields;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: dmaRed,
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(color: dmaWhite),
                ),
              ),
              if (showPasswordFields) ...[
                const SizedBox(height: 10),
                TextField(
                  controller: _currentPasswordController,
                  decoration: _inputDecoration("Current Password"),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _newPasswordController,
                  decoration: _inputDecoration("New Password"),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: _inputDecoration("Confirm Password"),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => updateAccountDetails(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: dmaRed,
                ),
                child: const Text(
                  'Update Account Details',
                  style: TextStyle(color: dmaWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
