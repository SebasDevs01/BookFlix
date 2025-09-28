class SimpleBookModel {
  final String id;
  final String title;
  final String author;
  final String year;
  final String genre;
  final double rating;
  final String description;
  final String imageUrl;
  final bool isFavorite;
  final bool isRead;
  final String category;

  SimpleBookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
    required this.genre,
    required this.rating,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
    this.isRead = false,
    required this.category,
  });

  SimpleBookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? year,
    String? genre,
    double? rating,
    String? description,
    String? imageUrl,
    bool? isFavorite,
    bool? isRead,
    String? category,
  }) {
    return SimpleBookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      isRead: isRead ?? this.isRead,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'year': year,
      'genre': genre,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'isRead': isRead,
      'category': category,
    };
  }

  factory SimpleBookModel.fromJson(Map<String, dynamic> json) {
    return SimpleBookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      year: json['year'],
      genre: json['genre'],
      rating: json['rating']?.toDouble() ?? 0.0,
      description: json['description'],
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'] ?? false,
      isRead: json['isRead'] ?? false,
      category: json['category'],
    );
  }
}
