import 'dart:developer';
import 'dart:io';
import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/item_details/item_details_screen.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log('Running on ${androidInfo.model}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      log('Running on ${iosInfo.model}');
    }
  }

  final String pdfUrl =
      "https://dmainc.b-cdn.net/wp-content/uploads/2024/08/DMA_Catalog2024_New.pdf";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: dmaDarkGrey,
      appBar: AppBar(
        title: "Our Catalog".text.color(dmaWhite).bold.make(),
        backgroundColor: dmaDarkGrey,
        iconTheme: const IconThemeData(color: dmaWhite),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Catalog".text.size(screenWidth * 0.07).bold.color(dmaRed).make(),
            SizedBox(height: screenHeight * 0.02),
            "Catalogs featured the full range of items sold by DMA-inc, from gun parts to accessories. This Catalog served as a bridge between the company direct B2B and mail ordering."
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
                  onPressed: () {
                    Get.to(() =>
                        const ItemScreen(title: "DMA Catalog", id: 189305));
                  },
                  child: "REQUEST"
                      .text
                      .size(screenWidth * 0.035)
                      .color(dmaWhite)
                      .make(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: dmaRed,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
                      ),
                    );
                  },
                  child: "VIEW"
                      .text
                      .size(screenWidth * 0.035)
                      .color(dmaWhite)
                      .make(),
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: dmaRed,
                //     padding: EdgeInsets.symmetric(
                //       horizontal: screenWidth * 0.03,
                //       vertical: screenHeight * 0.015,
                //     ),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   onPressed: () {
                //     _downloadFile(context, pdfUrl);
                //   },
                //   child: "DOWNLOAD"
                //       .text
                //       .size(screenWidth * 0.035)
                //       .color(dmaWhite)
                //       .make(),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _downloadFile(BuildContext context, String url) async {
  //   // PermissionStatus status = await Permission.manageExternalStorage.status;
  //   PermissionStatus status = await Permission.storage.status;
  //   print(status);

  //   status = await Permission.storage.request();
  //   print(status);

  //   try {
  //     if (status.isGranted) {
  //       Directory? directory;
  //       if (Platform.isAndroid) {
  //         directory = await getExternalStorageDirectory();
  //       } else {
  //         directory = await getApplicationDocumentsDirectory();
  //       }

  //       String savePath = "${directory!.path}/DMA_Catalog2024.pdf";

  //       Dio dio = Dio();
  //       await dio.download(url, savePath);

  //       Get.snackbar("Downloaded!", "Downloaded Catalog saved to $savePath");
  //     } else if (status.isDenied) {
  //       Get.snackbar("Permission Denied!", "Download permission denied :(");
  //       // Permission not granted, show dialog to prompt the user

  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: const Text('Storage Permission Required'),
  //             content: const Text(
  //                 'This app requires "All files access" to function correctly. Please enable it in the settings.'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () async {
  //                   // Open app settings to allow the user to manually enable the permission
  //                   await openAppSettings();
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('Open Settings'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   // Open app settings to allow the user to manually enable the permission
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Cancel'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else if (status.isPermanentlyDenied) {
  //       // If permanently denied, show an alternative message
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Permission Permanently Denied'),
  //           content: const Text(
  //               'You have permanently denied storage permission. Please enable it in the app settings manually.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () async {
  //                 await openAppSettings();
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Open Settings'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 // Open app settings to allow the user to manually enable the permission
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('Cancel'),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar("Failed!", "Failed to download file. $e");
  //   }
  // }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: dmaWhite),
        title: "View our Catalog"
            .text
            .size(25)
            .color(dmaWhite)
            .fontFamily(badSu)
            .make(),
        backgroundColor: dmaDarkGrey,
      ),
      body: SfPdfViewer.asset(
        'assets/images/DMA_Catalog2024.pdf',
        controller: PdfViewerController(),
      ),
    );
  }
}
