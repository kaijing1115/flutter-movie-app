import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../autoload/autoloader.dart';

class HomeScreen extends StatelessWidget {
  static String tag = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LatestMoviesController latestMoviesController =
        Get.put(LatestMoviesController());

    return Scaffold(
      body: Container(
        color: primaryColor,
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SearchScreen(),
                        ));
                      },
                      child: const IconBorderTextField(
                        icon: Icons.search,
                        hintText: "Search",
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Movie List",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FilterRowWidget(
                        latestMoviesController: latestMoviesController),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Obx(() {
                        if (latestMoviesController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return LatestMoviePageView(
                            latestMoviesController: latestMoviesController,
                            height: constraints.maxHeight * 0.5,
                            onPageTap: (movie) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => MovieDetailScreen(
                                    movie: movie,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class FilterRowWidget extends StatelessWidget {
  const FilterRowWidget({
    super.key,
    required this.latestMoviesController,
  });

  final LatestMoviesController latestMoviesController;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        GenreFilterWidget(
          latestMoviesController: latestMoviesController,
        ),
        SortingWidget(
          latestMoviesController: latestMoviesController,
        ),
      ],
    );
  }
}

class SortingWidget extends StatefulWidget {
  const SortingWidget({super.key, required this.latestMoviesController});

  final LatestMoviesController latestMoviesController;

  @override
  State<SortingWidget> createState() => _SortingWidgetState();
}

class _SortingWidgetState extends State<SortingWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomBorderLabel(
        label: widget.latestMoviesController.sortBy.value?.label ?? "Sort by",
        icon: Icons.sort,
        backgroundColor: widget.latestMoviesController.sortBy.value != null
            ? selectedBackgroundColor
            : null,
        onPressed: () {
          if (widget.latestMoviesController.sortBy.value != null) {
            widget.latestMoviesController.removeSortBy();
            setState(() {});
            return;
          }
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: SortingListView(
                onSelect: (option) {
                  widget.latestMoviesController.setSortingOption(option);
                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        });
  }
}

class GenreFilterWidget extends StatefulWidget {
  const GenreFilterWidget({
    super.key,
    required this.latestMoviesController,
  });

  final LatestMoviesController latestMoviesController;

  @override
  State<GenreFilterWidget> createState() => _GenreFilterWidgetState();
}

class _GenreFilterWidgetState extends State<GenreFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return FilterBorderWidget(
      label: "Filter",
      selectedFilter: widget.latestMoviesController.genre.value?.name,
      clearPressed: () {
        widget.latestMoviesController.removeGenreFilter();
        setState(() {});
      },
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: GenreListView(
              onSelect: (selectedGenre) {
                widget.latestMoviesController.setGenreId(selectedGenre);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }
}

class LatestMoviePageView extends StatelessWidget {
  const LatestMoviePageView({
    super.key,
    required this.latestMoviesController,
    required this.height,
    required this.onPageTap,
  });

  final LatestMoviesController latestMoviesController;
  final double height;
  final Function(Movie) onPageTap;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    if (latestMoviesController.latestMovies.isNotEmpty) {
      controller = PageController(
        initialPage: (latestMoviesController.previousLength),
      );
    }

    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        if (index == latestMoviesController.latestMovies.length) {
          latestMoviesController.fetchData();
        }
      },
      children: [
        ...latestMoviesController.latestMovies.map((item) {
          return GestureDetector(
            onTap: () {
              onPageTap(item);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height,
                  child: (item.posterUrl ?? '').isEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                            child: Text(
                              "No Image",
                              style: TextStyle(
                                fontSize: 16,
                                color: labelColor.withAlpha(220),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Image.network(
                            item.posterUrl!,
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  item.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          );
        }).toList(),
        Container(),
      ],
    );
  }
}
