import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onCategorySelected;

  CategorySelector({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  final List<String> categories = ["All", "Trending", "Popular", "Upcoming"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: List.generate(categories.length, (index) {
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onCategorySelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: const Color(0xFF4A4458),
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
