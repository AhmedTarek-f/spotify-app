// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineSongModelAdapter extends TypeAdapter<OfflineSongModel> {
  @override
  final int typeId = 0;

  @override
  OfflineSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineSongModel(
      songId: fields[0] as String,
      songImage: fields[1] as String,
      songTitle: fields[2] as String,
      songAuthor: fields[3] as String,
      songLength: fields[4] as String,
      localFilePath: fields[5] as String?,
      lyrics: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineSongModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.songImage)
      ..writeByte(2)
      ..write(obj.songTitle)
      ..writeByte(3)
      ..write(obj.songAuthor)
      ..writeByte(4)
      ..write(obj.songLength)
      ..writeByte(5)
      ..write(obj.localFilePath)
      ..writeByte(6)
      ..write(obj.lyrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
