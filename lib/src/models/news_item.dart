class NewsModel {
  String _status;
  int _totalresults;
  int _pageSize = 10;
  List<Articles> _articles = [];

  NewsModel.fromJson(Map<String, dynamic> fetched) {
    _status = fetched['status'];
    _totalresults = fetched['totalResults'];
    List<Articles> temp = [];
    for (int i = 0; i < fetched['articles'].length; i++) {
      Articles articles = Articles(fetched['articles'][i]);
      temp.add(articles);
    }
    _articles = temp;
  }

  int get totalPages {
    if (_totalresults % _pageSize == 0)
      return _totalresults % _pageSize;
    else
      return (_totalresults / _pageSize).floor() + 1;
  }

  List<Articles> get articles => _articles;
  int get totalresults => _totalresults;
  String get status => _status;
}

class Articles {
  Map<String, dynamic> _source;
  String _author;
  String _title;
  String _description;
  String _url;
  String _urlToImage;
  String _publishedAt;
  String _content;

  Articles(articles) {
    _source = articles['source'];
    _author = articles['author'];
    _title = articles['title'];
    _description = articles['description'];
    _url = articles['url'];
    _urlToImage = articles['urlToImage'];
    _publishedAt = articles['publishedAt'];
    _content = articles['content'];
  }

  Map<String, dynamic> get source => _source;
  String get author => _author;
  String get title => _title;
  String get description => _description;
  String get url => _url;
  String get urlToImage => _urlToImage;
  String get publishedAt => _publishedAt;
  String get content => _content;

  String get postedTime {
    int meanTime =
        (DateTime.now().hour - DateTime.parse(publishedAt).hour).abs();
    int meanDate = (DateTime.now().day - DateTime.parse(publishedAt).day).abs();
    if (meanTime < 0 && meanDate == 0) {
      return "${24 - meanTime} hours ago";
    } else if (meanTime > 0 && meanDate == 0)
      return "$meanTime hours ago";
    else
      return "$meanDate days ago";
  }
}
