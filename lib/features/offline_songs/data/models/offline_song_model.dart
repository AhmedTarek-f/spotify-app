import 'package:hive/hive.dart';

part 'offline_song_model.g.dart';
@HiveType(typeId: 0)
class OfflineSongModel extends HiveObject{
  OfflineSongModel({
    required this.songId,
    required this.songImage,
    required this.songTitle,
    required this.songAuthor,
    required this.songLength,
    required this.localFilePath,
    required this.lyrics,

  });

  @HiveField(0)
  final String songId;
  @HiveField(1)
  final String songImage;
  @HiveField(2)
  final String songTitle;
  @HiveField(3)
  final String songAuthor;
  @HiveField(4)
  final String songLength;
  @HiveField(5)
  String? localFilePath;
  @HiveField(6)
  final String lyrics;
}