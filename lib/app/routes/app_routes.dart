import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/news_feed.dart';
import 'package:news_app/screens/search_country_news.dart';

class AppRoutes{
  static const String home = '/';
  static const String country_news = '/country_news';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(NewsFeed(), settings);
      case country_news:
        return _buildRoute(SearchCountryNews(), settings);

      default:
        return _buildRoute(Scaffold(), settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}