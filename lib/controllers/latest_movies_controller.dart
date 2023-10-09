import 'package:get/get.dart';
import '../autoload/autoloader.dart';

class LatestMoviesController extends GetxController {
  var isLoading = false.obs;
  List<Movie> latestMovies = [];
  int totalPages = 0;
  int previousLength = 0;
  var currentPage = 0.obs;
  Rx<Genre?> genre = Rx<Genre?>(null);
  Rx<SortingOption?> sortBy = Rx<SortingOption?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchData();
  }

  void setGenreId(g) {
    genre = Rx<Genre?>(g);
    latestMovies = [];
    totalPages = 0;
    previousLength = 0;
    currentPage(0);
    fetchData();
  }

  void setSortingOption(o) {
    sortBy = Rx<SortingOption?>(o);
    latestMovies = [];
    totalPages = 0;
    previousLength = 0;
    currentPage(0);
    fetchData();
  }

  void removeGenreFilter() {
    setGenreId(null);
  }

  void removeSortBy() {
    setSortingOption(null);
  }

  Movie findById(int id) {
    return latestMovies.firstWhere((element) => element.id == id);
  }

  void fetchData() async {
    try {
      isLoading(true);
      previousLength = latestMovies.length;
      final result = await ApiClient(DioClient().dio).getLatestList(
        page: currentPage.value + 1,
        maxDate: DateTimeHelper.todayDateString(),
        minDate: DateTimeHelper.dateFromTodayString(-100),
        sortBy: sortBy.value?.keyStr,
        genres: genre.value?.id.toString(),
      );
      print(result.total_results);
      latestMovies += result.results;
      totalPages = result.total_pages;
    } catch (e) {
      print("Error while getting data; Error=$e");
    } finally {
      isLoading(false);
      currentPage(currentPage.value + 1);
    }
  }
}
