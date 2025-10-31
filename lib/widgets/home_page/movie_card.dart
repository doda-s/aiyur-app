import 'package:flutter/material.dart';
class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;
  final Color color;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.label,
    this.height = 10,
    this.borderRadius = 12,
    this.onTap,
    this.color = const Color.fromRGBO(245, 245, 245, 1),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        duration: Duration(microseconds: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(borderRadius),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              color: color,
              padding: const EdgeInsets.all(6),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Descrição curta asdasdasdasdasasd asd",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 29, 29, 29),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}