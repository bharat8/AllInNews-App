import 'package:AllinNews/src/models/news_item.dart';
import 'package:AllinNews/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsFetcher = BehaviorSubject<NewsModel>();
  final _searchFetcher = BehaviorSubject<NewsModel>();
  int totalpages = 1;

  Stream<NewsModel> get allNews => _newsFetcher.stream;
  Stream<NewsModel> get searchNews => _searchFetcher.stream;

  Future fetchAllNews(String category, int pageNumber) async {
    if (pageNumber <= totalpages) {
      NewsModel newsModel =
          await _repository.fetchAllNews(category, pageNumber);
      if (_newsFetcher.value == null) {
        totalpages = newsModel.totalPages;
        _newsFetcher.sink.add(newsModel);
      } else {
        _newsFetcher.value.articles.addAll(newsModel.articles);
        _newsFetcher.sink.add(_newsFetcher.value);
      }
    }
  }

  fetchSearchNews(String query) async {
    NewsModel newsModel = await _repository.searchAllNews(query);
    _searchFetcher.sink.add(newsModel);
  }

  connectionClose() {
    _newsFetcher.close();
    _searchFetcher.close();
  }
}

final newsBloc = NewsBloc();
