import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int _selectedIndex = 0;

  // TODO: ver como passar esses valores como refencia para poder trocar os filmes/series que aparecem na tela
  final List<String> categories = [
    "All",
    "Trending",
    "Popular",
    "Upcoming",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0), // cinza claro do fundo
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(categories.length, (index) {
          final isSelected = _selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: const Color(0xFF4A4458),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
