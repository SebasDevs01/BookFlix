import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/simple_movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final SimpleMovieModel movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
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

  void _playMovie() {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reproducir película'),
        content: Text('¿Deseas reproducir "${widget.movie.title}"?'),
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
                  content: Text('Función de reproducción próximamente'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Reproducir'),
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
          // App Bar con el poster de la película
          SliverAppBar(
            expandedHeight: isTablet ? 400 : 300,
            pinned: true,
            backgroundColor: Colors.red.shade700,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade700, Colors.purple.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: isTablet ? 200 : 150,
                      height: isTablet ? 300 : 225,
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
                            Icons.movie_creation,
                            size: isTablet ? 80 : 60,
                            color: Colors.red.shade700,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              widget.movie.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.movie.year.toString(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                              fontWeight: FontWeight.w500,
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

          // Contenido de la película
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y director
                  _buildTitleSection(theme, isTablet),
                  const SizedBox(height: 24),

                  // Información de la película
                  _buildMovieInfo(theme, isTablet),
                  const SizedBox(height: 24),

                  // Sinopsis
                  _buildSynopsis(theme, isTablet),
                  const SizedBox(height: 24),

                  // Cast (elenco)
                  _buildCast(theme, isTablet),
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
          widget.movie.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Dirigido por ${widget.movie.director}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.movie.genre,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.movie.year.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMovieInfo(ThemeData theme, bool isTablet) {
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
                '4.7',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(1,423 reseñas)',
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
                Icons.access_time,
                '2h 15m',
                'Duración',
                isTablet,
              ),
              _buildInfoItem(
                theme,
                Icons.language,
                'ES/EN',
                'Idiomas',
                isTablet,
              ),
              _buildInfoItem(theme, Icons.hd, '4K', 'Calidad', isTablet),
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
        Icon(icon, color: Colors.red, size: isTablet ? 28 : 24),
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
            'Una emocionante película de ${widget.movie.genre.toLowerCase()} que te mantendrá al borde de tu asiento. Con una trama cautivadora y efectos visuales espectaculares, esta producción dirigida por ${widget.movie.director} promete ser una experiencia cinematográfica inolvidable.\n\nCombinando elementos clásicos del género con innovadoras técnicas narrativas, esta película ha recibido elogios de la crítica y se ha convertido en un éxito de taquilla. Una obra maestra del cine contemporáneo que no te puedes perder.',
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCast(ThemeData theme, bool isTablet) {
    final cast = [
      {'name': 'Emma Stone', 'role': 'Protagonista'},
      {'name': 'Ryan Gosling', 'role': 'Coprotagonista'},
      {'name': 'John Malkovich', 'role': 'Antagonista'},
      {'name': 'Scarlett Johansson', 'role': 'Secundario'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reparto',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (context, index) {
              final actor = cast[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red.withValues(alpha: 0.1),
                      child: Icon(Icons.person, color: Colors.red, size: 30),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      actor['name']!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      actor['role']!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviews(ThemeData theme, bool isTablet) {
    final reviews = [
      {
        'name': 'Pedro Jiménez',
        'rating': 5,
        'comment': 'Una obra maestra del cine. Efectos visuales increíbles.',
      },
      {
        'name': 'Laura Rodríguez',
        'rating': 4,
        'comment': 'Excelente película, aunque algo larga para mi gusto.',
      },
      {
        'name': 'Diego Morales',
        'rating': 5,
        'comment': 'Actuaciones sobresalientes y una historia fascinante.',
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
                backgroundColor: Colors.red.withValues(alpha: 0.1),
                child: Text(
                  review['name'][0],
                  style: TextStyle(
                    color: Colors.red,
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
        // Botón principal - Reproducir ahora
        SizedBox(
          width: double.infinity,
          height: isTablet ? 56 : 48,
          child: ElevatedButton.icon(
            onPressed: _playMovie,
            icon: const Icon(Icons.play_arrow),
            label: const Text(
              'Reproducir Ahora',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: Colors.red.withValues(alpha: 0.3),
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
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
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
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
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
