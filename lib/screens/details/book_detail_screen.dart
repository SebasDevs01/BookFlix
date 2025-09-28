import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/simple_book_model.dart';

class BookDetailScreen extends StatefulWidget {
  final SimpleBookModel book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen>
    with TickerProviderStateMixin {
  bool _isFavorite = false;
  bool _isInLibrary = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Añadido a favoritos' : 'Removido de favoritos',
        ),
        backgroundColor: _isFavorite ? Colors.green : Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleLibrary() {
    setState(() {
      _isInLibrary = !_isInLibrary;
    });
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isInLibrary
              ? 'Añadido a la biblioteca'
              : 'Removido de la biblioteca',
        ),
        backgroundColor: _isInLibrary ? Colors.blue : Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _startReading() {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comenzar a leer'),
        content: Text('¿Deseas comenzar a leer "${widget.book.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Función de lectura próximamente'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: const Text('Comenzar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar con la imagen del libro
          SliverAppBar(
            expandedHeight: isTablet ? 400 : 300,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: isTablet ? 200 : 150,
                      height: isTablet ? 280 : 210,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: isTablet ? 80 : 60,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              widget.book.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: _toggleFavorite,
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),

          // Contenido del libro
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y autor
                  _buildTitleSection(theme, isTablet),
                  const SizedBox(height: 24),

                  // Información del libro
                  _buildBookInfo(theme, isTablet),
                  const SizedBox(height: 24),

                  // Sinopsis
                  _buildSynopsis(theme, isTablet),
                  const SizedBox(height: 24),

                  // Reseñas
                  _buildReviews(theme, isTablet),
                  const SizedBox(height: 32),

                  // Botones de acción
                  _buildActionButtons(theme, isTablet),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(ThemeData theme, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.book.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'por ${widget.book.author}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.book.genre,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookInfo(ThemeData theme, bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: isTablet ? 24 : 20),
              const SizedBox(width: 8),
              Text(
                '4.5',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(2,847 reseñas)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                theme,
                Icons.auto_stories,
                '342',
                'Páginas',
                isTablet,
              ),
              _buildInfoItem(
                theme,
                Icons.schedule,
                '5h 23m',
                'Lectura',
                isTablet,
              ),
              _buildInfoItem(
                theme,
                Icons.calendar_today,
                '2023',
                'Año',
                isTablet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    ThemeData theme,
    IconData icon,
    String value,
    String label,
    bool isTablet,
  ) {
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: isTablet ? 28 : 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildSynopsis(ThemeData theme, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sinopsis',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            'Una fascinante historia que combina elementos de ${widget.book.genre.toLowerCase()} con una narrativa envolvente. Este libro te llevará a través de un viaje extraordinario lleno de personajes memorables y situaciones que te mantendrán enganchado desde la primera página.\n\nCon un estilo único, ${widget.book.author} nos presenta una obra maestra que ha cautivado a lectores de todo el mundo. Una lectura obligatoria para cualquier amante de este género.',
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviews(ThemeData theme, bool isTablet) {
    final reviews = [
      {
        'name': 'Ana Martínez',
        'rating': 5,
        'comment': '¡Increíble libro! No pude dejarlo hasta terminarlo.',
      },
      {
        'name': 'Carlos López',
        'rating': 4,
        'comment': 'Muy buena historia, aunque el final me dejó queriendo más.',
      },
      {
        'name': 'María González',
        'rating': 5,
        'comment': 'Excelente narrativa y personajes muy bien desarrollados.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reseñas',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ver todas las reseñas próximamente'),
                  ),
                );
              },
              child: const Text('Ver todas'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...reviews.map((review) => _buildReviewItem(theme, review, isTablet)),
      ],
    );
  }

  Widget _buildReviewItem(
    ThemeData theme,
    Map<String, dynamic> review,
    bool isTablet,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  review['name'][0],
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review['rating']
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review['comment'],
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme, bool isTablet) {
    return Column(
      children: [
        // Botón principal - Leer ahora
        SizedBox(
          width: double.infinity,
          height: isTablet ? 56 : 48,
          child: ElevatedButton.icon(
            onPressed: _startReading,
            icon: const Icon(Icons.play_arrow),
            label: const Text(
              'Leer Ahora',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Botones secundarios
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _toggleLibrary,
                icon: Icon(_isInLibrary ? Icons.check : Icons.add),
                label: Text(_isInLibrary ? 'En Biblioteca' : 'Añadir'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  side: BorderSide(color: theme.colorScheme.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Función de compartir próximamente'),
                  ),
                );
              },
              icon: const Icon(Icons.share),
              label: const Text('Compartir'),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(color: theme.colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
