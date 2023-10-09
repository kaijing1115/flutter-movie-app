import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../autoload/autoloader.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String spKey = '/search-history';
  List<String> _searchHistory = [];
  final TextEditingController tfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void setState(void Function() fn) {
    if (context.mounted) {
      super.setState(fn);
    } else {
      fn;
    }
  }

  void init() async {
    List<String> history =
        await SharedPreferenceHelper.getPreference<List<String>>(spKey) ?? [];
    setState(() {
      _searchHistory = history;
    });
  }

  Future<void> _appendHistory(String value) async {
    if (_searchHistory.contains(value)) {
      int index = _searchHistory.indexWhere((val) => value == val);
      _searchHistory.removeAt(index);
    }

    setState(() {
      _searchHistory.insert(0, value);
      if (_searchHistory.length > 20) {
        _searchHistory.removeRange(20, _searchHistory.length);
      }
    });
    await SharedPreferenceHelper.setPreference<List<String>>(
        spKey, _searchHistory);
  }

  Future<void> _removeHistoryAtIndex(int index) async {
    setState(() {
      _searchHistory.removeAt(index);
    });
    await SharedPreferenceHelper.setPreference<List<String>>(
        spKey, _searchHistory);
  }

  Future<void> _removeAll() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmation"),
        content: const Text("Are you sure to clear all search history?"),
        backgroundColor: Colors.grey.shade500,
        actions: [
          CustomFilledTextButton(
            onPressed: () async {
              setState(() {
                _searchHistory.clear();
              });
              await SharedPreferenceHelper.removePreference(spKey);
              if (mounted) Navigator.of(context).pop();
              Fluttertoast.showToast(
                  msg: "Search history cleared",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey.withOpacity(0.7),
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            text: "Yes",
          ),
          CustomFilledTextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: "Cancel",
              backgroundColor: Colors.grey.shade900),
        ],
      ),
    );
  }

  void proceedSearch(String keyword) async {
    await _appendHistory(keyword);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(
          keyword: keyword,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomBackButton(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: IconBorderTextField(
                        controller: tfController,
                        icon: Icons.search,
                        hintText: "Search",
                        clearable: true,
                        onSubmitted: (value) {
                          proceedSearch(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.history,
                    ),
                    GestureDetector(
                      onTap: _removeAll,
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.delete),
                          SizedBox(width: 6),
                          Text('Clear all'),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchHistory.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                            onTap: () {
                              tfController.text = _searchHistory[index];
                              proceedSearch(tfController.text);
                            },
                            child: SearchListTile(
                              title: _searchHistory[index],
                              onRemovePressed: () =>
                                  _removeHistoryAtIndex(index),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchListTile extends StatelessWidget {
  const SearchListTile(
      {super.key, required this.title, required this.onRemovePressed});

  final String title;
  final VoidCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.clear,
          size: 18,
        ),
        padding: EdgeInsets.zero,
        alignment: Alignment.centerRight,
        onPressed: () => onRemovePressed,
      ),
    );
  }
}
