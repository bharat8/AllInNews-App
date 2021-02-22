import 'package:all_in_news/widgets/BuildList.dart';
import 'package:all_in_news/src/blocs/NewsBloc.dart';
import 'package:all_in_news/src/models/news_item.dart';
import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search for news";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, query);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != null) {
      newsBloc.fetchSearchNews(query);
    } else
      newsBloc.fetchAllNews("general", 1);
    return StreamBuilder(
        stream: newsBloc.searchNews,
        builder: (context, AsyncSnapshot<NewsModel> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return BuildList(
            snapshot: snapshot,
          );
        });
  }
}
