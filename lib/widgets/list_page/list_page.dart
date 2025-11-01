import 'package:flutter/material.dart';

class MyListsPage extends StatelessWidget {
  const MyListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exampleLists = [
      {"title": "asdasdasd", "description": "asdasd", "movies": 0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Lists"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão "Create New List"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  print("Create new list tapped");
                },
                icon: const Icon(Icons.add),
                label: const Text("Create New List"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
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
                  children: exampleLists.map((list) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          list["title"].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${list["description"]}\n${list["movies"]} movies",
                          style: const TextStyle(height: 1.4),
                        ),
                        isThreeLine: true,
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          print(context);
                          Navigator.pushNamed(
                            context,
                            '/ListsDetailPage',
                          );
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
