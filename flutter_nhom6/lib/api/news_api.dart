import 'package:dio/dio.dart';
import '../models/news.dart';

class NewsAPI {
  Future<List<News>> getNews() async {
    var dio = Dio();
    var response = await dio.get("https://dummyjson.com/products");

    if (response.statusCode == 200) {
      List data = response.data["products"];
      return data.map((e) => News.fromJson(e)).toList();
    }

    return [];
  }
}

var newsApi = NewsAPI();
