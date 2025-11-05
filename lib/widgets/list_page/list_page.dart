import 'package:flutter/material.dart';

class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  State<MyListsPage> createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final List<Map<String, dynamic>> _lists = [
    {
      "title": "Action Movies",
      "description": "Explosive and thrilling films",
      "movies": 5,
    },
  ];

  void _mostrarPopupCadastro() {
  showDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: Theme.of(context).copyWith(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFF2D2D2D)),
            labelLarge: TextStyle(color: Color(0xFF2D2D2D)), // textos dos botões
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFF5E5E5E)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4A4A4A)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4A4A4A),
            ),
          ),
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Create New List",
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  cursorColor: const Color(0xFF4A4A4A),
                  style: const TextStyle(color: Color(0xFF2D2D2D)),
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descController,
                  cursorColor: const Color(0xFF4A4A4A),
                  style: const TextStyle(color: Color(0xFF2D2D2D)),
                  decoration: const InputDecoration(labelText: "Description"),
                ),
              ],
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          actions: [
            TextButton(
              onPressed: () {
                _titleController.clear();
                _descController.clear();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A4A4A),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_titleController.text.trim().isNotEmpty) {
                  setState(() {
                    _lists.add({
                      "title": _titleController.text.trim(),
                      "description": _descController.text.trim(),
                      "movies": 0,
                    });
                  });
                }
                _titleController.clear();
                _descController.clear();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      );
    },
  );
}




  // ----------------------- Confirmação de Remoção -----------------------
  void _confirmarRemocao(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Remove List",
            style: TextStyle(
              color: Color(0xFF2D2D2D),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to remove '${_lists[index]["title"]}'?",
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
                  _lists.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // ----------------------- Top Bar -----------------------
  PreferredSizeWidget _buildTopBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFE0E0E0),
      elevation: 0,
      toolbarHeight: 55,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 8, left: 4),
              child: Icon(Icons.movie, color: Color(0xFF4A4A4A)),
            ),
            Text(
              "My Lists",
              style: TextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------- Corpo -----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildTopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _mostrarPopupCadastro,
                icon: const Icon(Icons.add),
                label: const Text("Create New List"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A4A4A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _lists.asMap().entries.map((entry) {
                    final index = entry.key;
                    final list = entry.value;
                    return Card(
                      color: const Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          list["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        subtitle: Text(
                          "${list["description"]}\n${list["movies"]} movies",
                          style: const TextStyle(
                            height: 1.4,
                            color: Color(0xFF5E5E5E),
                          ),
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Color(0xFF4A4A4A)),
                              onPressed: () => _confirmarRemocao(index),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Color(0xFF5E5E5E)),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/ListsDetailPage');
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
