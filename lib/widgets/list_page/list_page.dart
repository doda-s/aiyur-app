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

  void _registerListPopUp() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFE8E8E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Create New List",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  cursorColor: const Color(0xFF4A4A4A),
                  decoration: const InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(color: Color(0xFF5E5E5E)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4A4A4A)),
                    ),
                  ),
                  style: const TextStyle(color: Color(0xFF2D2D2D)),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descController,
                  cursorColor: const Color(0xFF4A4A4A),
                  decoration: const InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: Color(0xFF5E5E5E)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4A4A4A)),
                    ),
                  ),
                  style: const TextStyle(color: Color(0xFF2D2D2D)),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _titleController.clear();
                        _descController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Color(0xFF5E5E5E)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A4A4A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmRemove(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFE8E8E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Remove List",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Are you sure you want to remove '${_lists[index]["title"]}'?",
                  style: const TextStyle(
                    color: Color(0xFF5E5E5E),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Color(0xFF5E5E5E)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A4A4A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildTopBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFE0E0E0),
      elevation: 0,
      toolbarHeight: 55,
      titleSpacing: 0,
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: _buildTopBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _registerListPopUp,
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
              child: ListView.builder(
                itemCount: _lists.length,
                itemBuilder: (context, index) {
                  final list = _lists[index];
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
                            icon: const Icon(
                              Icons.delete,
                              color: Color(0xFF4A4A4A),
                            ),
                            onPressed: () => _confirmRemove(index),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Color(0xFF5E5E5E),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/ListsDetailPage');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
