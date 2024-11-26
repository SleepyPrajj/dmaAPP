import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/search_screen/search_suggestion_screen.dart';
import 'package:get/get.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02), // Dynamic padding
      child: SizedBox(
        height: screenWidth * 0.12, // Dynamic height
        child: TextField(
          keyboardType: TextInputType.none,
          showCursor: false,
          onTap: () {
            Get.to(() => const SearchSuggestionScreen());
          },
          decoration: InputDecoration(
            fillColor: dmaWhite,
            filled: true,
            hintText: search,
            hintStyle: TextStyle(
              fontSize: screenWidth * 0.05, // Dynamic font size
              fontFamily: regular,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: screenWidth * 0.002,
                  color: dmaRed), // Dynamic border width
              borderRadius: BorderRadius.circular(
                  screenWidth * 0.025), // Dynamic border radius
            ),
            prefixIcon: Icon(
              Icons.search_outlined,
              size: screenWidth * 0.07, // Dynamic icon size
            ),
          ),
        ),
      ),
    );
  }
}
