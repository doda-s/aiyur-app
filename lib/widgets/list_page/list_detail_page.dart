import 'package:aiyurapp/widgets/home_page/movie_card.dart';
import 'package:flutter/material.dart';

class ListsDetailPage extends StatefulWidget {
  const ListsDetailPage({super.key});

  @override
  State<ListsDetailPage> createState() => _ListsDetailPageState();
}

class _ListsDetailPageState extends State<ListsDetailPage> {
  int _currentBottomIndex = 0;
  int _selectedCategoryIndex = 0;
  int? _selectedMovieIndex;

  final List<Map<String, String>> exampleMovieList = [
    {
      'title': 'Coruja da Noite',
      'image':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
      'category': 'Trending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Lists"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: exampleMovieList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final movie = exampleMovieList[index];
                  final isSelected = _selectedMovieIndex == index;

                  return MovieCard(
                    imageUrl: movie['image'] ?? '',
                    label: movie['title'] ?? '',
                    color: isSelected
                        ? const Color(0xFFF44336)
                        : Colors.grey[100]!,
                    onTap: () {
                      setState(() {
                        _selectedMovieIndex =
                            (_selectedMovieIndex == index) ? null : index;
                      });

                      Navigator.pushNamed(
                        context,
                        '/movieDetail',
                        arguments: {
                          'title': movie['title'] ?? '',
                          'imageUrl': movie['image'] ?? '',
                        },
                      );
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
