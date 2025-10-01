import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../screens/search/book_search_screen.dart';
import '../screens/search/movie_search_screen.dart';

class FloatingMenu extends StatefulWidget {
  const FloatingMenu({super.key});

  @override
  State<FloatingMenu> createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _rotationController;
  late Animation<double> _animation;
  late Animation<double> _rotationAnimation;

  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _rotationAnimation =
        Tween<double>(
          begin: 0.0,
          end: 0.75, // 3/4 de vuelta (270 grados)
        ).animate(
          CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });

    if (_isMenuOpen) {
      _animationController.forward();
      _rotationController.forward();
    } else {
      _animationController.reverse();
      _rotationController.reverse();
    }
  }

  void _closeMenu() {
    if (_isMenuOpen) {
      setState(() {
        _isMenuOpen = false;
      });
      _animationController.reverse();
      _rotationController.reverse();
    }
  }

  void _onMenuItemTap(String action) {
    _closeMenu();

    // Pequeña demora para permitir que la animación termine
    Future.delayed(const Duration(milliseconds: 200), () {
      switch (action) {
        case 'book':
          _navigateToBookSearch();
          break;
        case 'movie':
          _navigateToMovieSearch();
          break;
        case 'camera':
          _showCameraOptions();
          break;
        case 'scan':
          _showScanOptions();
          break;
      }
    });
  }

  void _navigateToBookSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookSearchScreen()),
    );
  }

  void _navigateToMovieSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MovieSearchScreen()),
    );
  }

  void _showCameraOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Opciones de Cámara',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Tomar foto de portada'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidad de cámara próximamente'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Seleccionar de galería'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidad de galería próximamente'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showScanOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Escanear Código',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Escanear código de barras'),
              subtitle: const Text('Para libros y películas'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Escáner de códigos próximamente'),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Escanear código QR'),
              subtitle: const Text('Para enlaces y contenido'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Escáner QR próximamente')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color color,
    required String tooltip,
    required double angle,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Reducir radio para pantallas móviles
        final mediaQuery = MediaQuery.of(context);
        final isSmallScreen = mediaQuery.size.width < 400;
        final double radius = (isSmallScreen ? 50.0 : 70.0) * _animation.value;
        final double x = radius * math.cos(angle);
        final double y = radius * math.sin(angle);

        return Transform.translate(
          offset: Offset(x, y),
          child: Transform.scale(
            scale: _animation.value,
            child: Opacity(
              opacity: _animation.value,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 25),
                  child: Container(
                    width: isSmallScreen ? 40 : 50, // Tamaño dinámico
                    height: isSmallScreen ? 40 : 50, // Tamaño dinámico
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: isSmallScreen ? 6 : 8,
                          offset: Offset(0, isSmallScreen ? 2 : 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: isSmallScreen ? 20 : 24, // Tamaño dinámico
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _isMenuOpen ? _closeMenu : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fondo semitransparente cuando el menú está abierto
          if (_isMenuOpen)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: 200 * _animation.value,
                  height: 200 * _animation.value,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(
                      alpha: 0.1 * _animation.value,
                    ),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),

          // Elementos del menú
          _buildMenuItem(
            icon: Icons.book_rounded,
            color: theme.colorScheme.primary,
            tooltip: 'Buscar Libros',
            angle: -math.pi / 2, // Arriba
            onTap: () => _onMenuItemTap('book'),
          ),

          _buildMenuItem(
            icon: Icons.movie_rounded,
            color: theme.colorScheme.secondary,
            tooltip: 'Buscar Películas',
            angle: -math.pi / 4, // Arriba derecha
            onTap: () => _onMenuItemTap('movie'),
          ),

          _buildMenuItem(
            icon: Icons.camera_alt_rounded,
            color: Colors.green,
            tooltip: 'Cámara',
            angle: -3 * math.pi / 4, // Arriba izquierda
            onTap: () => _onMenuItemTap('camera'),
          ),

          _buildMenuItem(
            icon: Icons.qr_code_scanner_rounded,
            color: const Color(0xFF3B82F6),
            tooltip: 'Escanear',
            angle: 0, // Derecha
            onTap: () => _onMenuItemTap('scan'),
          ),

          // Botón principal
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              final isSmallScreen = mediaQuery.size.width < 400;

              return Transform.rotate(
                angle: _rotationAnimation.value * 2.0 * math.pi,
                child: SizedBox(
                  width: isSmallScreen ? 48 : 56, // Tamaño dinámico
                  height: isSmallScreen ? 48 : 56, // Tamaño dinámico
                  child: FloatingActionButton(
                    onPressed: _toggleMenu,
                    backgroundColor: _isMenuOpen
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    elevation: isSmallScreen ? 6 : 8,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        _isMenuOpen ? Icons.close : Icons.add,
                        key: ValueKey(_isMenuOpen),
                        color: Colors.white,
                        size: isSmallScreen ? 24 : 28, // Tamaño dinámico
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
