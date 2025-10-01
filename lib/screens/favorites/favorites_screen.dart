import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../data/hardcoded_data.dart';
import '../../models/simple_book_model.dart';
import '../../models/simple_movie_model.dart';
import '../../models/simple_series_model.dart';
import '../details/book_detail_screen.dart';
import '../details/movie_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Obtener libros y películas favoritos usando el provider
  List<SimpleBookModel> get _favoriteBooks {
    final provider = context.watch<AppProvider>();
    return HardcodedData.books
        .where((book) => provider.isSimpleBookFavorite(book.id))
        .toList();
  }

  List<SimpleMovieModel> get _favoriteMovies {
    final provider = context.watch<AppProvider>();
    return HardcodedData.movies
        .where((movie) => provider.isSimpleMovieFavorite(movie.id))
        .toList();
  }

  List<SimpleSeriesModel> get _favoriteSeries {
    final provider = context.watch<AppProvider>();
    return HardcodedData.series
        .where((series) => provider.isSimpleSeriesFavorite(series.id))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<SimpleBookModel> _getFilteredBooks() {
    if (_searchQuery.isEmpty) return _favoriteBooks;

    return _favoriteBooks
        .where(
          (book) =>
              book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              book.author.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  List<SimpleMovieModel> _getFilteredMovies() {
    if (_searchQuery.isEmpty) return _favoriteMovies;

    return _favoriteMovies
        .where(
          (movie) =>
              movie.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              movie.director.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  List<SimpleSeriesModel> _getFilteredSeries() {
    if (_searchQuery.isEmpty) return _favoriteSeries;

    return _favoriteSeries
        .where(
          (series) =>
              series.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              series.creator.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final filteredBooks = _getFilteredBooks();
    final filteredMovies = _getFilteredMovies();
    final filteredSeries = _getFilteredSeries();
    final totalFavorites =
        filteredBooks.length + filteredMovies.length + filteredSeries.length;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 800;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDarkMode
                          ? [Colors.grey[900]!, Colors.black]
                          : [Colors.white, Colors.grey[50]!],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 40 : 20,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mis Favoritos',
                                      style: TextStyle(
                                        fontSize: isLargeScreen ? 28 : 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.headlineLarge?.color,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$totalFavorites elementos guardados',
                                      style: TextStyle(
                                        fontSize: isLargeScreen ? 16 : 14,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color
                                            ?.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF3B82F6,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  color: const Color(0xFF3B82F6),
                                  size: isLargeScreen ? 28 : 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: isLargeScreen ? 16 : 12,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: isDarkMode
                                      ? Colors.grey[400]
                                      : Colors.grey[600],
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Buscar en favoritos...',
                                      hintStyle: TextStyle(
                                        color: isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                        fontSize: isLargeScreen ? 18 : 16,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: TextStyle(
                                      fontSize: isLargeScreen ? 18 : 16,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _searchQuery = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _FavoritesTabBarDelegate(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: isLargeScreen ? 40 : 20,
                      vertical: 10,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF3B82F6)],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      dividerColor: Colors.transparent,
                      labelColor: Colors.white,
                      unselectedLabelColor: isDarkMode
                          ? Colors.grey[400]
                          : Colors.grey[600],
                      labelStyle: TextStyle(
                        fontSize: isLargeScreen ? 16 : 14,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: isLargeScreen ? 16 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: [
                        Tab(
                          icon: Icon(Icons.apps, size: isLargeScreen ? 24 : 18),
                          text: 'Todos ($totalFavorites)',
                        ),
                        Tab(
                          icon: Icon(Icons.book, size: isLargeScreen ? 24 : 18),
                          text: 'Libros (${filteredBooks.length})',
                        ),
                        Tab(
                          icon: Icon(
                            Icons.movie,
                            size: isLargeScreen ? 24 : 18,
                          ),
                          text: 'Películas (${filteredMovies.length})',
                        ),
                        Tab(
                          icon: Icon(Icons.tv, size: isLargeScreen ? 24 : 18),
                          text: 'Series (${filteredSeries.length})',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildAllFavorites(
              isLargeScreen,
              filteredBooks,
              filteredMovies,
              filteredSeries,
            ),
            _buildBooksTab(),
            _buildMoviesTab(),
            _buildSeriesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllFavorites(
    bool isLargeScreen,
    List<SimpleBookModel> filteredBooks,
    List<SimpleMovieModel> filteredMovies,
    List<SimpleSeriesModel> filteredSeries,
  ) {
    if (filteredBooks.isEmpty &&
        filteredMovies.isEmpty &&
        filteredSeries.isEmpty) {
      return _buildEmptyState('No tienes favoritos', Icons.favorite_border);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isLargeScreen ? 40 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (filteredBooks.isNotEmpty) ...[
            _buildSectionHeader('Libros', Icons.book, filteredBooks.length),
            const SizedBox(height: 16),
            _buildBooksGrid(filteredBooks, isLargeScreen),
            const SizedBox(height: 32),
          ],
          if (filteredMovies.isNotEmpty) ...[
            _buildSectionHeader(
              'Películas',
              Icons.movie,
              filteredMovies.length,
            ),
            const SizedBox(height: 16),
            _buildMoviesGrid(filteredMovies, isLargeScreen),
            if (filteredSeries.isNotEmpty) const SizedBox(height: 32),
          ],
          if (filteredSeries.isNotEmpty) ...[
            _buildSectionHeader('Series', Icons.tv, filteredSeries.length),
            const SizedBox(height: 16),
            _buildSeriesGrid(filteredSeries, isLargeScreen),
          ],
        ],
      ),
    );
  }

  Widget _buildBooksTab() {
    final filteredBooks = _getFilteredBooks();
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 800;

    if (filteredBooks.isEmpty) {
      return _buildEmptyState('No hay libros favoritos', Icons.book);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isLargeScreen ? 40 : 20),
      child: _buildBooksGrid(filteredBooks, isLargeScreen),
    );
  }

  Widget _buildMoviesTab() {
    final filteredMovies = _getFilteredMovies();
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 800;

    if (filteredMovies.isEmpty) {
      return _buildEmptyState('No hay películas favoritas', Icons.movie);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isLargeScreen ? 40 : 20),
      child: _buildMoviesGrid(filteredMovies, isLargeScreen),
    );
  }

  Widget _buildSeriesTab() {
    final filteredSeries = _getFilteredSeries();
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 800;

    if (filteredSeries.isEmpty) {
      return _buildEmptyState('No hay series favoritas', Icons.tv);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(isLargeScreen ? 40 : 20),
      child: _buildSeriesGrid(filteredSeries, isLargeScreen),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, int count) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF3B82F6), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          '$title ($count)',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBooksGrid(List<SimpleBookModel> books, bool isLargeScreen) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 6 : 3,
        childAspectRatio: 0.7,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return _buildBookCard(book, isLargeScreen);
      },
    );
  }

  Widget _buildMoviesGrid(List<SimpleMovieModel> movies, bool isLargeScreen) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 4 : 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieCard(movie, isLargeScreen);
      },
    );
  }

  Widget _buildSeriesGrid(List<SimpleSeriesModel> series, bool isLargeScreen) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 4 : 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: series.length,
      itemBuilder: (context, index) {
        final seriesItem = series[index];
        return _buildSeriesCard(seriesItem, isLargeScreen);
      },
    );
  }

  Widget _buildBookCard(SimpleBookModel book, bool isLargeScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
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
                child: Image.asset(
                  book.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF48c6ef), Color(0xFF6f86d6)],
                        ),
                      ),
                      child: const Icon(
                        Icons.book,
                        size: 50,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    final provider = context.read<AppProvider>();
                    provider.toggleSimpleBookFavorite(book.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ),
                ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isLargeScreen ? 14 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        book.author,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: isLargeScreen ? 12 : 10,
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

  Widget _buildMovieCard(SimpleMovieModel movie, bool isLargeScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
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
                child: Image.asset(
                  movie.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF48c6ef), Color(0xFF6f86d6)],
                        ),
                      ),
                      child: const Icon(
                        Icons.movie,
                        size: 50,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    final provider = context.read<AppProvider>();
                    provider.toggleSimpleMovieFavorite(movie.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ),
                ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isLargeScreen ? 14 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        movie.director,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: isLargeScreen ? 12 : 10,
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

  Widget _buildSeriesCard(SimpleSeriesModel series, bool isLargeScreen) {
    return GestureDetector(
      onTap: () {
        // TODO: Navegar a pantalla de detalles de series cuando se implemente
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Detalles de "${series.title}" próximamente'),
            backgroundColor: const Color(0xFF3B82F6),
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
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    final provider = context.read<AppProvider>();
                    provider.toggleSimpleSeriesFavorite(series.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xFF3B82F6),
                      size: 18,
                    ),
                  ),
                ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        series.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isLargeScreen ? 14 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${series.seasons} temporadas • ${series.totalEpisodes} episodios',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: isLargeScreen ? 12 : 10,
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

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega elementos a favoritos para verlos aquí',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FavoritesTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _FavoritesTabBarDelegate({required this.child});

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
