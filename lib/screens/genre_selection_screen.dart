import 'package:flutter/material.dart';

class GenreSelectionScreen extends StatefulWidget {
  const GenreSelectionScreen({super.key});

  @override
  State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Selected genres
  final Set<String> _selectedBookGenres = <String>{};
  final Set<String> _selectedMovieGenres = <String>{};

  // Available genres for books
  final List<String> _bookGenres = [
    'Ficción',
    'No ficción',
    'Misterio',
    'Romance',
    'Fantasía',
    'Ciencia ficción',
    'Historia',
    'Biografía',
    'Thriller',
    'Drama',
    'Aventura',
    'Autoayuda',
    'Literatura clásica',
    'Poesía',
    'Ensayo',
  ];

  // Available genres for movies
  final List<String> _movieGenres = [
    'Acción',
    'Aventura',
    'Comedia',
    'Drama',
    'Horror',
    'Ciencia ficción',
    'Fantasía',
    'Thriller',
    'Romance',
    'Animación',
    'Documental',
    'Musical',
    'Western',
    'Guerra',
    'Crimen',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.textTheme.bodyLarge?.color,
        title: Text(
          'Selecciona tus géneros favoritos',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Tab Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: isTablet ? 48.0 : 16.0),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: theme.textTheme.bodyMedium?.color,
                labelStyle: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: 'Libros'),
                  Tab(text: 'Películas'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Books tab
                  _buildGenreSelection(
                    genres: _bookGenres,
                    selectedGenres: _selectedBookGenres,
                    title: 'Géneros de Libros',
                    icon: Icons.book,
                    isTablet: isTablet,
                    theme: theme,
                  ),

                  // Movies tab
                  _buildGenreSelection(
                    genres: _movieGenres,
                    selectedGenres: _selectedMovieGenres,
                    title: 'Géneros de Películas',
                    icon: Icons.movie,
                    isTablet: isTablet,
                    theme: theme,
                  ),
                ],
              ),
            ),

            // Bottom buttons
            Container(
              padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(color: theme.dividerColor, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  // Skip button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _skipForNow,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: theme.primaryColor),
                      ),
                      child: Text(
                        'Saltar por ahora',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Continue button
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          (_selectedBookGenres.isNotEmpty ||
                              _selectedMovieGenres.isNotEmpty)
                          ? _continueWithPreferences
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Continuar',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreSelection({
    required List<String> genres,
    required Set<String> selectedGenres,
    required String title,
    required IconData icon,
    required bool isTablet,
    required ThemeData theme,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 48.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(icon, color: theme.primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            'Selecciona al menos uno para personalizar tu experiencia',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
            ),
          ),

          const SizedBox(height: 24),

          // Genre Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isTablet ? 3 : 2.5,
            ),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              final isSelected = selectedGenres.contains(genre);

              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedGenres.remove(genre);
                    } else {
                      selectedGenres.add(genre);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? theme.primaryColor : theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? theme.primaryColor
                          : theme.dividerColor,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: theme.primaryColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      genre,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : theme.textTheme.titleSmall?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _continueWithPreferences() {
    // Save preferences to provider
    // final appProvider = Provider.of<AppProvider>(context, listen: false);

    // Here you would typically save the preferences
    // appProvider.setBookGenres(_selectedBookGenres);
    // appProvider.setMovieGenres(_selectedMovieGenres);

    // Navigate to home
    Navigator.pushReplacementNamed(context, '/navigation');
  }

  void _skipForNow() {
    // Navigate to home without saving preferences
    Navigator.pushReplacementNamed(context, '/navigation');
  }
}
