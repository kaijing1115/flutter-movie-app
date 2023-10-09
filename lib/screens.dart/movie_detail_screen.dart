import 'package:flutter/material.dart';
import '../autoload/autoloader.dart';

class MovieDetailScreen extends StatelessWidget {
  static String tag = "/movie-detail";
  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    Future<MovieVideo?> getMovieVideo() async {
      try {
        final result =
            await ApiClient(DioClient().dio).getVideo(movie.id.toString());
        if (result.results.isNotEmpty) {
          return result.results[0];
        }
      } catch (error) {
        print("Error when fetching data $error");
      }
      return null;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10),
                  child: FutureBuilder(
                      future: getMovieVideo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (snapshot.data != null)
                                snapshot.data!.site.compareIgnoreCase("youtube")
                                    ? PlayVideoFromYoutube(
                                        videoKey: snapshot.data!.key)
                                    : PlayVideoFromVimeo(
                                        videoKey: snapshot.data!.key),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  ...movie.movieGenreString
                                      .map((e) => Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(e),
                                          ))
                                      .toList(),
                                ],
                              ),
                              const SizedBox(height: 20),
                              if (movie.release_date.isNotEmpty)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Release on ${movie.release_date}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: labelColor,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Text(movie.overview),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.west,
        size: 30,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
