import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../autoload/autoloader.dart';

class GenreListView extends StatefulWidget {
  const GenreListView({super.key, required this.onSelect});

  final Function(Genre) onSelect;

  @override
  State<GenreListView> createState() => _GenreListViewState();
}

class _GenreListViewState extends State<GenreListView> {
  Genre? selectedGenre;

  @override
  Widget build(BuildContext context) {
    final GenreController genreController = Get.put(GenreController());
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        color: primaryColor.withAlpha(240),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        height: constraints.maxHeight * 0.7,
        child: Column(
          children: [
            const Text(
              "--- Please select genre ---",
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 1),
                itemCount: genreController.genreList.length,
                itemBuilder: (BuildContext context, int index) {
                  Genre data = genreController.genreList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGenre = data;
                      });
                      widget.onSelect(data);
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: TextStyle(
                              color: labelColor,
                              fontSize: data == selectedGenre ? 18 : 16,
                              fontWeight: data == selectedGenre
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomFilledTextButton(
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }
}
