import 'package:AllinNews/src/models/news_item.dart';
import 'package:AllinNews/src/resources/news_api_provider.dart';

class Repository {
  final newsApiProvider = NewsApiProvider();

  Future<NewsModel> fetchAllNews(String category, int pageNumber) =>
      newsApiProvider.fetchNewsList(category, pageNumber);

  Future<NewsModel> searchAllNews(String query) =>
      newsApiProvider.searchList(query);
}
