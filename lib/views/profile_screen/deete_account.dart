import 'dart:io';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.model}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: dmaDarkGrey,
      appBar: AppBar(
        title: "Account Deletion".text.color(dmaWhite).bold.make(),
        backgroundColor: dmaDarkGrey,
        iconTheme: const IconThemeData(color: dmaWhite),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Delete Your account!"
                .text
                .size(screenWidth * 0.07)
                .bold
                .color(dmaRed)
                .make(),
            SizedBox(height: screenHeight * 0.02),
            "This action cannot be reversed, if you want your account back you will have to make a new account.\nThis action will take 1-3 business days to complete."
                .text
                .size(screenWidth * 0.045)
                .color(dmaWhite)
                .make(),
            "\nKindly inclue your name and registered email to the mail you are sending."
                .text
                .size(screenWidth * 0.045)
                .color(dmaWhite)
                .make(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dmaRed,
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.030,
                        vertical: screenHeight * 0.015),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    const email = 'michael@dma-inc.net';
                    const subject = 'Account Deletion Email';
                    const body = 'Your Name:\nYour Email:';
                    final emailUri = Uri(
                      scheme: 'mailto',
                      path: email,
                      query: 'subject=$subject&body=$body',
                    );

                    try {
                      // Ensure proper mode is used
                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(
                          emailUri,
                          mode: LaunchMode
                              .externalApplication, // Ensures opening in external app
                        );
                      } else {
                        throw 'Could not launch $emailUri';
                      }
                    } catch (e) {
                      print(e); // Log or show error to the user
                    }
                  },
                  child: "REQUEST DELETION"
                      .text
                      .size(screenWidth * 0.035)
                      .color(dmaWhite)
                      .make(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
