import 'package:json_annotation/json_annotation.dart';
import 'package:get/get.dart';
import '../autoload/autoloader.dart';
part 'movie.g.dart';

@JsonSerializable()
class MovieListResult {
  final List<Movie> results;
  final int total_pages;
  final int total_results;

  MovieListResult({
    List<Movie>? results,
    required this.total_pages,
    required this.total_results,
  }) : results = results ?? [];

  Map<String, dynamic> toJson() => _$MovieListResultToJson(this);

  factory MovieListResult.fromJson(Map<String, dynamic> json) =>
      _$MovieListResultFromJson(json);
}

@JsonSerializable()
class Movie {
  final int id;
  final List<int> genre_ids;
  final String title;
  final String? backdrop_path;
  final String? poster_path;
  final String overview;
  final String release_date;
  final double vote_average;
  final int vote_count;

  Movie(
      {required this.id,
      required this.genre_ids,
      required this.title,
      this.backdrop_path,
      this.poster_path,
      required this.overview,
      required this.release_date,
      required this.vote_average,
      required this.vote_count});

  String? get posterUrl {
    if (poster_path == null) {
      return null;
    }
    return "https://image.tmdb.org/t/p/w500/$poster_path";
  }

  List<String> get movieGenreString {
    final GenreController genreController = Get.put(GenreController());
    return genre_ids
        .map((genreId) => genreController.genreStringFromId(genreId))
        .toList();
  }

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
