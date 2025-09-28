import '../models/simple_book_model.dart';
import '../models/simple_movie_model.dart';

class HardcodedData {
  // Libros basados en las imágenes
  static final List<SimpleBookModel> books = [
    SimpleBookModel(
      id: '1',
      title: 'Cien años de soledad',
      author: 'Gabriel García Márquez',
      year: '1967',
      genre: 'Ficción',
      rating: 4.9,
      description:
          'Una obra maestra del realismo mágico que narra la historia de la familia Buendía.',
      imageUrl: 'assets/images/cien_anos.jpg',
      isFavorite: true,
      isRead: true,
      category: 'Literatura clásica',
    ),
    SimpleBookModel(
      id: '2',
      title: 'Orgullo y prejuicio',
      author: 'Jane Austen',
      year: '1813',
      genre: 'Romance',
      rating: 4.6,
      description:
          'Una novela clásica sobre el amor, la sociedad y los malentendidos en la Inglaterra georgiana.',
      imageUrl: 'assets/images/orgullo_prejuicio.jpg',
      isFavorite: true,
      isRead: true,
      category: 'Romance',
    ),
    SimpleBookModel(
      id: '3',
      title: 'El nombre del viento',
      author: 'Patrick Rothfuss',
      year: '2007',
      genre: 'Fantasía',
      rating: 4.8,
      description:
          'Primera entrega de la trilogía Crónica del asesino de reyes. Una historia épica de magia y aventura.',
      imageUrl: 'assets/images/nombre_viento.jpg',
      isFavorite: false,
      isRead: false,
      category: 'Fantasía',
    ),
    SimpleBookModel(
      id: '4',
      title: 'Dune',
      author: 'Frank Herbert',
      year: '1965',
      genre: 'Ciencia ficción',
      rating: 4.7,
      description:
          'Una épica de ciencia ficción que explora política, religión y ecología en un universo distante.',
      imageUrl: 'assets/images/dune.jpg',
      isFavorite: false,
      isRead: false,
      category: 'Ciencia ficción',
    ),
    SimpleBookModel(
      id: '5',
      title: 'El código Da Vinci',
      author: 'Dan Brown',
      year: '2003',
      genre: 'Misterio',
      rating: 4.2,
      description:
          'Un thriller que combina arte, historia y misterio en una aventura fascinante.',
      imageUrl: 'assets/images/codigo_davinci.jpg',
      isFavorite: false,
      isRead: true,
      category: 'Misterio',
    ),
  ];

  // Películas basadas en las imágenes
  static final List<SimpleMovieModel> movies = [
    SimpleMovieModel(
      id: '1',
      title: 'El Padrino',
      director: 'Francis Ford Coppola',
      year: '1972',
      genre: 'Drama',
      rating: 4.9,
      description:
          'La épica saga de la familia Corleone y el mundo del crimen organizado.',
      imageUrl: 'assets/images/el_padrino.jpg',
      duration: '175 min',
      isFavorite: true,
      isWatched: true,
      category: 'Drama',
    ),
    SimpleMovieModel(
      id: '2',
      title: 'Inception',
      director: 'Christopher Nolan',
      year: '2010',
      genre: 'Ciencia ficción',
      rating: 4.8,
      description:
          'Un thriller de ciencia ficción sobre la manipulación de los sueños y la realidad.',
      imageUrl: 'assets/images/inception.jpg',
      duration: '148 min',
      isFavorite: true,
      isWatched: true,
      category: 'Ciencia ficción',
    ),
    SimpleMovieModel(
      id: '3',
      title: 'Pulp Fiction',
      director: 'Quentin Tarantino',
      year: '1994',
      genre: 'Crimen',
      rating: 4.7,
      description:
          'Historias entrelazadas del submundo criminal de Los Ángeles.',
      imageUrl: 'assets/images/pulp_fiction.jpg',
      duration: '154 min',
      isFavorite: false,
      isWatched: true,
      category: 'Crimen',
    ),
    SimpleMovieModel(
      id: '4',
      title: 'Interstellar',
      director: 'Christopher Nolan',
      year: '2014',
      genre: 'Ciencia ficción',
      rating: 4.6,
      description:
          'Una aventura épica sobre la exploración espacial y la supervivencia de la humanidad.',
      imageUrl: 'assets/images/interstellar.jpg',
      duration: '169 min',
      isFavorite: false,
      isWatched: false,
      category: 'Ciencia ficción',
    ),
    SimpleMovieModel(
      id: '5',
      title: 'La La Land',
      director: 'Damien Chazelle',
      year: '2016',
      genre: 'Romance',
      rating: 4.4,
      description:
          'Un musical romántico sobre los sueños y el amor en Los Ángeles.',
      imageUrl: 'assets/images/lalaland.jpg',
      duration: '128 min',
      isFavorite: false,
      isWatched: true,
      category: 'Romance',
    ),
  ];

  // Géneros de libros
  static final List<String> bookGenres = [
    'Ficción',
    'No ficción',
    'Misterio',
    'Romance',
    'Fantasía',
    'Biografía',
    'Historia',
    'Drama',
    'Thriller',
    'Literatura clásica',
    'Poesía',
    'Ensayo',
    'Ciencia ficción',
    'Autoayuda',
    'Aventura',
  ];

  // Géneros de películas
  static final List<String> movieGenres = [
    'Acción',
    'Aventura',
    'Comedia',
    'Drama',
    'Fantasía',
    'Ciencia ficción',
    'Misterio',
    'Animación',
    'Musical',
    'Guerra',
    'Western',
    'Documental',
    'Horror',
    'Romance',
    'Thriller',
  ];

  // Estadísticas del usuario
  static const Map<String, dynamic> userStats = {
    'booksRead': 12,
    'moviesWatched': 25,
    'favoriteBooks': 3,
    'favoriteMovies': 5,
  };

  // Usuario demo
  static const Map<String, dynamic> demoUser = {
    'name': 'María García',
    'email': 'maria@email.com',
    'profilePicture': null,
    'bio':
        'Amante de los libros y las películas. Siempre en busca de nuevas historias que contar.',
    'favoriteGenres': [
      'Ficción',
      'Romance',
      'No ficción',
      'Thriller',
      'Fantasía',
      'Drama',
    ],
    'movieGenres': ['Comedia', 'Drama', 'Fantasía'],
  };

  // Métodos para filtrar datos
  static List<SimpleBookModel> getBooksByGenre(String genre) {
    return books.where((book) => book.genre == genre).toList();
  }

  static List<SimpleMovieModel> getMoviesByGenre(String genre) {
    return movies.where((movie) => movie.genre == genre).toList();
  }

  static List<SimpleBookModel> getFavoriteBooks() {
    return books.where((book) => book.isFavorite).toList();
  }

  static List<SimpleMovieModel> getFavoriteMovies() {
    return movies.where((movie) => movie.isFavorite).toList();
  }

  static List<SimpleBookModel> getReadBooks() {
    return books.where((book) => book.isRead).toList();
  }

  static List<SimpleMovieModel> getWatchedMovies() {
    return movies.where((movie) => movie.isWatched).toList();
  }

  static List<SimpleBookModel> getRecommendedBooks() {
    // Retorna libros con alta calificación que no han sido leídos
    return books.where((book) => book.rating >= 4.5 && !book.isRead).toList();
  }

  static List<SimpleMovieModel> getRecommendedMovies() {
    // Retorna películas con alta calificación que no han sido vistas
    return movies
        .where((movie) => movie.rating >= 4.5 && !movie.isWatched)
        .toList();
  }
}
