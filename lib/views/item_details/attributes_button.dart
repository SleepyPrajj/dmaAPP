import 'package:dma_inc/consts/consts.dart';
import 'package:dma_inc/models/item_details_model.dart';

class AttributesButton extends StatelessWidget {
  final Attributes attribute; // Attribute item containing options
  final String? selectedOption; // Currently selected option for this attribute
  final ValueChanged<String> onOptionSelected; // Callback for option selection

  const AttributesButton({
    Key? key,
    required this.attribute,
    required this.selectedOption,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${attribute.name}:",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, fontFamily: bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: attribute.options!.map((option) {
            final isSelected = option == selectedOption;
            return GestureDetector(
              onTap: () => onOptionSelected(option),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? dmaRed : Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                      color: isSelected ? dmaRed : Colors.grey, width: 3),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                      fontSize: 15,
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontFamily: isSelected ? bold : regular),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
