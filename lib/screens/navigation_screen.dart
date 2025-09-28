import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'library/library_screen.dart';
import 'home/new_home_screen.dart' as new_home;
import 'favorites/favorites_screen.dart';

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

  Widget _buildFloatingOption(String text, IconData icon, VoidCallback onTap) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
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

    // Aquí puedes navegar a las diferentes pantallas
    switch (option) {
      case 'books':
        // Navegar a búsqueda de libros
        Navigator.pushNamed(context, '/book-search');
        break;
      case 'movies':
        // Navegar a búsqueda de películas
        Navigator.pushNamed(context, '/movie-search');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Consumer<AppProvider>(
            builder: (context, appProvider, child) {
              return PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: _screens,
              );
            },
          ),
          // Fondo borroso cuando se muestran las opciones flotantes
          if (_showFloatingOptions)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showFloatingOptions = false;
                  });
                },
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          // Opciones flotantes
          if (_showFloatingOptions)
            Positioned(
              bottom: 150,
              right: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildFloatingOption(
                    'Buscar Libros',
                    Icons.book_rounded,
                    () => _handleOptionTap('books'),
                  ),
                  const SizedBox(height: 12),
                  _buildFloatingOption(
                    'Buscar Películas',
                    Icons.movie_rounded,
                    () => _handleOptionTap('movies'),
                  ),
                ],
              ),
            ),
        ],
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
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 80,
                child: BottomNavigationBar(
                  currentIndex: appProvider.currentIndex,
                  onTap: _onNavTap,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: theme.colorScheme.primary,
                  unselectedItemColor: theme.colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
                  selectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  unselectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                  ),
                  selectedIconTheme: const IconThemeData(size: 26),
                  unselectedIconTheme: const IconThemeData(size: 24),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.library_books_outlined),
                      activeIcon: Icon(Icons.library_books),
                      label: 'Biblioteca',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: 'Inicio',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outline),
                      activeIcon: Icon(Icons.favorite),
                      label: 'Favoritos',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Botones de opciones flotantes
          if (_showFloatingOptions) ...[
            // Botón para Libros
            Positioned(
              bottom: 80,
              right: 8,
              child: ScaleTransition(
                scale: _fabAnimation,
                child: FloatingActionButton(
                  heroTag: "books",
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  onPressed: () => _handleOptionTap('books'),
                  child: const Icon(Icons.book),
                ),
              ),
            ),
            // Botón para Películas
            Positioned(
              bottom: 150,
              right: 8,
              child: ScaleTransition(
                scale: _fabAnimation,
                child: FloatingActionButton(
                  heroTag: "movies",
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  onPressed: () => _handleOptionTap('movies'),
                  child: const Icon(Icons.movie),
                ),
              ),
            ),
          ],
          // Botón principal
          ScaleTransition(
            scale: _fabAnimation,
            child: FloatingActionButton(
              heroTag: "main",
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              onPressed: _toggleFloatingOptions,
              child: Icon(
                _showFloatingOptions ? Icons.close : Icons.add,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
