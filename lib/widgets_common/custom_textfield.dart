import 'package:dma_inc/consts/consts.dart';

Widget customTextfield({
  String? title,
  String? hint,
  TextEditingController? controller,
  bool isPassword = false, // New optional parameter
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(dmaBlack).fontFamily(regular).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        obscureText: isPassword, // Use isPassword to toggle password masking
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontFamily: regular, color: darkFontGrey),
          hintText: hint,
          isDense: true,
          fillColor: dmaWhite,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: dmaRed),
          ),
        ),
      ),
      5.heightBox,
    ],
  );
}
