import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/book_model.dart';
import '../models/movie_model.dart';
import '../services/auth_service.dart';

class AppProvider extends ChangeNotifier {
  // Boxes de Hive
  Box<UserModel>? _userBox;
  Box<BookModel>? _booksBox;
  Box<MovieModel>? _moviesBox;
  Box? _settingsBox;

  // Estado de la aplicación
  UserModel? _currentUser;
  List<BookModel> _books = [];
  List<MovieModel> _movies = [];
  bool _isDarkMode = false;
  bool _isLoading = false;
  String? _errorMessage;
  int _currentIndex = 1; // Empieza en "Inicio"
  List<String> _selectedGenres = [];
  bool _showGenreSelection = false;

  // Auth Service
  final AuthService _authService = AuthService();

  // Getters
  UserModel? get currentUser => _currentUser;
  List<BookModel> get books => _books;
  List<MovieModel> get movies => _movies;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get currentIndex => _currentIndex;
  List<String> get selectedGenres => _selectedGenres;
  bool get showGenreSelection => _showGenreSelection;
  bool get isAuthenticated => _currentUser != null;

  // Géneros disponibles
  static const List<String> availableGenres = [
    'Acción',
    'Aventura',
    'Ciencia Ficción',
    'Drama',
    'Fantasía',
    'Horror',
    'Misterio',
    'Romance',
    'Thriller',
    'Comedia',
    'Histórico',
    'Biografía',
    'Documental',
    'Animación',
    'Musical',
  ];

  // Inicialización
  Future<void> init() async {
    setLoading(true);
    try {
      await _initHive();
      await _loadUserData();
      await _loadSettings();
      clearError();
    } catch (e) {
      setError('Error al inicializar la aplicación: $e');
    }
    setLoading(false);
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();

    // Registrar adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(MovieModelAdapter());
    }

    // Abrir boxes
    _userBox = await Hive.openBox<UserModel>('users');
    _booksBox = await Hive.openBox<BookModel>('books');
    _moviesBox = await Hive.openBox<MovieModel>('movies');
    _settingsBox = await Hive.openBox('settings');
  }

  Future<void> _loadUserData() async {
    final userData = _userBox?.get('currentUser');
    if (userData != null) {
      _currentUser = userData;
      await _loadUserContent();
    }
  }

  Future<void> _loadUserContent() async {
    if (_currentUser == null) return;

    _books =
        _booksBox?.values
            .where((book) => book.userId == _currentUser!.id)
            .toList() ??
        [];

    _movies =
        _moviesBox?.values
            .where((movie) => movie.userId == _currentUser!.id)
            .toList() ??
        [];

    notifyListeners();
  }

  Future<void> _loadSettings() async {
    _isDarkMode = _settingsBox?.get('isDarkMode', defaultValue: false) ?? false;
    _selectedGenres = List<String>.from(
      _settingsBox?.get('selectedGenres', defaultValue: <String>[]) ?? [],
    );
    _showGenreSelection = _selectedGenres.isEmpty;
  }

  // Autenticación
  Future<bool> signInWithGoogle() async {
    setLoading(true);
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        _currentUser = user;
        await _userBox?.put('currentUser', user);
        await _loadUserContent();
        clearError();
        return true;
      }
      setError('Error al iniciar sesión con Google');
      return false;
    } catch (e) {
      setError('Error de autenticación: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    if (_currentUser == null) return false;

    setLoading(true);
    try {
      final isAuthenticated = await _authService.authenticateWithBiometrics();
      if (isAuthenticated) {
        clearError();
        return true;
      }
      setError('Autenticación biométrica fallida');
      return false;
    } catch (e) {
      setError('Error en autenticación biométrica: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> signOut() async {
    setLoading(true);
    try {
      await _authService.signOut();
      _currentUser = null;
      _books.clear();
      _movies.clear();
      _selectedGenres.clear();
      await _userBox?.delete('currentUser');
      _showGenreSelection = true;
      clearError();
    } catch (e) {
      setError('Error al cerrar sesión: $e');
    }
    setLoading(false);
  }

  // Manejo de géneros
  void toggleGenre(String genre) {
    if (_selectedGenres.contains(genre)) {
      _selectedGenres.remove(genre);
    } else {
      _selectedGenres.add(genre);
    }
    _settingsBox?.put('selectedGenres', _selectedGenres);
    notifyListeners();
  }

  void completeGenreSelection() {
    _showGenreSelection = false;
    notifyListeners();
  }

  void resetGenreSelection() {
    _selectedGenres.clear();
    _showGenreSelection = true;
    _settingsBox?.put('selectedGenres', _selectedGenres);
    notifyListeners();
  }

  // Navegación
  void setCurrentIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  // Tema
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _settingsBox?.put('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // Libros
  Future<void> addBook(BookModel book) async {
    if (_currentUser == null) return;

    book.userId = _currentUser!.id;
    book.id = DateTime.now().millisecondsSinceEpoch.toString();

    await _booksBox?.put(book.id, book);
    _books.add(book);
    notifyListeners();
  }

  Future<void> updateBook(BookModel book) async {
    await _booksBox?.put(book.id, book);
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index] = book;
      notifyListeners();
    }
  }

  Future<void> deleteBook(String bookId) async {
    await _booksBox?.delete(bookId);
    _books.removeWhere((b) => b.id == bookId);
    notifyListeners();
  }

  void toggleBookFavorite(String bookId) {
    final book = _books.firstWhere((b) => b.id == bookId);
    book.isFavorite = !book.isFavorite;
    updateBook(book);
  }

  // Películas
  Future<void> addMovie(MovieModel movie) async {
    if (_currentUser == null) return;

    movie.userId = _currentUser!.id;
    movie.id = DateTime.now().millisecondsSinceEpoch.toString();

    await _moviesBox?.put(movie.id, movie);
    _movies.add(movie);
    notifyListeners();
  }

  Future<void> updateMovie(MovieModel movie) async {
    await _moviesBox?.put(movie.id, movie);
    final index = _movies.indexWhere((m) => m.id == movie.id);
    if (index != -1) {
      _movies[index] = movie;
      notifyListeners();
    }
  }

  Future<void> deleteMovie(String movieId) async {
    await _moviesBox?.delete(movieId);
    _movies.removeWhere((m) => m.id == movieId);
    notifyListeners();
  }

  void toggleMovieFavorite(String movieId) {
    final movie = _movies.firstWhere((m) => m.id == movieId);
    movie.isFavorite = !movie.isFavorite;
    updateMovie(movie);
  }

  // Filtros y búsqueda
  List<BookModel> get favoriteBooks =>
      _books.where((book) => book.isFavorite).toList();

  List<MovieModel> get favoriteMovies =>
      _movies.where((movie) => movie.isFavorite).toList();

  List<BookModel> searchBooks(String query) {
    if (query.isEmpty) return _books;
    return _books
        .where(
          (book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()) ||
              book.genre.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  List<MovieModel> searchMovies(String query) {
    if (query.isEmpty) return _movies;
    return _movies
        .where(
          (movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()) ||
              movie.director.toLowerCase().contains(query.toLowerCase()) ||
              movie.genre.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  List<BookModel> getBooksByGenre(String genre) {
    return _books.where((book) => book.genre == genre).toList();
  }

  List<MovieModel> getMoviesByGenre(String genre) {
    return _movies.where((movie) => movie.genre == genre).toList();
  }

  // Estadísticas
  int get totalBooksRead => _books.length;
  int get totalMoviesWatched => _movies.length;

  Map<String, int> get booksStatsByGenre {
    Map<String, int> stats = {};
    for (var book in _books) {
      stats[book.genre] = (stats[book.genre] ?? 0) + 1;
    }
    return stats;
  }

  Map<String, int> get moviesStatsByGenre {
    Map<String, int> stats = {};
    for (var movie in _movies) {
      stats[movie.genre] = (stats[movie.genre] ?? 0) + 1;
    }
    return stats;
  }

  // Utilidades
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _userBox?.close();
    _booksBox?.close();
    _moviesBox?.close();
    _settingsBox?.close();
    super.dispose();
  }
}
