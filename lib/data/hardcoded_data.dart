import '../models/simple_book_model.dart';
import '../models/simple_movie_model.dart';
import '../models/simple_series_model.dart';

class HardcodedData {
  // Libros con datos mejorados e imágenes
  static final List<SimpleBookModel> books = [
    SimpleBookModel(
      id: '1',
      title: 'Cien años de soledad',
      author: 'Gabriel García Márquez',
      year: '1967',
      genre: 'Ficción',
      rating: 4.9,
      description:
          'Una obra maestra del realismo mágico que narra la historia multigeneracional de la familia Buendía en el pueblo ficticio de Macondo. Una exploración profunda de la soledad, el amor, la guerra y la condición humana.',
      imageUrl: 'https://m.media-amazon.com/images/I/81PIJdKGweL._SL1500_.jpg',
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
          'La historia de Elizabeth Bennet y el orgulloso Sr. Darcy. Una brillante crítica social envuelta en una de las historias de amor más queridas de la literatura inglesa.',
      imageUrl: 'https://m.media-amazon.com/images/I/81z7E0uWdtL._SL1500_.jpg',
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
          'Primera entrega de la trilogía Crónica del asesino de reyes. La historia de Kvothe, un legendario héroe cuya propia historia es tan extraordinaria como los mitos que se cuentan sobre él.',
      imageUrl: 'https://m.media-amazon.com/images/I/91dSMhdIzTL._SL1500_.jpg',
      isFavorite: false,
      isRead: false,
      category: 'Fantasía',
    ),
    SimpleBookModel(
      id: '4',
      title: '1984',
      author: 'George Orwell',
      year: '1949',
      genre: 'Distopía',
      rating: 4.7,
      description:
          'Una visionaria novela sobre un futuro totalitario donde el Gran Hermano vigila cada movimiento. Una reflexión profunda sobre el poder, la verdad y la libertad individual.',
      imageUrl: 'https://m.media-amazon.com/images/I/819js3EQwbL._SL1500_.jpg',
      isFavorite: false,
      isRead: true,
      category: 'Ciencia ficción',
    ),
    SimpleBookModel(
      id: '5',
      title: 'Donde cantan los cangrejos',
      author: 'Delia Owens',
      year: '2018',
      genre: 'Ficción',
      rating: 4.5,
      description:
          'La historia de Kya, la "Chica del Pantano" que creció aislada en las marismas de Carolina del Norte. Un misterio que combina naturaleza, amor y secretos.',
      imageUrl: 'https://m.media-amazon.com/images/I/81O55R1TjfL._SL1500_.jpg',
      isFavorite: true,
      isRead: false,
      category: 'Ficción contemporánea',
    ),
    SimpleBookModel(
      id: '6',
      title: 'Los pilares de la Tierra',
      author: 'Ken Follett',
      year: '1989',
      genre: 'Ficción histórica',
      rating: 4.6,
      description:
          'Una épica historia ambientada en el siglo XII que sigue la construcción de una catedral y las vidas entrelazadas de nobles, artesanos y clérigos.',
      imageUrl: 'https://m.media-amazon.com/images/I/91SZSW8WVIL._SL1500_.jpg',
      isFavorite: false,
      isRead: false,
      category: 'Ficción histórica',
    ),
    SimpleBookModel(
      id: '7',
      title: 'El código Da Vinci',
      author: 'Dan Brown',
      year: '2003',
      genre: 'Thriller',
      rating: 4.2,
      description:
          'Un thriller de misterio que combina arte, historia y religión en una carrera contrarreloj por descubrir secretos ancestrales.',
      imageUrl: 'https://m.media-amazon.com/images/I/815WORuYMML._SL1500_.jpg',
      isFavorite: false,
      isRead: true,
      category: 'Thriller',
    ),
    SimpleBookModel(
      id: '8',
      title: 'Comer, rezar, amar',
      author: 'Elizabeth Gilbert',
      year: '2006',
      genre: 'Autobiografía',
      rating: 4.1,
      description:
          'Un viaje de autodescubrimiento a través de Italia, India e Indonesia. Una reflexión honesta sobre la búsqueda de la felicidad y el sentido de la vida.',
      imageUrl: 'https://m.media-amazon.com/images/I/81uPiGxAU7L._SL1500_.jpg',
      isFavorite: false,
      isRead: false,
      category: 'No ficción',
    ),
  ];

  // Películas con datos mejorados e imágenes
  static final List<SimpleMovieModel> movies = [
    SimpleMovieModel(
      id: '1',
      title: 'El Padrino',
      director: 'Francis Ford Coppola',
      year: '1972',
      genre: 'Drama',
      rating: 4.9,
      duration: '175 min',
      description:
          'La saga de la familia Corleone, una poderosa dynastía del crimen organizado italiano-americano. Una obra maestra del cine que explora temas de poder, familia y tradición.',
      imageUrl:
          'https://m.media-amazon.com/images/I/81+VjmI8zjL._AC_SL1500_.jpg',
      isFavorite: true,
      isWatched: true,
      category: 'Clásicos',
    ),
    SimpleMovieModel(
      id: '2',
      title: 'Forrest Gump',
      director: 'Robert Zemeckis',
      year: '1994',
      genre: 'Drama',
      rating: 4.8,
      duration: '142 min',
      description:
          'La extraordinaria vida de Forrest Gump, un hombre con discapacidad intelectual que, sin proponérselo, se convierte en testigo de los eventos más importantes de su época.',
      imageUrl:
          'https://m.media-amazon.com/images/I/91++WV6FP3L._AC_SL1500_.jpg',
      isFavorite: true,
      isWatched: true,
      category: 'Drama',
    ),
    SimpleMovieModel(
      id: '3',
      title: 'Inception',
      director: 'Christopher Nolan',
      year: '2010',
      genre: 'Ciencia ficción',
      rating: 4.7,
      duration: '148 min',
      description:
          'Un thriller de ciencia ficción sobre Dom Cobb, un especialista en infiltrarse en los sueños para robar secretos. Una historia compleja sobre realidad, sueños y subconsciencia.',
      imageUrl:
          'https://m.media-amazon.com/images/I/81p+xe8cbnL._AC_SL1500_.jpg',
      isFavorite: false,
      isWatched: true,
      category: 'Ciencia ficción',
    ),
    SimpleMovieModel(
      id: '4',
      title: 'La La Land',
      director: 'Damien Chazelle',
      year: '2016',
      genre: 'Musical',
      rating: 4.5,
      duration: '128 min',
      description:
          'Una historia de amor entre Mia, una actriz aspirante, y Sebastian, un pianista de jazz. Un homenaje a los musicales clásicos de Hollywood.',
      imageUrl:
          'https://m.media-amazon.com/images/I/91qOCPTkJbL._AC_SL1500_.jpg',
      isFavorite: false,
      isWatched: false,
      category: 'Musical',
    ),
    SimpleMovieModel(
      id: '5',
      title: 'Interstellar',
      director: 'Christopher Nolan',
      year: '2014',
      genre: 'Ciencia ficción',
      rating: 4.6,
      duration: '169 min',
      description:
          'En un futuro donde la Tierra está muriendo, un grupo de exploradores debe atravesar un agujero de gusano para encontrar un nuevo hogar para la humanidad.',
      imageUrl:
          'https://m.media-amazon.com/images/I/91o3CqGmqNL._AC_SL1500_.jpg',
      isFavorite: true,
      isWatched: false,
      category: 'Ciencia ficción',
    ),
    SimpleMovieModel(
      id: '6',
      title: 'The Shape of Water',
      director: 'Guillermo del Toro',
      year: '2017',
      genre: 'Fantasía',
      rating: 4.3,
      duration: '123 min',
      description:
          'Un cuento de hadas para adultos sobre una mujer muda que forma una conexión única con una criatura anfibia en un laboratorio gubernamental.',
      imageUrl:
          'https://m.media-amazon.com/images/I/91ZzlkONUuL._AC_SL1500_.jpg',
      isFavorite: false,
      isWatched: true,
      category: 'Fantasía',
    ),
    SimpleMovieModel(
      id: '7',
      title: 'Parasite',
      director: 'Bong Joon-ho',
      year: '2019',
      genre: 'Thriller',
      rating: 4.8,
      duration: '132 min',
      description:
          'Una familia pobre infiltra la casa de una familia rica con consecuencias inesperadas. Una crítica social brillante envuelta en un thriller psicológico.',
      imageUrl:
          'https://m.media-amazon.com/images/I/91sustfn5cL._AC_SL1500_.jpg',
      isFavorite: false,
      isWatched: false,
      category: 'Thriller',
    ),
    SimpleMovieModel(
      id: '8',
      title: 'Coco',
      director: 'Lee Unkrich',
      year: '2017',
      genre: 'Animación',
      rating: 4.7,
      duration: '105 min',
      description:
          'Un niño mexicano viaja al Mundo de los Muertos para descubrir la verdadera historia detrás de la prohibición de la música en su familia.',
      imageUrl:
          'https://m.media-amazon.com/images/I/814W8p9BtUL._AC_SL1500_.jpg',
      isFavorite: true,
      isWatched: true,
      category: 'Animación',
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

  // Series con datos de ejemplo
  static final List<SimpleSeriesModel> series = [
    SimpleSeriesModel(
      id: 's1',
      title: 'Breaking Bad',
      creator: 'Vince Gilligan',
      year: '2008',
      genre: 'Drama',
      rating: 4.9,
      description:
          'La transformación de Walter White, un profesor de química que se convierte en productor de metanfetaminas tras ser diagnosticado con cáncer.',
      imageUrl: '',
      seasons: 5,
      totalEpisodes: 62,
      isFavorite: true,
      isWatched: false,
      category: 'Drama',
    ),
    SimpleSeriesModel(
      id: 's2',
      title: 'Game of Thrones',
      creator: 'David Benioff y D.B. Weiss',
      year: '2011',
      genre: 'Fantasía',
      rating: 4.7,
      description:
          'Una épica serie de fantasía basada en las novelas de George R.R. Martin, ambientada en los continentes ficticios de Westeros y Essos.',
      imageUrl: '',
      seasons: 8,
      totalEpisodes: 73,
      isFavorite: false,
      isWatched: true,
      category: 'Fantasía',
    ),
    SimpleSeriesModel(
      id: 's3',
      title: 'Stranger Things',
      creator: 'Los Hermanos Duffer',
      year: '2016',
      genre: 'Ciencia Ficción',
      rating: 4.6,
      description:
          'Un grupo de niños en los años 80 se enfrenta a fuerzas sobrenaturales en el pequeño pueblo de Hawkins, Indiana.',
      imageUrl: '',
      seasons: 4,
      totalEpisodes: 34,
      isFavorite: true,
      isWatched: false,
      category: 'Ciencia Ficción',
    ),
    SimpleSeriesModel(
      id: 's4',
      title: 'The Crown',
      creator: 'Peter Morgan',
      year: '2016',
      genre: 'Drama Histórico',
      rating: 4.5,
      description:
          'Una biografía dramatizada de la reina Isabel II y los eventos políticos y personales que dieron forma a su reino.',
      imageUrl: '',
      seasons: 6,
      totalEpisodes: 60,
      isFavorite: false,
      isWatched: false,
      category: 'Drama Histórico',
    ),
    SimpleSeriesModel(
      id: 's5',
      title: 'Friends',
      creator: 'David Crane y Marta Kauffman',
      year: '1994',
      genre: 'Comedia',
      rating: 4.8,
      description:
          'Las aventuras de seis amigos viviendo en Nueva York, navegando por la vida, el amor y las carreras profesionales.',
      imageUrl: '',
      seasons: 10,
      totalEpisodes: 236,
      isFavorite: true,
      isWatched: true,
      category: 'Comedia',
    ),
  ];

  // Métodos para obtener series recomendadas
  static List<SimpleSeriesModel> getRecommendedSeries() {
    return series.where((serie) => serie.rating >= 4.5).toList();
  }

  static List<SimpleSeriesModel> getNewSeries() {
    return series.where((serie) => int.parse(serie.year) >= 2015).toList();
  }
}
