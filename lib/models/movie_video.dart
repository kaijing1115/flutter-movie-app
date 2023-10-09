import 'package:json_annotation/json_annotation.dart';
part 'movie_video.g.dart';

@JsonSerializable()
class MovieVideoResult {
  final int id;
  final List<MovieVideo> results;

  MovieVideoResult({required this.id, required this.results});

  Map<String, dynamic> toJson() => _$MovieVideoResultToJson(this);

  factory MovieVideoResult.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoResultFromJson(json);
}

@JsonSerializable()
class MovieVideo {
  final String id;
  final String site;
  final String type;
  final String key;

  MovieVideo({
    required this.id,
    required this.site,
    required this.type,
    required this.key,
  });

  Map<String, dynamic> toJson() => _$MovieVideoToJson(this);

  factory MovieVideo.fromJson(Map<String, dynamic> json) =>
      _$MovieVideoFromJson(json);
}
