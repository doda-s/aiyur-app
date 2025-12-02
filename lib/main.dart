import 'package:aiyurapp/controllers/authentication_controller.dart';
import 'package:aiyurapp/controllers/movie_controller.dart';
import 'package:aiyurapp/services/cache.dart';
import 'package:aiyurapp/services/movie_service.dart';
import 'package:aiyurapp/services/tmdb_service.dart';
import 'package:aiyurapp/widgets/auth/login_page.dart';
import 'package:aiyurapp/widgets/auth/register_page.dart';
import 'package:aiyurapp/widgets/movie_detail/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:aiyurapp/widgets/page_content/page_content.dart';
import 'package:aiyurapp/widgets/list_page/list_detail_page.dart';
import 'package:aiyurapp/modules/firebase_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final tmdb = TmdbService();
final movieService = MovieService();
final cacheService = CacheService();
final movieController = MovieController();
final authController = AuthenticationController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();

  await dotenv.load(fileName: ".env");

  await tmdb.initialize(
    apiKey: dotenv.get("TMDB_API_KEY"),
    readAccessToken: dotenv.get("TMDB_READ_ACESS_TOKEN"),
    enableLogs: true, // logs opcionais
  );

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
          final args = settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
            builder: (context) => MovieDetailPage(movieId: args["movieId"]),
          );
        }
        return null;
      },
    );
  }
}
