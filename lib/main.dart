import 'package:aiyurapp/widgets/home_page/category_selector.dart';
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

class PageContent extends StatelessWidget {
  const PageContent({super.key});

  @override
  Widget build(BuildContext context) {
    
    //TODO: RETIRAR MOCK E COLOCAR API
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
      {
        'title': 'Montanha Misteriosa',
        'image': 'https://picsum.photos/200/300',
      },
      {
        'title': 'Lago Sereno',
        'image': 'https://picsum.photos/200/301',
      },
      {
        'title': 'Floresta Sombria',
        'image': 'https://picsum.photos/200/302',
      },
      {
        'title': 'Horizonte Perdido',
        'image': 'https://picsum.photos/200/303',
      },
    ];

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
                padding: EdgeInsets.only(bottom: 100),
                itemCount: movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ImageBox(
                    imageUrl: movie['image']!,
                    label: movie['title']!,
                    onTap: () {
                      print('Clicou em ${movie['title']}');
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

class ImageBox extends StatelessWidget {
  final String imageUrl;
  final String label;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;

  const ImageBox({
    super.key,
    required this.imageUrl,
    required this.label,
    this.width = 160,
    this.height = 200,
    this.borderRadius = 12,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(borderRadius)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: height * 0.75,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
