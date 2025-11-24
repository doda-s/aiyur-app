import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/home_page/movie_card.dart';
import 'package:aiyurapp/widgets/profile_page/profile_page.dart';
import 'package:aiyurapp/widgets/list_page/list_page.dart';

import '../top_app_bar/top_app_bar.dart';

class PageContent extends StatefulWidget {
  const PageContent({super.key});

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  int _currentBottomIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<String> categories = ["All", "Trending", "Popular", "Upcoming"];

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

  List<Map<String, String>> get filteredMovies {
    if (_selectedCategoryIndex == 0) return movies;
    final category = categories[_selectedCategoryIndex];
    return movies.where((m) => m['category'] == category).toList();
  }

  Widget _getBody() {
    switch (_currentBottomIndex) {
      case 0:
        return Column(
          children: [
            TopAppBar(
              title: const Text(
                "Movies",
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedCategoryIndex: _selectedCategoryIndex,
              onCategorySelected: (index) {
                setState(() => _selectedCategoryIndex = index);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  itemCount: filteredMovies.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final movie = filteredMovies[index];
                    return MovieCard(
                      imageUrl: movie['image']!,
                      label: movie['title']!,
                      onTap: () {
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

      case 1:
        return const ProfilePage();

      case 2:
        return const MyListsPage();

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        selectedItemColor: const Color(0xFF4A4A4A),
        unselectedItemColor: const Color(0xFF5E5E5E),
        backgroundColor: const Color(0xFFE0E0E0),
        onTap: (i) => setState(() => _currentBottomIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Filmes"),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: "Profile",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "My Lists"),
        ],
      ),
    );
  }
}
