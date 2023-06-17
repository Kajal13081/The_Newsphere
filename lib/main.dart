import 'package:flutter/material.dart';
import 'package:news_app/screens/demo.dart';
import 'package:news_app/screens/newsView.dart';
import 'package:news_app/screens/news_feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Outfit'),
      home: NewsFeed(),
    );
  }
}