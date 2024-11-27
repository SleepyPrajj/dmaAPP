import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/views/search_screen/search_suggestion_screen.dart';
import 'package:get/get.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02), // Slimmer padding
      child: SizedBox(
        height: screenWidth * 0.1, // Smaller height
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
              fontSize: screenWidth * 0.04, // Smaller text
              fontFamily: regular,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: screenWidth * 0.0015, // Slimmer border
                color: dmaRed,
              ),
              borderRadius: BorderRadius.circular(
                screenWidth * 0.02, // Smaller radius
              ),
            ),
            prefixIcon: Icon(
              Icons.search_outlined,
              size: screenWidth * 0.05, // Smaller icon
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.01, // Slimmer vertical padding
            ),
          ),
        ),
      ),
    );
  }
}
