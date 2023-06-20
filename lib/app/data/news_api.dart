

import 'package:dio/dio.dart';
import 'package:news_app/models/model.dart';
import 'package:news_app/models/model.dart';

import '../../models/model.dart';
import '../../models/model.dart';
import 'endpoints.dart';

class NewsApi {

  late String countryname;

  Future<List<NewsQueryModel>> getCountry({required String countryname}) async {
    try {
      final response = await Dio().get(
          'https://newsapi.org/v2/top-headlines?country=$countryname&apiKey=920d527c3d8642eea92327e0e59936ef');
      print('hello');
      final data = response.data['articles'];
      return List<NewsQueryModel>.from(data.map((item) => NewsQueryModel.fromMap(item)));
    } catch (e) {
      throw e;
    }
  }
}