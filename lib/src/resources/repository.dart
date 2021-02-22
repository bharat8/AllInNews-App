import 'package:all_in_news/src/models/news_item.dart';
import 'package:all_in_news/src/resources/news_api_provider.dart';

class Repository {
  final newsApiProvider = NewsApiProvider();

  Future<NewsModel> fetchAllNews(String category, int pageNumber) =>
      newsApiProvider.fetchNewsList(category, pageNumber);

  Future<NewsModel> searchAllNews(String query) =>
      newsApiProvider.searchList(query);
}
