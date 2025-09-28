import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../data/hardcoded_data.dart';
import '../../models/simple_book_model.dart';
import '../../models/simple_movie_model.dart';
import '../details/book_detail_screen.dart';
import '../details/movie_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  // Simulamos libros y películas guardados en la biblioteca
  final List<SimpleBookModel> _savedBooks = HardcodedData.books
      .take(6)
      .toList();
  final List<SimpleMovieModel> _savedMovies = HardcodedData.movies
      .take(4)
      .toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 160,
                pinned: true,
                backgroundColor: theme.colorScheme.surface,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Mi Biblioteca',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _isSearching ? Icons.close : Icons.search,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                        if (!_isSearching) {
                          _searchController.clear();
                          _searchQuery = '';
                        }
                      });
                    },
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.sort, color: theme.colorScheme.onSurface),
                    onSelected: (value) {
                      // Sorting functionality to be implemented based on user preference
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ordenando por $value')),
                      );
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'title',
                        child: Text('Ordenar por título'),
                      ),
                      const PopupMenuItem(
                        value: 'date',
                        child: Text('Ordenar por fecha'),
                      ),
                      const PopupMenuItem(
                        value: 'rating',
                        child: Text('Ordenar por calificación'),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                ],
                bottom: _isSearching
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(60),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: _searchController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Buscar libros o películas...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor:
                                  theme.colorScheme.surfaceContainerHighest,
                            ),
                          ),
                        ),
                      )
                    : TabBar(
                        controller: _tabController,
                        labelColor: theme.colorScheme.primary,
                        unselectedLabelColor: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                        indicatorColor: theme.colorScheme.primary,
                        labelStyle: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        tabs: const [
                          Tab(icon: Icon(Icons.book), text: 'Libros'),
                          Tab(icon: Icon(Icons.movie), text: 'Películas'),
                        ],
                      ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildBooksTab(appProvider, theme),
                _buildMoviesTab(appProvider, theme),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBooksTab(AppProvider appProvider, ThemeData theme) {
    List<SimpleBookModel> books = _searchQuery.isEmpty
        ? _savedBooks
        : _savedBooks
              .where(
                (book) =>
                    book.title.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ||
                    book.author.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ),
              )
              .toList();

    if (books.isEmpty) {
      return _buildEmptyState(
        'No hay libros',
        _searchQuery.isEmpty
            ? 'Agrega libros desde la búsqueda o las recomendaciones'
            : 'No se encontraron libros con "$_searchQuery"',
        Icons.book_outlined,
        theme,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return _buildBookCard(book, theme);
        },
      ),
    );
  }

  Widget _buildMoviesTab(AppProvider appProvider, ThemeData theme) {
    List<SimpleMovieModel> movies = _searchQuery.isEmpty
        ? _savedMovies
        : _savedMovies
              .where(
                (movie) =>
                    movie.title.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ||
                    movie.director.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ),
              )
              .toList();

    if (movies.isEmpty) {
      return _buildEmptyState(
        'No hay películas',
        _searchQuery.isEmpty
            ? 'Agrega películas desde la búsqueda o las recomendaciones'
            : 'No se encontraron películas con "$_searchQuery"',
        Icons.movie_outlined,
        theme,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _buildMovieCard(movie, theme);
        },
      ),
    );
  }

  Widget _buildBookCard(SimpleBookModel book, ThemeData theme) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Portada del libro
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.7),
                      theme.colorScheme.secondary.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(Icons.book, size: 40, color: Colors.white),
              ),
            ),

            // Información del libro
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        book.genre,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieCard(SimpleMovieModel movie, ThemeData theme) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Póster de la película
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withValues(alpha: 0.7),
                      Colors.purple.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(Icons.movie, size: 40, color: Colors.white),
              ),
            ),

            // Información de la película
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.director,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            movie.genre,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          movie.year.toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    String title,
    String message,
    IconData icon,
    ThemeData theme,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
