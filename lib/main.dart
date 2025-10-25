import 'package:aiyurapp/widgets/category_selector.dart';
import 'package:aiyurapp/widgets/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(child: Scaffold(body: PageContent())),
    ),
  );
}

class ClickableText extends StatefulWidget {
  const ClickableText({super.key});

  @override
  State<StatefulWidget> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  bool _clicked = false;

  void _toggleText() {
    setState(() {
      _clicked = !_clicked; // alterna o valor
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _toggleText,
      child: Text(
        _clicked ? 'Você clicou!' : 'Clique em mim!',
        style: const TextStyle(fontSize: 18, color: Colors.pink),
      ),
    );
  }
}

class TopAppBar extends StatelessWidget {
  const TopAppBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Column(
        children: [
          // Profile and AppIcon
          Row(
            children: [
              const IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Navigation menu',
                onPressed: null, // null disables the button
              ),
              // Expanded expands its child
              // to fill the available space.
              Expanded(child: title),
              const IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search',
                onPressed: null,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SearchBarWidget(),
          const CategorySelector(),
        ],
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TopAppBar(
            title: Text(
              "teste",
              style:
                  Theme.of(context) //
                      .primaryTextTheme
                      .titleLarge,
            ),
          ),
          Center(child: ClickableText()),
        ],
      ),
    );
  }
}
