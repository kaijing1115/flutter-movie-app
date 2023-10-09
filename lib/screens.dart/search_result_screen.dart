import 'package:flutter/material.dart';
import '../autoload/autoloader.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key, required this.keyword});

  final String keyword;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  bool isLoading = false;
  MovieListResult? mlResult;
  List<Movie> movieList = [];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    searchMovie();
  }

  @override
  void setState(void Function() fn) {
    if (context.mounted) {
      super.setState(fn);
    } else {
      fn;
    }
  }

  Future<void> searchMovie() async {
    if (currentPage == 0) {
      setState(() {
        isLoading = true;
      });
    }
    try {
      final response = await ApiClient(DioClient().dio)
          .searchMovie(widget.keyword, currentPage + 1);
      setState(() {
        mlResult = response;
        movieList += response.results;
        currentPage++;
      });
    } catch (error) {
      print("Error when fetching data $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: primaryColor,
          width: double.infinity,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Search result for \"${widget.keyword}\""),
                        if (!isLoading && mlResult != null)
                          Text(
                            "${mlResult!.total_results} result found",
                            style: TextStyle(
                              color: labelColor.withAlpha(200),
                            ),
                          ),
                        const SizedBox(height: 16),
                        if (!isLoading && movieList.isNotEmpty)
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: movieList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 45 / 100,
                              ),
                              itemBuilder: (context, index) {
                                Movie movie = movieList[index];
                                if (index == movieList.length - 1) {
                                  if (currentPage < mlResult!.total_pages) {
                                    searchMovie();
                                  }
                                }
                                return MovieGridItem(movie: movie);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class MovieGridItem extends StatelessWidget {
  const MovieGridItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movie: movie,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: (movie.posterUrl ?? '').isEmpty
                ? Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'No Image',
                        style: TextStyle(
                          color: labelColor.withAlpha(220),
                        ),
                      ),
                    ),
                  )
                : Image.network(movie.posterUrl!),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
