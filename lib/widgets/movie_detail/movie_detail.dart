import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final String title;
  final String imageUrl;

  const MovieDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final List<Map<String, String>> _userLists = [
    {"title": "Favorites", "description": "My all-time favorite movies"},
    {"title": "Watch Later", "description": "Movies I want to see soon"},
    {"title": "Sci-Fi Collection", "description": "Best futuristic titles"},
  ];

  // ----------------------- Popup de Seleção de Lista -----------------------
  void _mostrarPopupListas() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFFF5F5F5),
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Color(0xFF2D2D2D)),
            ),
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              "Select a List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: _userLists.map((list) {
                  return ListTile(
                    title: Text(
                      list["title"]!,
                      style: const TextStyle(color: Color(0xFF2D2D2D)),
                    ),
                    subtitle: Text(
                      list["description"]!,
                      style: const TextStyle(color: Color(0xFF5E5E5E)),
                    ),
                    trailing: const Icon(Icons.add, color: Color(0xFF4A4A4A)),
                    onTap: () {
                      Navigator.pop(context);
                      _mostrarPopupConfirmacao(list["title"]!);
                    },
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xFF4A4A4A)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ----------------------- Popup de Confirmação -----------------------
  void _mostrarPopupConfirmacao(String listName) {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFFF5F5F5),
            ),
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              "Added!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            content: Text(
              "The movie has been added to '$listName'.",
              style: const TextStyle(color: Color(0xFF5E5E5E)),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A4A4A),
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  // ----------------------- Interface Principal -----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(title: Text(widget.title), backgroundColor: const Color(0xFFE0E0E0)),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Fundo com gradiente
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
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

            // Conteúdo principal
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
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[700],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        "⭐ 89%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
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

                      // Botões de ação
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () =>
                                  debugPrint("clicou no coração ❤️"),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF4A4A4A),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(Icons.favorite_border,
                                  color: Color(0xFF4A4A4A)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _mostrarPopupListas,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF4A4A4A),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(Icons.bookmark_border,
                                  color: Color(0xFF4A4A4A)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Informações do filme
                      const Row(
                        children: [
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
                        children: const [
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
