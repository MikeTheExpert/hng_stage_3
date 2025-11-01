import 'package:flutter/material.dart';
import 'package:hng_stage_3/pages/browse_page.dart';
import 'package:hng_stage_3/pages/favourites_page.dart';
import 'package:hng_stage_3/pages/home_page.dart';
import 'package:hng_stage_3/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => MyHomePage(),
        '/favourite': (context) =>MyFavourite(),
        '/settings':(context) =>MySettings(),
        '/browse':(context) =>MyBrowserPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(),
    );
  }
}
