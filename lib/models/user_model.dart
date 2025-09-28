import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String displayName;

  @HiveField(3)
  String? photoUrl;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime lastLogin;

  @HiveField(6)
  bool biometricEnabled;

  @HiveField(7)
  List<String> preferences;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    DateTime? createdAt,
    DateTime? lastLogin,
    this.biometricEnabled = false,
    List<String>? preferences,
  }) : createdAt = createdAt ?? DateTime.now(),
       lastLogin = lastLogin ?? DateTime.now(),
       preferences = preferences ?? [];

  // Factory constructor para crear desde Firebase User
  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'Usuario',
      photoUrl: user.photoURL,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      biometricEnabled: false,
      preferences: [],
    );
  }

  // Copia con modificaciones
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLogin,
    bool? biometricEnabled,
    List<String>? preferences,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      preferences: preferences ?? List.from(this.preferences),
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'biometricEnabled': biometricEnabled,
      'preferences': preferences,
    };
  }

  // Crear desde JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      lastLogin: DateTime.parse(json['lastLogin']),
      biometricEnabled: json['biometricEnabled'] ?? false,
      preferences: List<String>.from(json['preferences'] ?? []),
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
