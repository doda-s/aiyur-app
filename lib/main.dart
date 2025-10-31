import 'package:aiyurapp/widgets/home_page/category_selector.dart';
import 'package:aiyurapp/widgets/home_page/movie_card.dart';
import 'package:aiyurapp/widgets/home_page/search_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'My app',
      home: SafeArea(child: Scaffold(body: PageContent())),
    ),
  );
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Column(
        children: [
          Row(
            children: [
              const IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Navigation menu',
                onPressed: null,
              ),
              Expanded(child: title),
              const IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search',
                onPressed: null,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SearchBarWidget(),
          const CategorySelector(),
        ],
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  const PageContent({super.key});

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  int? _selectedIndex;

  final movies = [
    {
      'title': 'Coruja da Noite',
      'image':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
    },
    {
      'title': 'Filme do Sol',
      'image':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    },
    {'title': 'Montanha Misteriosa', 'image': 'https://picsum.photos/200/300'},
    {'title': 'Lago Sereno', 'image': 'https://picsum.photos/200/301'},
    {'title': 'Floresta Sombria', 'image': 'https://picsum.photos/200/302'},
    {'title': 'Horizonte Perdido', 'image': 'https://picsum.photos/200/303'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TopAppBar(
            title: Text(
              "Catálogo de Filmes",
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final bool isSelected = _selectedIndex == index;

                  return MovieCard(
                    imageUrl: movie['image']!,
                    label: movie['title']!,
                    color: isSelected
                        ? const Color.fromRGBO(244, 67, 54, 1) // vermelho
                        : Colors.grey[100]!, // padrão
                    onTap: () {
                      setState(() {
                        _selectedIndex = (_selectedIndex == index)
                            ? null
                            : index;
                      });
                      print("Selecionado: ${movie['title']}");
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
