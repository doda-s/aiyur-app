import 'package:aiyurapp/widgets/home_page/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/shared/profile.dart';
import 'package:aiyurapp/widgets/home_page/search_bar.dart';

class TopAppBar extends StatelessWidget {
  final Widget title;
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;

  final Function(String) onSearch; // <-- callback de busca

  const TopAppBar({
    super.key,
    required this.title,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
    required this.onSearch, // <-- obrigatório
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
      child: Column(
        children: [
          Row(
            children: [
              const IconButton(
                icon: Icon(Icons.movie, color: Color(0xFF4A4A4A)),
                onPressed: null,
              ),
              Expanded(child: title),
              ProfileButton(
                onPressed: () {
                  print("clicou no profile superior");
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ====== AJUSTE: SearchBarWidget com callback ======
          SearchBarWidget(
            onSearch: onSearch, // <-- repassa para cima
          ),

          CategorySelector(
            selectedIndex: selectedCategoryIndex,
            onCategorySelected: onCategorySelected,
          ),
        ],
      ),
    );
  }
}
