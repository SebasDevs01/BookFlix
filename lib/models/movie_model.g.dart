// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 2;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      director: fields[3] as String,
      genre: fields[4] as String,
      description: fields[5] as String?,
      posterUrl: fields[6] as String?,
      rating: fields[7] as int,
      review: fields[8] as String?,
      dateWatched: fields[9] as DateTime?,
      createdAt: fields[10] as DateTime?,
      isFavorite: fields[11] as bool,
      releaseYear: fields[12] as int?,
      durationMinutes: fields[13] as int?,
      country: fields[14] as String?,
      language: fields[15] as String,
      cast: (fields[16] as List?)?.cast<String>(),
      tags: (fields[17] as List?)?.cast<String>(),
      imdbId: fields[18] as String?,
      trailerUrl: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.director)
      ..writeByte(4)
      ..write(obj.genre)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.posterUrl)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.review)
      ..writeByte(9)
      ..write(obj.dateWatched)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.isFavorite)
      ..writeByte(12)
      ..write(obj.releaseYear)
      ..writeByte(13)
      ..write(obj.durationMinutes)
      ..writeByte(14)
      ..write(obj.country)
      ..writeByte(15)
      ..write(obj.language)
      ..writeByte(16)
      ..write(obj.cast)
      ..writeByte(17)
      ..write(obj.tags)
      ..writeByte(18)
      ..write(obj.imdbId)
      ..writeByte(19)
      ..write(obj.trailerUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
