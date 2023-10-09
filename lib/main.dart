import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './autoload/autoloader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final genreController = Get.put(GenreController());
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xff93B1A6),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xff5C8374),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: const Color(0xff5C8374).withOpacity(0.6),
          textColor: const Color(0xff5C8374).withOpacity(0.6),
          iconColor: const Color(0xff5C8374).withOpacity(0.6),
        ),
      ),
      home: FutureBuilder(
        future: genreController.fetchData(),
        builder: ((ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashScreen();
          } else {
            return const HomeScreen();
          }
        }),
      ),
    );
  }
}
