import 'package:dma_inc/services/signup_services.dart';
import 'package:dma_inc/views/auth_screen/login_screen.dart';
import 'package:dma_inc/widgets_common/bg_widget.dart';
import 'package:dma_inc/widgets_common/applogo_widget.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/widgets_common/custom_textfield.dart';
import 'package:dma_inc/widgets_common/our_button.dart';
import 'package:dma_inc/widgets_common/private_policy_dialogue.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final List<String> usStates = [
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Louisiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennsylvania',
  'Rhode Island',
  'South Carolina',
  'South Dakota',
  'Tennessee',
  'Texas',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virginia',
  'Wisconsin',
  'Wyoming'
];

class _SignUpState extends State<SignUp> {
  String selectedBillingCountry =
      'Puerto Rico'; // Default selected value for billing
  String selectedShippingCountry =
      'Puerto Rico'; // Default selected value for shipping
  String? selectedBillingState; // Stores selected billing state
  String? selectedShippingState; // Stores selected shipping state
  bool? isCheck = false;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final taxIdController = TextEditingController();
  final companyController = TextEditingController();
  final billingAddressController = TextEditingController();
  final billingAddress2Controller = TextEditingController();
  final billingCityController = TextEditingController();
  final billingZipController = TextEditingController();
  final shippingAddressController = TextEditingController();
  final shippingAddress2Controller = TextEditingController();
  final shippingCityController = TextEditingController();
  final shippingZipController = TextEditingController();

  final SignupServices apiService = Get.put(SignupServices());

  void _submitForm() async {
    if (!_validateForm()) return;

    final userData = {
      "email": emailController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "username": usernameController.text,
      "password": passwordController.text,
      "billing": {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "company": companyController.text,
        "address_1": billingAddressController.text,
        "address_2": billingAddress2Controller.text,
        "city": billingCityController.text,
        "postcode": billingZipController.text,
        "country": selectedBillingCountry,
        "state": selectedBillingState,
        "email": emailController.text,
        "phone": phoneController.text
      },
      "shipping": {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "company": companyController.text,
        "address_1": shippingAddressController.text,
        "address_2": shippingAddress2Controller.text,
        "city": shippingCityController.text,
        "postcode": shippingZipController.text,
        "country": selectedShippingCountry,
        "state": selectedShippingState,
      },
      "registration_taxid": taxIdController.text
    };
    try {
      final response = await apiService.createUser(userData);
      if (response != null) {
        Get.snackbar(
          'Success',
          'User created successfully\nPlease wait for an email for verification',
          animationDuration: const Duration(seconds: 2),
          duration: const Duration(
              seconds: 2), // Ensure the Snackbar has a defined duration
        );

        // Navigate to Login screen after Snackbar duration
        Future.delayed(const Duration(seconds: 2), () {
          Get.to(() => const Login()); // Navigate after 2 seconds
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // bool _validateForm() {
  //   if (usernameController.text.isEmpty ||
  //       emailController.text.isEmpty ||
  //       passwordController.text.isEmpty ||
  //       confirmPasswordController.text.isEmpty ||
  //       firstNameController.text.isEmpty ||
  //       lastNameController.text.isEmpty ||
  //       phoneController.text.isEmpty) {
  //     Get.snackbar('Error', 'Please fill out all required fields');
  //     return false;
  //   }

  //   if (passwordController.text != confirmPasswordController.text) {
  //     Get.snackbar('Error', 'Passwords do not match');
  //     return false;
  //   }

  //   if (!isCheck!) {
  //     Get.snackbar('Error', 'Please agree to the Terms and Conditions');
  //     return false;
  //   }
  //   return true;
  // }
  bool _validateForm() {
    // List of required fields
    final requiredFields = [
      usernameController.text,
      emailController.text,
      passwordController.text,
      confirmPasswordController.text,
      firstNameController.text,
      lastNameController.text,
      taxIdController.text,
      phoneController.text,
      billingAddressController.text,
      shippingAddressController.text,
      billingCityController.text,
      billingZipController.text,
      shippingCityController.text,
      shippingZipController.text,
    ];

    // Check if any required field is empty
    for (var field in requiredFields) {
      if (field.trim().isEmpty) {
        Get.snackbar('Error', 'Please fill out $field');
        return false;
      }
    }

    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return false;
    }

    // Check if terms and conditions are accepted
    if (!isCheck!) {
      Get.snackbar('Error', 'Please agree to the Terms and Conditions');
      return false;
    }

    return true; // All validations passed
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              "Sign up to $appName".text.fontFamily(bold).white.size(18).make(),
              20.heightBox,
              Column(
                children: [
                  "Login Details"
                      .text
                      .fontFamily(bold)
                      .color(dmaRed)
                      .size(16)
                      .make(),
                  customTextfield(
                      hint: "Username",
                      title: "Username",
                      controller: usernameController),
                  customTextfield(
                      hint: emailHint,
                      title: "Email",
                      controller: emailController),
                  customTextfield(
                      hint: passwordHint,
                      title: password,
                      isPassword: true,
                      controller: passwordController),
                  customTextfield(
                      hint: passwordHint,
                      title: "Confirm Password",
                      isPassword: true,
                      controller: confirmPasswordController),
                  10.heightBox,
                  "Personal Details"
                      .text
                      .fontFamily(bold)
                      .color(dmaRed)
                      .size(16)
                      .make(),
                  customTextfield(
                      hint: "Prajjwal",
                      title: "First Name",
                      controller: firstNameController),
                  customTextfield(
                      hint: "Goswami",
                      title: "Last Name",
                      controller: lastNameController),
                  customTextfield(
                      hint: "(___) ___-____",
                      title: "Phone Number",
                      controller: phoneController),
                  customTextfield(
                      hint: "Tax ID",
                      title: "Tax ID/EIN Number",
                      controller: taxIdController),
                  10.heightBox,
                  "Billing Details"
                      .text
                      .fontFamily(bold)
                      .color(dmaRed)
                      .size(16)
                      .make(),
                  customTextfield(
                      hint: "DMA inc",
                      title: "Company Name",
                      controller: companyController),
                  customTextfield(
                      hint: "3015 E Randol Mill Rd",
                      title: "Billing Address",
                      controller: billingAddressController),
                  customTextfield(
                      hint: "Arlington",
                      title: "Billing Address 2",
                      controller: billingAddress2Controller),
                  customTextfield(
                      hint: "Texas",
                      title: "Billing City",
                      controller: billingCityController),

                  // Aligning the text to the left for billing country
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: "Select a billing country or region."
                        .text
                        .align(TextAlign.left)
                        .color(dmaBlack)
                        .fontFamily(regular)
                        .size(16)
                        .make(),
                  ),

                  // Dropdown Button for billing country selection
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: dmaGrey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: DropdownButton<String>(
                      value: selectedBillingCountry,
                      items: <String>['Puerto Rico', 'United States']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBillingCountry = newValue!;
                          selectedBillingState = null;
                        });
                      },
                      underline: Container(),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, color: dmaGrey),
                    ),
                  ),
                  5.heightBox,
                  // Show billing state dropdown if the United States is selected
                  if (selectedBillingCountry == 'United States')
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: dmaGrey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: DropdownButton<String>(
                        value: selectedBillingState,
                        hint: const Text('Select State'),
                        items: usStates.map((String state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(
                              state,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newState) {
                          setState(() {
                            selectedBillingState = newState;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),

                  customTextfield(
                      hint: "76011",
                      title: "Billing Zip",
                      controller: billingZipController),
                  10.heightBox,
                  "Shipping Details"
                      .text
                      .fontFamily(bold)
                      .color(dmaRed)
                      .size(16)
                      .make(),
                  customTextfield(
                      hint: "Pentagon",
                      title: "Shipping Address",
                      controller: shippingAddressController),
                  customTextfield(
                      hint: "Near the Coffee Maker",
                      title: "Shipping Address 2",
                      controller: shippingAddress2Controller),
                  customTextfield(
                      hint: "Arlington",
                      title: "Shipping City",
                      controller: shippingCityController),

                  // Aligning the text to the left for shipping country
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: "Select a shipping country or region."
                        .text
                        .align(TextAlign.left)
                        .color(dmaBlack)
                        .fontFamily(regular)
                        .size(16)
                        .make(),
                  ),

                  // Dropdown Button for shipping country selection
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: dmaGrey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: DropdownButton<String>(
                      value: selectedShippingCountry,
                      items: <String>['Puerto Rico', 'United States']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedShippingCountry = newValue!;
                          selectedShippingState = null;
                        });
                      },
                      underline: Container(),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, color: dmaGrey),
                    ),
                  ),
                  5.heightBox,
                  // Show billing state dropdown if the United States is selected
                  if (selectedShippingCountry == 'United States')
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: dmaGrey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: DropdownButton<String>(
                        value: selectedShippingState,
                        hint: const Text('Select State'),
                        items: usStates.map((String state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(
                              state,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newState) {
                          setState(() {
                            selectedShippingState = newState;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),

                  customTextfield(
                      hint: "76011",
                      title: "Shipping Zip",
                      controller: shippingZipController),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          checkColor: dmaRed,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                                fontFamily: bold, color: darkFontGrey),
                          ),
                          TextSpan(
                            text: "Terms and Conditions",
                            style: TextStyle(fontFamily: bold, color: dmaRed),
                          )
                        ])).onTap(() {
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
                      )
                    ],
                  ),
                  ourButton(_submitForm, isCheck == true ? dmaRed : dmaGrey,
                          dmaWhite, signup)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  5.heightBox,
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: "Already Have an account? ",
                          style:
                              TextStyle(fontFamily: bold, color: darkFontGrey)),
                      TextSpan(
                          text: login,
                          style: TextStyle(fontFamily: bold, color: dmaRed))
                    ]),
                  ).onTap(() {
                    Get.back();
                  })
                ],
              )
                  .box
                  .color(warmWhite)
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make()
            ],
          ),
        ),
      ),
    ));
  }
}
