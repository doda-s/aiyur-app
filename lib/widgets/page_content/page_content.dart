import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/home_page/movie_card.dart';
import 'package:aiyurapp/widgets/profile_page/profile_page.dart';
import 'package:aiyurapp/widgets/list_page/list_page.dart';
import 'package:aiyurapp/services/tmdb_service.dart';
import 'dart:convert';

import '../top_app_bar/top_app_bar.dart';

final tmdb = TmdbService();

class PageContent extends StatefulWidget {
  const PageContent({super.key});

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  int _currentBottomIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<String> categories = ["All", "Trending", "Popular", "Upcoming"];

  List movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final result = await tmdb.discoverMovies();

      var moviesList = [];

      for (var element in result['results']) {
        moviesList.add(element);
      }

      setState(() {
        movies = moviesList;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  List<dynamic> get filteredMovies {
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
                  itemCount: movies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    print(movie);
                    return MovieCard(
                      imageUrl: movie['backdrop_path'] ?? movie['poster_path'],
                      label: movie['title']!,
                      description: movie['overview']!,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/movieDetail',
                          arguments: {'movieId': movie['id']!},
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
