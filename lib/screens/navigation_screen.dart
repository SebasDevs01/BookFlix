import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'library/library_screen.dart';
import 'home/home_screen.dart';
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
  bool _showFloatingOptions = false;

  final List<Widget> _screens = [
    const LibraryScreen(),
    const HomeScreen(),
    const FavoritesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
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
        ),
        // Overlay que cubre TODA la pantalla cuando se muestran los botones flotantes
        if (_showFloatingOptions)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showFloatingOptions = false;
                });
              },
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
          ),
        // BOTONES FLOTANTES POR ENCIMA DEL OVERLAY
        if (_showFloatingOptions) ...[
          // Botón para Libros (mejor separación y alineación)
          Positioned(
            bottom: 155, // Más separado del botón principal
            right: 16, // Centrado perfecto
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    _handleOptionTap('books');
                  },
                  child: const Icon(Icons.book, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
          // Botón para Películas (mejor separación y alineación)
          Positioned(
            bottom: 230, // Más separado del botón de libros
            right: 16, // Centrado perfecto
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    _handleOptionTap('movies');
                  },
                  child: const Icon(Icons.movie, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ],
        // Botón principal en posición fija (SUBIDO PARA NO TAPAR FAVORITOS)
        Positioned(
          bottom: 80, // Subido de 16 a 80 para estar arriba del menú
          right: 16, // Centrado perfecto
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _showFloatingOptions
                  ? Colors.grey[600]
                  : theme.primaryColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: _toggleFloatingOptions,
                child: Icon(
                  _showFloatingOptions ? Icons.close : Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
