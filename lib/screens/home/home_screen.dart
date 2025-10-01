import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../data/hardcoded_data.dart';
import '../../models/simple_book_model.dart';
import '../../models/simple_movie_model.dart';
import '../../models/simple_series_model.dart';
import '../details/book_detail_screen.dart';
import '../details/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isLargeScreen = screenWidth >= 800;

          return Column(
            children: [
              // Header unificado como biblioteca
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isLargeScreen ? 40 : 20,
                  vertical: isLargeScreen ? 30 : 20,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getGreeting(),
                            style: TextStyle(
                              fontSize: isLargeScreen ? 16 : 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          Text(
                            appProvider.currentUser?.displayName ?? 'Usuario',
                            style: TextStyle(
                              fontSize: isLargeScreen ? 28 : 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(
                                context,
                              ).textTheme.headlineMedium?.color,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              appProvider.isDarkMode
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                              size: isLargeScreen ? 28 : 24,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              appProvider.toggleDarkMode();
                            },
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: Container(
                              width: isLargeScreen ? 45 : 40,
                              height: isLargeScreen ? 45 : 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF3B82F6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Contenido con scroll
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 20,
                    vertical: isLargeScreen ? 30 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progreso de lectura
                      _buildProgressSection(appProvider, isLargeScreen),
                      const SizedBox(height: 32),

                      // Continuar leyendo
                      _buildContinueReadingSection(appProvider, isLargeScreen),
                      const SizedBox(height: 32),

                      // Recomendaciones
                      _buildRecommendationsSection(isLargeScreen),
                      const SizedBox(height: 32),

                      // Nuevos lanzamientos
                      _buildNewReleasesSection(isLargeScreen),
                      const SizedBox(height: 32),

                      // Tendencias
                      _buildTrendingSection(isLargeScreen),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressSection(AppProvider provider, bool isLargeScreen) {
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 24 : 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tu progreso hoy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildProgressCard(
                  'Libros leídos',
                  '3',
                  Icons.book_outlined,
                  isLargeScreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProgressCard(
                  'Películas vistas',
                  '1',
                  Icons.movie_outlined,
                  isLargeScreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProgressCard(
                  'Series vistas',
                  '2',
                  Icons.tv_outlined,
                  isLargeScreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
    String title,
    String count,
    IconData icon,
    bool isLargeScreen,
  ) {
    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: isLargeScreen ? 28 : 24),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              color: Colors.white,
              fontSize: isLargeScreen ? 24 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isLargeScreen ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueReadingSection(
    AppProvider provider,
    bool isLargeScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continúa donde lo dejaste',
          style: TextStyle(
            fontSize: isLargeScreen ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineMedium?.color,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: isLargeScreen ? 280 : 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final book = HardcodedData.books[index];
              return Container(
                width: isLargeScreen ? 160 : 140,
                margin: const EdgeInsets.only(right: 16),
                child: _buildContentCard(
                  book.title,
                  book.author,
                  book.imageUrl,
                  isLargeScreen,
                  onTap: () => _navigateToBookDetail(book),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection(bool isLargeScreen) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        // Obtener recomendaciones basadas en géneros seleccionados
        final recommendedBooks = provider
            .getRecommendationsByGenre<SimpleBookModel>(
              HardcodedData.books,
              (book) => book.genre,
              limit: 5,
            );
        final recommendedMovies = provider
            .getRecommendationsByGenre<SimpleMovieModel>(
              HardcodedData.movies,
              (movie) => movie.genre,
              limit: 5,
            );
        final recommendedSeries = provider
            .getRecommendationsByGenre<SimpleSeriesModel>(
              HardcodedData.series,
              (series) => series.genre,
              limit: 5,
            );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              provider.selectedGenres.isNotEmpty
                  ? 'Recomendaciones basadas en tus gustos'
                  : 'Recomendaciones para ti',
              style: TextStyle(
                fontSize: isLargeScreen ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.headlineMedium?.color,
              ),
            ),
            if (provider.selectedGenres.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: provider.selectedGenres
                    .map(
                      (genre) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          genre,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF3B82F6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 16),

            // Libros recomendados
            if (recommendedBooks.isNotEmpty) ...[
              Text(
                'Libros recomendados',
                style: TextStyle(
                  fontSize: isLargeScreen ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: isLargeScreen ? 280 : 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedBooks.length,
                  itemBuilder: (context, index) {
                    final book = recommendedBooks[index];
                    return Container(
                      width: isLargeScreen ? 160 : 140,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildContentCard(
                        book.title,
                        book.author,
                        book.imageUrl,
                        isLargeScreen,
                        onTap: () => _navigateToBookDetail(book),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Películas recomendadas
            if (recommendedMovies.isNotEmpty) ...[
              Text(
                'Películas recomendadas',
                style: TextStyle(
                  fontSize: isLargeScreen ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: isLargeScreen ? 280 : 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = recommendedMovies[index];
                    return Container(
                      width: isLargeScreen ? 160 : 140,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildContentCard(
                        movie.title,
                        movie.director,
                        movie.imageUrl,
                        isLargeScreen,
                        onTap: () => _navigateToMovieDetail(movie),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Series recomendadas
            if (recommendedSeries.isNotEmpty) ...[
              Text(
                'Series recomendadas',
                style: TextStyle(
                  fontSize: isLargeScreen ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: isLargeScreen ? 280 : 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedSeries.length,
                  itemBuilder: (context, index) {
                    final series = recommendedSeries[index];
                    return Container(
                      width: isLargeScreen ? 160 : 140,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildSeriesCard(series, isLargeScreen),
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildNewReleasesSection(bool isLargeScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nuevos lanzamientos',
          style: TextStyle(
            fontSize: isLargeScreen ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineMedium?.color,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: isLargeScreen ? 280 : 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: HardcodedData.movies.length,
            itemBuilder: (context, index) {
              final movie = HardcodedData.movies[index];
              return Container(
                width: isLargeScreen ? 160 : 140,
                margin: const EdgeInsets.only(right: 16),
                child: _buildContentCard(
                  movie.title,
                  movie.director,
                  movie.imageUrl,
                  isLargeScreen,
                  onTap: () => _navigateToMovieDetail(movie),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection(bool isLargeScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tendencias',
          style: TextStyle(
            fontSize: isLargeScreen ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineMedium?.color,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: isLargeScreen ? 280 : 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: HardcodedData.books.length,
            itemBuilder: (context, index) {
              final book = HardcodedData.books[index];
              return Container(
                width: isLargeScreen ? 160 : 140,
                margin: const EdgeInsets.only(right: 16),
                child: _buildContentCard(
                  book.title,
                  book.author,
                  book.imageUrl,
                  isLargeScreen,
                  onTap: () => _navigateToBookDetail(book),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContentCard(
    String title,
    String subtitle,
    String imageUrl,
    bool isLargeScreen, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen con mejor aspect ratio
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageUrl.isNotEmpty
                    ? Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultCover();
                        },
                      )
                    : _buildDefaultCover(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Información
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 14 : 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: isLargeScreen ? 12 : 10,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCover() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF48c6ef), Color(0xFF6f86d6)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.image_outlined, color: Colors.white, size: 40),
      ),
    );
  }

  void _navigateToBookDetail(SimpleBookModel book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
    );
  }

  void _navigateToMovieDetail(SimpleMovieModel movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  Widget _buildSeriesCard(SimpleSeriesModel series, bool isLargeScreen) {
    return GestureDetector(
      onTap: () {
        // TODO: Navegar a pantalla de detalles de series cuando se implemente
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Detalles de series próximamente'),
            backgroundColor: Color(0xFF3B82F6),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: series.imageUrl.isNotEmpty
                    ? Image.network(
                        series.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultSeriesCover(series.title);
                        },
                      )
                    : _buildDefaultSeriesCover(series.title),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        series.title,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        series.genre,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultSeriesCover(String title) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF48c6ef), Color(0xFF6f86d6)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.tv, size: 48, color: Colors.white),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
