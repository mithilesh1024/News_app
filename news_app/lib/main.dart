import 'package:flutter/material.dart';
import 'package:newsapp/screens/Categories_selector_page.dart';
import 'package:newsapp/screens/HomePage.dart';
import 'package:newsapp/screens/Saved_news.dart';
import 'package:newsapp/screens/SearchPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
      routes: {
        '/second': (_) => Category(),
        '/third': (_) => Search(),
        '/fourth': (_) => SavedNews()
      },
    );
  }
}
