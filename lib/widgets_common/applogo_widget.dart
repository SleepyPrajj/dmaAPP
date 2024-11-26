import 'package:dma_inc/consts/consts.dart';

Widget applogoWidget() {
  //using velocity x
  return Image.asset(dmaLogo)
      .box
      .size(200, 200)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
