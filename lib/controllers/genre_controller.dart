import 'package:get/get.dart';
import '../autoload/autoloader.dart';

class GenreController extends GetxController {
  final RxList<Genre> genreList = <Genre>[].obs;

  Future fetchData() async {
    try {
      final result = await ApiClient(DioClient().dio).getGenre();
      genreList(result.genres);
    } catch (e) {
      print("Error while getting data; Error=$e");
    } finally {}
  }

  String genreStringFromId(id) {
    return genreList.firstWhere((genre) => genre.id == id).name;
  }
}
