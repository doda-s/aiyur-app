import 'package:aiyurapp/widgets/auth/login_page/login_page.dart';
import 'package:aiyurapp/widgets/auth/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/home_page/home_page.dart';
import 'package:aiyurapp/widgets/list_page/list_detail_page.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,

      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const SafeArea(child: PageContent()),
        '/ListsDetailPage': (context) => const ListsDetailPage(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/movieDetail') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              title: args['title']!,
              imageUrl: args['imageUrl']!,
            ),
          );
        }
        return null;
      },
    );
  }
}
