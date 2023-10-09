// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVideoResult _$MovieVideoResultFromJson(Map<String, dynamic> json) =>
    MovieVideoResult(
      id: json['id'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieVideo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieVideoResultToJson(MovieVideoResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
    };

MovieVideo _$MovieVideoFromJson(Map<String, dynamic> json) => MovieVideo(
      id: json['id'] as String,
      site: json['site'] as String,
      type: json['type'] as String,
      key: json['key'] as String,
    );

Map<String, dynamic> _$MovieVideoToJson(MovieVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'site': instance.site,
      'type': instance.type,
      'key': instance.key,
    };
