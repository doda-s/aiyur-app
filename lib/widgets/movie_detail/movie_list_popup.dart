import 'package:aiyurapp/models/movie_detail.dart';
import 'package:flutter/material.dart';

class MovieListPopup {
  static void showListSelection({
    required BuildContext context,
    required List<MovieList> lists,
    required Function(MovieList) onSelected,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select a List"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: lists.map((list) {
            return ListTile(
              title: Text(list.title),
              subtitle: Text(list.description),
              trailing: const Icon(Icons.add),
              onTap: () {
                Navigator.pop(context);
                onSelected(list);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  static void showConfirm(BuildContext context, String listName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Added!"),
        content: Text("The movie has been added to '$listName'."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
