import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 2)
class MovieModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String director;

  @HiveField(4)
  String genre;

  @HiveField(5)
  String? description;

  @HiveField(6)
  String? posterUrl;

  @HiveField(7)
  int rating; // 1-5 estrellas

  @HiveField(8)
  String? review;

  @HiveField(9)
  DateTime dateWatched;

  @HiveField(10)
  DateTime createdAt;

  @HiveField(11)
  bool isFavorite;

  @HiveField(12)
  int? releaseYear;

  @HiveField(13)
  int? durationMinutes;

  @HiveField(14)
  String? country;

  @HiveField(15)
  String language;

  @HiveField(16)
  List<String> cast;

  @HiveField(17)
  List<String> tags;

  @HiveField(18)
  String? imdbId;

  @HiveField(19)
  String? trailerUrl;

  MovieModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.director,
    required this.genre,
    this.description,
    this.posterUrl,
    this.rating = 0,
    this.review,
    DateTime? dateWatched,
    DateTime? createdAt,
    this.isFavorite = false,
    this.releaseYear,
    this.durationMinutes,
    this.country,
    this.language = 'Español',
    List<String>? cast,
    List<String>? tags,
    this.imdbId,
    this.trailerUrl,
  }) : dateWatched = dateWatched ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now(),
       cast = cast ?? [],
       tags = tags ?? [];

  // Factory constructor vacío para crear una nueva película
  factory MovieModel.empty(String userId) {
    return MovieModel(
      id: '',
      userId: userId,
      title: '',
      director: '',
      genre: '',
      description: '',
      posterUrl: null,
      rating: 0,
      review: '',
      dateWatched: DateTime.now(),
      createdAt: DateTime.now(),
      isFavorite: false,
      releaseYear: DateTime.now().year,
      durationMinutes: null,
      country: '',
      language: 'Español',
      cast: [],
      tags: [],
      imdbId: '',
      trailerUrl: '',
    );
  }

  // Copia con modificaciones
  MovieModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? director,
    String? genre,
    String? description,
    String? posterUrl,
    int? rating,
    String? review,
    DateTime? dateWatched,
    DateTime? createdAt,
    bool? isFavorite,
    int? releaseYear,
    int? durationMinutes,
    String? country,
    String? language,
    List<String>? cast,
    List<String>? tags,
    String? imdbId,
    String? trailerUrl,
  }) {
    return MovieModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      director: director ?? this.director,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      posterUrl: posterUrl ?? this.posterUrl,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      dateWatched: dateWatched ?? this.dateWatched,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      releaseYear: releaseYear ?? this.releaseYear,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      country: country ?? this.country,
      language: language ?? this.language,
      cast: cast ?? List.from(this.cast),
      tags: tags ?? List.from(this.tags),
      imdbId: imdbId ?? this.imdbId,
      trailerUrl: trailerUrl ?? this.trailerUrl,
    );
  }

  // Validar si la película tiene información completa
  bool get isValid {
    return title.isNotEmpty && director.isNotEmpty && genre.isNotEmpty;
  }

  // Obtener calificación como estrellas
  String get ratingStars {
    return '★' * rating + '☆' * (5 - rating);
  }

  // Formatear fecha de visualización
  String get formattedDate {
    final months = [
      '',
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return '${dateWatched.day} ${months[dateWatched.month]} ${dateWatched.year}';
  }

  // Formatear duración
  String get formattedDuration {
    if (durationMinutes == null) return 'N/A';
    final hours = durationMinutes! ~/ 60;
    final minutes = durationMinutes! % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}min';
    } else {
      return '${minutes}min';
    }
  }

  // Obtener reparto principal (primeros 3)
  List<String> get mainCast {
    return cast.take(3).toList();
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'director': director,
      'genre': genre,
      'description': description,
      'posterUrl': posterUrl,
      'rating': rating,
      'review': review,
      'dateWatched': dateWatched.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isFavorite': isFavorite,
      'releaseYear': releaseYear,
      'durationMinutes': durationMinutes,
      'country': country,
      'language': language,
      'cast': cast,
      'tags': tags,
      'imdbId': imdbId,
      'trailerUrl': trailerUrl,
    };
  }

  // Crear desde JSON
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      director: json['director'],
      genre: json['genre'],
      description: json['description'],
      posterUrl: json['posterUrl'],
      rating: json['rating'] ?? 0,
      review: json['review'],
      dateWatched: DateTime.parse(json['dateWatched']),
      createdAt: DateTime.parse(json['createdAt']),
      isFavorite: json['isFavorite'] ?? false,
      releaseYear: json['releaseYear'],
      durationMinutes: json['durationMinutes'],
      country: json['country'],
      language: json['language'] ?? 'Español',
      cast: List<String>.from(json['cast'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      imdbId: json['imdbId'],
      trailerUrl: json['trailerUrl'],
    );
  }

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, director: $director, genre: $genre)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
