// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 1;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      author: fields[3] as String,
      genre: fields[4] as String,
      description: fields[5] as String?,
      coverImageUrl: fields[6] as String?,
      rating: fields[7] as int,
      review: fields[8] as String?,
      dateRead: fields[9] as DateTime?,
      createdAt: fields[10] as DateTime?,
      isFavorite: fields[11] as bool,
      isbn: fields[12] as String?,
      totalPages: fields[13] as int?,
      language: fields[14] as String,
      tags: (fields[15] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.genre)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.coverImageUrl)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.review)
      ..writeByte(9)
      ..write(obj.dateRead)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.isFavorite)
      ..writeByte(12)
      ..write(obj.isbn)
      ..writeByte(13)
      ..write(obj.totalPages)
      ..writeByte(14)
      ..write(obj.language)
      ..writeByte(15)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
