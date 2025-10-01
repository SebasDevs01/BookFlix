import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/app_provider.dart';
import 'utils/theme.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/new_genre_selection_screen.dart';
import 'screens/navigation_screen.dart';
import 'screens/search/book_search_screen.dart';
import 'screens/search/movie_search_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "demo-api-key",
        authDomain: "bookflix-demo.firebaseapp.com",
        projectId: "bookflix-demo",
        storageBucket: "bookflix-demo.appspot.com",
        messagingSenderId: "123456789",
        appId: "1:123456789:web:demo",
      ),
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  runApp(const BookFlixApp());
}

class BookFlixApp extends StatelessWidget {
  const BookFlixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider()..init(),
      child: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'BookFlix',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
            builder: (context, child) {
              // Asegurar que la app esté optimizada para móvil
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(
                    MediaQuery.of(
                      context,
                    ).textScaler.scale(1.0).clamp(0.8, 1.2),
                  ),
                ),
                child: child!,
              );
            },
            routes: {
              '/login': (context) => const LoginScreen(),
              '/genre-selection': (context) => const GenreSelectionScreen(),
              '/navigation': (context) => const NavigationScreen(),
              '/book-search': (context) => const BookSearchScreen(),
              '/movie-search': (context) => const MovieSearchScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}
