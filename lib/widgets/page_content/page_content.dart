import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/home_page/movie_card.dart';
import 'package:aiyurapp/widgets/profile_page/profile_page.dart';
import 'package:aiyurapp/widgets/list_page/list_page.dart';
import 'package:aiyurapp/services/tmdb_service.dart';

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

  bool _isSearching = false; // <-- flag para busca
  List _searchResults = []; // <-- resultados da busca

  final List<String> categories = ["All", "Trending", "Popular", "Upcoming"];

  // ---- ESTADOS POR CATEGORIA ----
  Map<String, List> moviesByCategory = {
    "All": [],
    "Trending": [],
    "Popular": [],
    "Upcoming": [],
  };

  Map<String, int> pageByCategory = {
    "All": 1,
    "Trending": 1,
    "Popular": 1,
    "Upcoming": 1,
  };

  Map<String, bool> isLoadingByCategory = {
    "All": true,
    "Trending": true,
    "Popular": true,
    "Upcoming": true,
  };

  Map<String, bool> isLoadingMoreByCategory = {
    "All": false,
    "Trending": false,
    "Popular": false,
    "Upcoming": false,
  };

  Map<String, bool> hasMoreByCategory = {
    "All": true,
    "Trending": true,
    "Popular": true,
    "Upcoming": true,
  };

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadCategory("All");

    _scrollController.addListener(() {
      if (_isSearching) return; // <-- desabilita scroll infinito em busca

      final category = categories[_selectedCategoryIndex];

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        loadMoreForCategory(category);
      }
    });
  }

  // ---- BUSCA ----
  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    _isSearching = true;
    setState(() {});

    final result = await tmdb.searchMovies(query);

    setState(() {
      _searchResults = result["results"] ?? [];
    });
  }

  // ---- CARREGAR PRIMEIRA PÁGINA DA CATEGORIA ----
  Future<void> loadCategory(String category) async {
    isLoadingByCategory[category] = true;
    setState(() {});

    final page = pageByCategory[category]!;
    Map result;

    try {
      switch (category) {
        case "Trending":
          result = await tmdb.getTopRated(page: page);
          break;

        case "Popular":
          result = await tmdb.getPopular(page: page);
          break;

        case "Upcoming":
          result = await tmdb.getUpcomingReleases(page: page);
          break;

        default:
          result = await tmdb.discoverMovies(page: page);
      }

      final items = result["results"] ?? [];

      moviesByCategory[category] = items;
      hasMoreByCategory[category] = items.isNotEmpty;
    } catch (e) {
      hasMoreByCategory[category] = false;
    }

    isLoadingByCategory[category] = false;
    setState(() {});
  }

  // ---- CARREGAR MAIS ----
  Future<void> loadMoreForCategory(String category) async {
    if (_isSearching) return; // <-- desativa quando está buscando

    if (isLoadingMoreByCategory[category] == true ||
        hasMoreByCategory[category] == false)
      return;

    isLoadingMoreByCategory[category] = true;
    setState(() {});

    pageByCategory[category] = pageByCategory[category]! + 1;

    Map result;

    try {
      final page = pageByCategory[category]!;

      switch (category) {
        case "Trending":
          result = await tmdb.getPopular(page: page);
          break;

        case "Popular":
          result = await tmdb.getTopRated(page: page);
          break;

        case "Upcoming":
          result = await tmdb.getUpcomingReleases(page: page);
          break;

        default:
          result = await tmdb.discoverMovies(page: page);
      }

      final newItems = result["results"] ?? [];

      if (newItems.isEmpty) {
        hasMoreByCategory[category] = false;
        isLoadingMoreByCategory[category] = false;
        setState(() {});
        return;
      }

      moviesByCategory[category]!.addAll(newItems);
    } catch (e) {
      hasMoreByCategory[category] = false;
    }

    isLoadingMoreByCategory[category] = false;
    setState(() {});
  }

  // ---- BODY ----
  Widget _getBody() {
    switch (_currentBottomIndex) {
      case 0:
        return _buildMoviesPage();
      case 1:
        return const ProfilePage();
      case 2:
        return const MyListsPage();
      default:
        return const SizedBox();
    }
  }

  Widget _buildMoviesPage() {
    final category = categories[_selectedCategoryIndex];
    final movies = _isSearching ? _searchResults : moviesByCategory[category]!;

    final loading = _isSearching ? false : isLoadingByCategory[category]!;

    final loadingMore = _isSearching
        ? false
        : isLoadingMoreByCategory[category]!;

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
            _isSearching = false;
            _searchResults = [];

            final newCategory = categories[index];
            _selectedCategoryIndex = index;

            if (moviesByCategory[newCategory]!.isEmpty) {
              loadCategory(newCategory);
            }

            setState(() {});
          },

          onSearch: _searchMovies, // <-- integração com TopAppBar
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    controller: _scrollController,
                    itemCount: movies.length + (loadingMore ? 1 : 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      if (index == movies.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final movie = movies[index];

                      return MovieCard(
                        imageUrl:
                            (movie['backdrop_path'] ?? movie['poster_path']) ??
                            "",
                        label: movie['title'] ?? "",
                        description: movie['overview'] ?? "",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/movieDetail',
                            arguments: {'movieId': movie['id']},
                          );
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
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
