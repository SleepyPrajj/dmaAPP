import 'package:dma_inc/consts/consts.dart';
// import 'package:get/get.dart';

Widget ourButton(onPress, displayColor, textColor, String? title) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: displayColor,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title?.text.color(textColor).fontFamily(bold).make());
}
