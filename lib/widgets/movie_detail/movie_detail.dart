import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(title), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // fundo com gradiante precisa desse pedaço todo: logica copiada para o restante que tbm usa
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Neon Horizon",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[700],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        "⭐ 89%",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text("Finished"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Os botões crimes ficam aqui
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => {print("clicou no coração")},
                              child: const Icon(Icons.favorite_border),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => {print("clicou na list")},
                              child: const Icon(Icons.bookmark_border),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Informações do filme
                      Row(
                        children: const [
                          Icon(Icons.calendar_today, size: 18),
                          SizedBox(width: 8),
                          Text("2024"),
                          SizedBox(width: 20),
                          Icon(Icons.access_time, size: 18),
                          SizedBox(width: 8),
                          Text("2h 18m"),
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        "Genres",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text("Sci-Fi")),
                          Chip(label: Text("Thriller")),
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        "Synopsis",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "In a dystopian future, a rogue hacker discovers a conspiracy that threatens the digital consciousness of humanity.",
                        style: TextStyle(color: Colors.black87, height: 1.4),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
