import 'package:dma_inc/consts/consts.dart';

class FilterButton extends StatefulWidget {
  final String categoryName;
  const FilterButton({super.key, required this.categoryName});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  void _showFilterMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              // Top section with "Filters" and "Clear All"
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "FILTERS",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement clear all logic
                      },
                      child: const Text(
                        "CLEAR ALL",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Expanded(
                child: Row(
                  children: [
                    // Left section with filter categories
                    Container(
                      width: 150,
                      color: Colors.grey.shade200,
                      child: ListView(
                        children: [
                          _buildFilterCategory("All Gun Parts"),
                          _buildFilterCategory("AR 15"),
                          _buildFilterCategory("AR 10"),
                          _buildFilterCategory("AK 47"),
                          _buildFilterCategory("GLOCK®"),
                          _buildFilterCategory("Gun \nAccessories"),
                          // Add more categories as needed
                        ],
                      ),
                    ),
                    // Right section with filter options
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          _buildFilterOption("Shirts", 132613),
                          _buildFilterOption("Blazers", 4771),
                          _buildFilterOption("Jackets", 18538),
                          _buildFilterOption("Kurtas", 24856),
                          _buildFilterOption("Sweaters", 10229),
                          _buildFilterOption("Sweatshirts", 27691),
                          _buildFilterOption("Tshirts", 130060),
                          _buildFilterOption("Tunics", 1),
                          // Add more options as needed
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              // Bottom section with "Close" and "Apply" buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the filter menu
                      },
                      child: const Text(
                        "CLOSE",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Implement apply filters logic
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Apply button color
                      ),
                      child: const Text(
                        "APPLY",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterCategory(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () {
        // Implement category selection logic
      },
    );
  }

  Widget _buildFilterOption(String option, int count) {
    return ListTile(
      title: Text(option),
      onTap: () {
        // Implement option selection logic
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
