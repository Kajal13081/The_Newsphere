import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/app/data/news_api.dart';

import '../app/routes/app_routes.dart';
import '../models/model.dart';

class CountryProvider extends ChangeNotifier{

  NewsApi _newsApi = NewsApi();

  List<NewsQueryModel>? _newsQueryModel;
  List<NewsQueryModel>? get newsQueryModel => _newsQueryModel;

  void setLoading(bool value) {
    notifyListeners();
  }


  Future<void> getCountryNews({required String countryname, required BuildContext ctx}) async {
    setLoading(true);
    try {
      final List<NewsQueryModel> response =
      await _newsApi.getCountry(countryname: countryname);
      _newsQueryModel = response;

      Navigator.pushNamed(
        ctx,
        AppRoutes.country_news,

      );
    } catch (e) {
    }
  }

}