import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/home_page/movie_card.dart';

class ListsDetailPage extends StatefulWidget {
  const ListsDetailPage({super.key});

  @override
  State<ListsDetailPage> createState() => _ListsDetailPageState();
}

class _ListsDetailPageState extends State<ListsDetailPage> {
  int? _selectedMovieIndex;

  final List<Map<String, String>> exampleMovieList = [
    {
      'title': 'Coruja da Noite',
      'image':
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
      'category': 'Trending',
    },
    {
      'title': 'Amanhecer Sombrio',
      'image': 'https://picsum.photos/200/301',
      'category': 'New',
    },
  ];

  void _confirmarRemocao(int index) {
    final movie = exampleMovieList[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5F5),
        title: const Text(
          "Remove Movie",
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to remove '${movie["title"]}'?",
          style: const TextStyle(color: Color(0xFF5E5E5E)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color(0xFF4A4A4A)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A4A4A),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                exampleMovieList.removeAt(index);
                _selectedMovieIndex = null;
              });
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          "My Lists",
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE0E0E0),
        foregroundColor: const Color(0xFF4A4A4A),
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

                  return Stack(
                    children: [
                      GestureDetector(
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
                              'title': movie['title'] ?? '',
                              'imageUrl': movie['image'] ?? '',
                            },
                          );
                        },
                        child: MovieCard(
                          imageUrl: movie['image'] ?? '',
                          label: movie['title'] ?? '',
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
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => _confirmarRemocao(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF4A4A4A),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
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
