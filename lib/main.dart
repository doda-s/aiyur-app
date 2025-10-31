import 'package:aiyurapp/widgets/home_page/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/home_page/movie_card.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_detail.dart';
import 'package:aiyurapp/widgets/profile_page/profile_page.dart';
import 'package:aiyurapp/widgets/shared/profile.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My App',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/movieDetail') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              title: args['title']!,
              imageUrl: args['imageUrl']!,
            ),
          );
        }
        return null;
      },
      home: const SafeArea(child: PageContent()),
    ),
  );
}

// ---------------- TopAppBar ----------------
class TopAppBar extends StatelessWidget {
  final Widget title;
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;

  const TopAppBar({
    super.key,
    required this.title,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240, // aumentei um pouco para caber o CategorySelector
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
              ProfileButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  ),
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SearchBarWidget(),
          CategorySelector(
            selectedIndex: selectedCategoryIndex,
            onCategorySelected: onCategorySelected,
          ),
        ],
      ),
    );
  }
}

// ---------------- CategorySelector ----------------
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

// ---------------- PageContent ----------------
class PageContent extends StatefulWidget {
  const PageContent({super.key});

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  int _currentBottomIndex = 0;
  int _selectedCategoryIndex = 0;
  int? _selectedMovieIndex;

  final List<Map<String, String>> movies = [
    {
      'title': 'Coruja da Noite',
      'image':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
      'category': 'Trending',
    },
    {
      'title': 'Filme do Sol',
      'image':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      'category': 'Popular',
    },
    {
      'title': 'Montanha Misteriosa',
      'image': 'https://picsum.photos/200/300',
      'category': 'Upcoming',
    },
    {
      'title': 'Lago Sereno',
      'image': 'https://picsum.photos/200/301',
      'category': 'Trending',
    },
    {
      'title': 'Floresta Sombria',
      'image': 'https://picsum.photos/200/302',
      'category': 'Popular',
    },
    {
      'title': 'Horizonte Perdido',
      'image': 'https://picsum.photos/200/303',
      'category': 'Upcoming',
    },
  ];

  final List<String> categories = ["All", "Trending", "Popular", "Upcoming"];

  List<Map<String, String>> get filteredMovies {
    if (_selectedCategoryIndex == 0) return movies;
    final selectedCategory = categories[_selectedCategoryIndex];
    return movies
        .where((movie) => movie['category'] == selectedCategory)
        .toList();
  }

  Widget _getBody() {
    switch (_currentBottomIndex) {
      case 0: // Filmes
        return Column(
          children: [
            TopAppBar(
              title: const Text(
                "Catálogo de Filmes",
                style: TextStyle(color: Colors.white),
              ),
              selectedCategoryIndex: _selectedCategoryIndex,
              onCategorySelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: filteredMovies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final movie = filteredMovies[index];
                    final isSelected = _selectedMovieIndex == index;

                    return MovieCard(
                      imageUrl: movie['image']!,
                      label: movie['title']!,
                      color: isSelected
                          ? const Color(0xFFF44336)
                          : Colors.grey[100]!,
                      onTap: () {
                        setState(() {
                          _selectedMovieIndex = (_selectedMovieIndex == index)
                              ? null
                              : index;
                        });
                        Navigator.pushNamed(
                          context,
                          '/movieDetail',
                          arguments: {
                            'title': movie['title']!,
                            'imageUrl': movie['image']!,
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      case 1: // Favoritos
        return Column(
          children: [
            TopAppBar(
              title: const Text(
                "Favoritos",
                style: TextStyle(color: Colors.white),
              ),
              selectedCategoryIndex: _selectedCategoryIndex,
              onCategorySelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Lista de Favoritos",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        );

      case 2: // Perfil
        return const ProfilePage();

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) => setState(() => _currentBottomIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Filmes"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
