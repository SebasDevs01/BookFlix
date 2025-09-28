import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

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
      backgroundColor: theme.colorScheme.surface,
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                backgroundColor: theme.colorScheme.surface,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'BookFlix',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      appProvider.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: appProvider.toggleDarkMode,
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // Contenido principal
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Saludo personalizado
                      _buildGreetingSection(appProvider, theme),
                      const SizedBox(height: 32),

                      // Estadísticas rápidas
                      _buildStatsSection(appProvider, theme),
                      const SizedBox(height: 32),

                      // Géneros favoritos
                      if (appProvider.selectedGenres.isNotEmpty) ...[
                        _buildGenresSection(appProvider, theme),
                        const SizedBox(height: 32),
                      ],

                      // Actividad reciente
                      _buildRecentActivity(appProvider, theme),
                      const SizedBox(height: 100), // Espacio para el FAB
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

  Widget _buildGreetingSection(AppProvider appProvider, ThemeData theme) {
    final timeOfDay = DateTime.now().hour;
    String greeting;
    IconData greetingIcon;

    if (timeOfDay < 12) {
      greeting = 'Buenos días';
      greetingIcon = Icons.wb_sunny;
    } else if (timeOfDay < 18) {
      greeting = 'Buenas tardes';
      greetingIcon = Icons.wb_sunny_outlined;
    } else {
      greeting = 'Buenas noches';
      greetingIcon = Icons.nightlight_round;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.8),
            theme.colorScheme.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(greetingIcon, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  appProvider.currentUser?.displayName ?? 'Usuario',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (appProvider.currentUser?.photoUrl != null)
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(appProvider.currentUser!.photoUrl!),
              backgroundColor: Colors.white.withValues(alpha: 0.2),
            )
          else
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(AppProvider appProvider, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tu progreso',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Libros leídos',
                appProvider.totalBooksRead.toString(),
                Icons.book,
                theme.colorScheme.primary,
                theme,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Películas vistas',
                appProvider.totalMoviesWatched.toString(),
                Icons.movie,
                theme.colorScheme.secondary,
                theme,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenresSection(AppProvider appProvider, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tus géneros favoritos',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: appProvider.selectedGenres.length,
            itemBuilder: (context, index) {
              final genre = appProvider.selectedGenres[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    genre,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(AppProvider appProvider, ThemeData theme) {
    final recentBooks = appProvider.books.take(3).toList();
    final recentMovies = appProvider.movies.take(3).toList();

    if (recentBooks.isEmpty && recentMovies.isEmpty) {
      return _buildEmptyState(theme);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actividad reciente',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),

        if (recentBooks.isNotEmpty) ...[
          Text(
            'Últimos libros',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          ...recentBooks.map(
            (book) => _buildRecentItem(
              book.title,
              book.author,
              Icons.book,
              theme.colorScheme.primary,
              book.formattedDate,
              theme,
            ),
          ),
          const SizedBox(height: 16),
        ],

        if (recentMovies.isNotEmpty) ...[
          Text(
            'Últimas películas',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          ...recentMovies.map(
            (movie) => _buildRecentItem(
              movie.title,
              movie.director,
              Icons.movie,
              theme.colorScheme.secondary,
              movie.formattedDate,
              theme,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRecentItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String date,
    ThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            date,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.auto_stories_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            '¡Comienza tu colección!',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega tu primer libro o película usando el botón flotante',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
