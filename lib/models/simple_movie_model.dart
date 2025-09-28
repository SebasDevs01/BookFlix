class SimpleMovieModel {
  final String id;
  final String title;
  final String director;
  final String year;
  final String genre;
  final double rating;
  final String description;
  final String imageUrl;
  final String duration;
  final bool isFavorite;
  final bool isWatched;
  final String category;

  SimpleMovieModel({
    required this.id,
    required this.title,
    required this.director,
    required this.year,
    required this.genre,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.duration,
    this.isFavorite = false,
    this.isWatched = false,
    required this.category,
  });

  SimpleMovieModel copyWith({
    String? id,
    String? title,
    String? director,
    String? year,
    String? genre,
    double? rating,
    String? description,
    String? imageUrl,
    String? duration,
    bool? isFavorite,
    bool? isWatched,
    String? category,
  }) {
    return SimpleMovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      director: director ?? this.director,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      isWatched: isWatched ?? this.isWatched,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'year': year,
      'genre': genre,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
      'duration': duration,
      'isFavorite': isFavorite,
      'isWatched': isWatched,
      'category': category,
    };
  }

  factory SimpleMovieModel.fromJson(Map<String, dynamic> json) {
    return SimpleMovieModel(
      id: json['id'],
      title: json['title'],
      director: json['director'],
      year: json['year'],
      genre: json['genre'],
      rating: json['rating']?.toDouble() ?? 0.0,
      description: json['description'],
      imageUrl: json['imageUrl'],
      duration: json['duration'],
      isFavorite: json['isFavorite'] ?? false,
      isWatched: json['isWatched'] ?? false,
      category: json['category'],
    );
  }
}
