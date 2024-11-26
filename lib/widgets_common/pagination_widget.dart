import 'package:dma_inc/consts/colors.dart';
import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onPageSelected;

  const PaginationWidget({
    Key? key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  final int _maxButtons = 8;

  void selectPage(int page) {
    widget.onPageSelected(page);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pageButtons = [];

    // Adjust range of visible buttons based on widget.currentpage and totalPages
    int start, end;
    if (widget.totalPages <= _maxButtons) {
      // If total pages are within max limit, show all pages
      start = 1;
      end = widget.totalPages;
    } else {
      // Show the last set of pages if current page is near the end
      if (widget.currentPage > widget.totalPages - (_maxButtons - 2)) {
        start = widget.totalPages - (_maxButtons - 1);
        end = widget.totalPages;
      } else {
        // Normal range around the current page
        start = widget.currentPage > 4 ? widget.currentPage - 3 : 1;
        end = start + _maxButtons - 1;

        // Ensure end doesn't exceed totalPages
        if (end > widget.totalPages) {
          end = widget.totalPages;
        }
      }
    }

    // Build pagination buttons based on calculated start and end
    for (int i = start; i <= end; i++) {
      pageButtons.add(_buildPageButton(i));
    }

    // Show ellipsis and last page if not displaying the full range
    if (end < widget.totalPages) {
      pageButtons.add(_buildEllipsis());
      pageButtons.add(_buildPageButton(widget.totalPages));
    }

    return Wrap(
      spacing: 8.0,
      children: pageButtons,
    );
  }

  Widget _buildPageButton(int pageNumber) {
    return GestureDetector(
      onTap: () => selectPage(pageNumber),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: widget.currentPage == pageNumber ? dmaRed : Colors.grey[300],
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          '$pageNumber',
          style: TextStyle(
            color: widget.currentPage == pageNumber ? dmaWhite : dmaBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: const Text(
        '...',
        style: TextStyle(
          color: dmaWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
