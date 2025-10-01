class SimpleSeriesModel {
  final String id;
  final String title;
  final String creator;
  final String year;
  final String genre;
  final double rating;
  final String description;
  final String imageUrl;
  final int seasons;
  final int totalEpisodes;
  final bool isFavorite;
  final bool isWatched;
  final String category;

  SimpleSeriesModel({
    required this.id,
    required this.title,
    required this.creator,
    required this.year,
    required this.genre,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.seasons,
    required this.totalEpisodes,
    this.isFavorite = false,
    this.isWatched = false,
    required this.category,
  });

  SimpleSeriesModel copyWith({
    String? id,
    String? title,
    String? creator,
    String? year,
    String? genre,
    double? rating,
    String? description,
    String? imageUrl,
    int? seasons,
    int? totalEpisodes,
    bool? isFavorite,
    bool? isWatched,
    String? category,
  }) {
    return SimpleSeriesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      creator: creator ?? this.creator,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      seasons: seasons ?? this.seasons,
      totalEpisodes: totalEpisodes ?? this.totalEpisodes,
      isFavorite: isFavorite ?? this.isFavorite,
      isWatched: isWatched ?? this.isWatched,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleSeriesModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'SimpleSeriesModel{id: $id, title: $title, creator: $creator, year: $year, genre: $genre, rating: $rating, seasons: $seasons, totalEpisodes: $totalEpisodes}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'creator': creator,
      'year': year,
      'genre': genre,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
      'seasons': seasons,
      'totalEpisodes': totalEpisodes,
      'isFavorite': isFavorite,
      'isWatched': isWatched,
      'category': category,
    };
  }

  factory SimpleSeriesModel.fromJson(Map<String, dynamic> json) {
    return SimpleSeriesModel(
      id: json['id'],
      title: json['title'],
      creator: json['creator'],
      year: json['year'],
      genre: json['genre'],
      rating: json['rating'].toDouble(),
      description: json['description'],
      imageUrl: json['imageUrl'],
      seasons: json['seasons'],
      totalEpisodes: json['totalEpisodes'],
      isFavorite: json['isFavorite'] ?? false,
      isWatched: json['isWatched'] ?? false,
      category: json['category'],
    );
  }
}
