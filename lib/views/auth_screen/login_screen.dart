import 'package:dma_inc/views/auth_screen/forgot_password.dart';
import 'package:dma_inc/views/auth_screen/signup_screen.dart';
import 'package:dma_inc/widgets_common/bg_widget.dart';
import 'package:dma_inc/widgets_common/applogo_widget.dart';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/widgets_common/custom_textfield.dart';
import 'package:dma_inc/widgets_common/our_button.dart';
import 'package:dma_inc/api_controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController authController = Get.put(LoginController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (screenHeight * 0.1).heightBox,
              applogoWidget(),
              "Log in to $appName"
                  .text
                  .fontFamily(bold)
                  .white
                  .size(screenWidth * 0.045)
                  .make(),
              (screenHeight * 0.02).heightBox,
              Column(
                children: [
                  customTextfield(
                    hint: emailHint,
                    title: email,
                    controller: authController.emailController,
                  ),
                  customTextfield(
                    hint: passwordHint,
                    title: password,
                    isPassword: true,
                    controller: authController.passwordController,
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: forgetPass.text.make(),
                  //   ),
                  // ),
                  ForgetPassword(),
                  (screenHeight * 0.01).heightBox,
                  Obx(() => authController.isLoading.value
                      ? Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                              color: dmaRed, size: 40))
                      : ourButton(() {
                          authController.loginUser();
                        }, dmaRed, dmaWhite, login)
                          .box
                          .width(screenWidth * 0.85)
                          .make()),
                  (screenHeight * 0.01).heightBox,
                  or.text.color(dmaGrey).make(),
                  (screenHeight * 0.01).heightBox,
                  ourButton(() {
                    Get.to(() => const SignUp());
                  }, lightgolden, dmaRed, signup)
                      .box
                      .width(screenWidth * 0.85)
                      .make(),
                ],
              )
                  .box
                  .color(warmWhite)
                  .rounded
                  .padding(EdgeInsets.all(screenWidth * 0.04))
                  .width(screenWidth * 0.9)
                  .shadowSm
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
