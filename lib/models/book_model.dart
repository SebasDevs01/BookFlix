import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 1)
class BookModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String author;

  @HiveField(4)
  String genre;

  @HiveField(5)
  String? description;

  @HiveField(6)
  String? coverImageUrl;

  @HiveField(7)
  int rating; // 1-5 estrellas

  @HiveField(8)
  String? review;

  @HiveField(9)
  DateTime dateRead;

  @HiveField(10)
  DateTime createdAt;

  @HiveField(11)
  bool isFavorite;

  @HiveField(12)
  String? isbn;

  @HiveField(13)
  int? totalPages;

  @HiveField(14)
  String language;

  @HiveField(15)
  List<String> tags;

  BookModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.author,
    required this.genre,
    this.description,
    this.coverImageUrl,
    this.rating = 0,
    this.review,
    DateTime? dateRead,
    DateTime? createdAt,
    this.isFavorite = false,
    this.isbn,
    this.totalPages,
    this.language = 'Español',
    List<String>? tags,
  }) : dateRead = dateRead ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now(),
       tags = tags ?? [];

  // Factory constructor vacío para crear un nuevo libro
  factory BookModel.empty(String userId) {
    return BookModel(
      id: '',
      userId: userId,
      title: '',
      author: '',
      genre: '',
      description: '',
      coverImageUrl: null,
      rating: 0,
      review: '',
      dateRead: DateTime.now(),
      createdAt: DateTime.now(),
      isFavorite: false,
      isbn: '',
      totalPages: null,
      language: 'Español',
      tags: [],
    );
  }

  // Copia con modificaciones
  BookModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? author,
    String? genre,
    String? description,
    String? coverImageUrl,
    int? rating,
    String? review,
    DateTime? dateRead,
    DateTime? createdAt,
    bool? isFavorite,
    String? isbn,
    int? totalPages,
    String? language,
    List<String>? tags,
  }) {
    return BookModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      dateRead: dateRead ?? this.dateRead,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      isbn: isbn ?? this.isbn,
      totalPages: totalPages ?? this.totalPages,
      language: language ?? this.language,
      tags: tags ?? List.from(this.tags),
    );
  }

  // Validar si el libro tiene información completa
  bool get isValid {
    return title.isNotEmpty && author.isNotEmpty && genre.isNotEmpty;
  }

  // Obtener calificación como estrellas
  String get ratingStars {
    return '★' * rating + '☆' * (5 - rating);
  }

  // Formatear fecha de lectura
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
    return '${dateRead.day} ${months[dateRead.month]} ${dateRead.year}';
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'author': author,
      'genre': genre,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'rating': rating,
      'review': review,
      'dateRead': dateRead.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'isFavorite': isFavorite,
      'isbn': isbn,
      'totalPages': totalPages,
      'language': language,
      'tags': tags,
    };
  }

  // Crear desde JSON
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      description: json['description'],
      coverImageUrl: json['coverImageUrl'],
      rating: json['rating'] ?? 0,
      review: json['review'],
      dateRead: DateTime.parse(json['dateRead']),
      createdAt: DateTime.parse(json['createdAt']),
      isFavorite: json['isFavorite'] ?? false,
      isbn: json['isbn'],
      totalPages: json['totalPages'],
      language: json['language'] ?? 'Español',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  @override
  String toString() {
    return 'BookModel(id: $id, title: $title, author: $author, genre: $genre)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
