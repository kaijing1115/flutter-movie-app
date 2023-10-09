import 'package:flutter/material.dart';
import '../autoload/autoloader.dart';

enum SortingOption {
  releaseDateAsc("primary_release_date.asc", "Release date oldest to newest"),
  releaseDateDesc("primary_release_date.desc", "Release date newest to oldest");

  const SortingOption(this.keyStr, this.label);
  final String label;
  final String keyStr;
}

class SortingListView extends StatefulWidget {
  const SortingListView({
    super.key,
    required this.onSelect,
  });

  final Function(SortingOption) onSelect;

  @override
  State<SortingListView> createState() => _SortingListViewState();
}

class _SortingListViewState extends State<SortingListView> {
  SortingOption? selectedOption;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: primaryColor.withAlpha(240),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            const Text(
              "--- Sort by ---",
            ),
            const SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: SortingOption.values.length,
                itemBuilder: (context, index) {
                  SortingOption option = SortingOption.values[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOption = option;
                      });
                      widget.onSelect(option);
                    },
                    child: ListTile(
                      title: Text(
                        option.label,
                        style: TextStyle(
                          color: labelColor,
                          fontSize: option == selectedOption ? 16 : 15,
                          fontWeight: option == selectedOption
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 20),
            CustomFilledTextButton(
              text: "Close",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
