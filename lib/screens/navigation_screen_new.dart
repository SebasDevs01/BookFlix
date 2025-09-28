import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'library/library_screen.dart';
import 'home/new_home_screen.dart' as new_home;
import 'favorites/favorites_screen.dart';
import 'search/book_search_screen.dart';
import 'search/movie_search_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;
  bool _showFloatingOptions = false;

  final List<Widget> _screens = [
    const LibraryScreen(),
    const new_home.HomeScreen(),
    const FavoritesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1); // Comienza en Home

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    );

    // Iniciar animación del FAB
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _fabAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    final appProvider = context.read<AppProvider>();
    appProvider.setCurrentIndex(index);
  }

  void _onNavTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _toggleFloatingOptions() {
    setState(() {
      _showFloatingOptions = !_showFloatingOptions;
    });
  }

  void _handleOptionTap(String option) {
    setState(() {
      _showFloatingOptions = false;
    });

    switch (option) {
      case 'books':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookSearchScreen()),
        );
        break;
      case 'movies':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MovieSearchScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Scaffold principal
        Scaffold(
          body: Consumer<AppProvider>(
            builder: (context, appProvider, child) {
              return PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: _screens,
              );
            },
          ),
          bottomNavigationBar: Consumer<AppProvider>(
            builder: (context, appProvider, child) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: NavigationBar(
                    selectedIndex: appProvider.currentIndex,
                    onDestinationSelected: _onNavTap,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    indicatorColor: theme.colorScheme.primaryContainer,
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.library_books_outlined),
                        selectedIcon: Icon(Icons.library_books_rounded),
                        label: 'Biblioteca',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home_rounded),
                        label: 'Inicio',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.favorite_outline),
                        selectedIcon: Icon(Icons.favorite_rounded),
                        label: 'Favoritos',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: Stack(
            alignment: Alignment.bottomRight,
            children: [
              // Botones de opciones flotantes (más grandes y más cerca)
              if (_showFloatingOptions) ...[
                // Botón para Libros
                Positioned(
                  bottom: 75,
                  right: 8,
                  child: ScaleTransition(
                    scale: _fabAnimation,
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: FloatingActionButton(
                        heroTag: "books",
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        onPressed: () => _handleOptionTap('books'),
                        child: const Icon(Icons.book, size: 30),
                      ),
                    ),
                  ),
                ),
                // Botón para Películas
                Positioned(
                  bottom: 145,
                  right: 8,
                  child: ScaleTransition(
                    scale: _fabAnimation,
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: FloatingActionButton(
                        heroTag: "movies",
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        onPressed: () => _handleOptionTap('movies'),
                        child: const Icon(Icons.movie, size: 30),
                      ),
                    ),
                  ),
                ),
              ],
              // Botón principal (más grande)
              ScaleTransition(
                scale: _fabAnimation,
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: FloatingActionButton(
                    heroTag: "main",
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    onPressed: _toggleFloatingOptions,
                    child: Icon(
                      _showFloatingOptions ? Icons.close : Icons.add,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Overlay que cubre TODA la pantalla incluyendo el menú inferior
        if (_showFloatingOptions)
          Positioned.fill(
            child: IgnorePointer(
              ignoring: false,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showFloatingOptions = false;
                  });
                },
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
