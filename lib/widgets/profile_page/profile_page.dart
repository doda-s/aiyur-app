import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Pedro noobola user";
  String _username = "user_name";
  String _description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
      "Proin vitae libero justo. Phasellus at orci velit. In hac duis.";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _mostrarPopupEdicao() {
    _nameController.text = _name;
    _usernameController.text = _username;
    _descriptionController.text = _description;

    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Color(0xFF2D2D2D)),
              labelLarge: TextStyle(color: Color(0xFF2D2D2D)),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Color(0xFF5E5E5E)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF4A4A4A)),
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(0xFFF5F5F5),
            ),
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              "Edit User Settings",
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
                    controller: _nameController,
                    cursorColor: const Color(0xFF4A4A4A),
                    style: const TextStyle(
                      color: Color(0xFF2D2D2D),
                    ),
                    decoration: const InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        color: Color(0xFF5E5E5E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _usernameController,
                    cursorColor: const Color(0xFF4A4A4A),
                    style: const TextStyle(
                      color: Color(0xFF2D2D2D),
                    ),
                    decoration: const InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Color(0xFF5E5E5E)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descriptionController,
                    cursorColor: const Color(0xFF4A4A4A),
                    style: const TextStyle(
                      color: Color(0xFF2D2D2D),
                    ),
                    decoration: const InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(color: Color(0xFF5E5E5E)),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
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
                    _name = _nameController.text.trim();
                    _username = _usernameController.text.trim();
                    _description = _descriptionController.text.trim();
                  });
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

  void _logout() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Color(0xFF2D2D2D)),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(0xFFF5F5F5),
            ),
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                color: Color(0xFF2D2D2D),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "Do you really want to log out?",
              style: TextStyle(color: Color(0xFF5E5E5E)),
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
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
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0E0E0),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Icon(Icons.movie, color: Color(0xFF4A4A4A)),
            const SizedBox(width: 8),
            const Text(
              "Profile",
              style: TextStyle(
                color: Color(0xFF2D2D2D),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: _mostrarPopupEdicao,
              icon: const Icon(Icons.edit, color: Color(0xFF4A4A4A)),
              tooltip: "Edit profile",
            ),
            IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Color(0xFF4A4A4A)),
              tooltip: "Logout",
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Image.network(
                  'https://picsum.photos/200/301',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -60,
                left: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[300],
                    child: Image.network(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: const TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _username,
                  style: const TextStyle(color: Color(0xFF5E5E5E)),
                ),
                const SizedBox(height: 8),
                Text(
                  _description,
                  style: const TextStyle(color: Color(0xFF5E5E5E)),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
