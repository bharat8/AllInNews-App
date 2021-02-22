import 'dart:convert';

import 'package:all_in_news/src/models/news_item.dart';
import 'package:http/http.dart' show Client;

class NewsApiProvider {
  Client client = Client();
  final _apiKey = 'e50178d1f1cd4bb7b37e70b3e99fe550';

  Future<NewsModel> fetchNewsList(String category, int page) async {
    final response = await client.get(
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&pageSize=10&page=$page&apiKey=$_apiKey");
    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future<NewsModel> searchList(String query) async {
    final response = await client.get(
        "https://newsapi.org/v2/everything?q=$query&pageSize=100&apiKey=$_apiKey");
    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Load');
    }
  }
}
