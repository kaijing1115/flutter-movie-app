// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieListResult _$MovieListResultFromJson(Map<String, dynamic> json) =>
    MovieListResult(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_pages: json['total_pages'] as int,
      total_results: json['total_results'] as int,
    );

Map<String, dynamic> _$MovieListResultToJson(MovieListResult instance) =>
    <String, dynamic>{
      'results': instance.results,
      'total_pages': instance.total_pages,
      'total_results': instance.total_results,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int,
      genre_ids:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      title: json['title'] as String,
      backdrop_path: json['backdrop_path'] as String?,
      poster_path: json['poster_path'] as String?,
      overview: json['overview'] as String,
      release_date: json['release_date'] as String,
      vote_average: (json['vote_average'] as num).toDouble(),
      vote_count: json['vote_count'] as int,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'genre_ids': instance.genre_ids,
      'title': instance.title,
      'backdrop_path': instance.backdrop_path,
      'poster_path': instance.poster_path,
      'overview': instance.overview,
      'release_date': instance.release_date,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };
