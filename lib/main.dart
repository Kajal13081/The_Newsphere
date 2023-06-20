import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/notifier/country_provider.dart';
import 'package:news_app/screens/demo.dart';
import 'package:news_app/screens/newsView.dart';
import 'package:news_app/screens/news_feed.dart';
import 'package:provider/provider.dart';

import 'app/routes/app_routes.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountryProvider>(
      create: (_) => CountryProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Outfit'),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
