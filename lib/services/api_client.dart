import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../autoload/autoloader.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('genre/movie/list')
  Future<Genres> getGenre();

  @GET('movie/now_playing')
  Future<String> getNowPlaying();

  @GET(
      'discover/movie?include_adult=false&include_video=false&language=en-US&with_release_type=2|3')
  Future<MovieListResult> getLatestList({
    @Query('page') int? page,
    @Query('sort_by') String? sortBy,
    @Query('release_date.gte') String? minDate,
    @Query('release_date.lte') String? maxDate,
    @Query('with_genres') String? genres,
  });

  @GET('movie/{id}/videos?language=en-US')
  Future<MovieVideoResult> getVideo(@Path('id') String id);

  @GET("search/movie?language=en-US")
  Future<MovieListResult> searchMovie(
    @Query("query") String keyword,
    @Query("page") int page,
  );
}
