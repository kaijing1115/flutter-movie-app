import 'package:json_annotation/json_annotation.dart';
part 'genre.g.dart';

@JsonSerializable()
class Genres {
  final List<Genre> genres;

  Genres({List<Genre>? genres}) : genres = genres ?? [];

  Map<String, dynamic> toJson() => _$GenresToJson(this);
  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
}

@JsonSerializable()
class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  Map<String, dynamic> toJson() => _$GenreToJson(this);

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
